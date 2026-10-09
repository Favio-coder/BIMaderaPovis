"""El usuario ejecuta este programa para cargar SQL Server. Nunca crea ni borra tablas."""
import argparse
import base64
from datetime import date, datetime
from decimal import Decimal
import getpass
import gzip
import hashlib
import json
from pathlib import Path
from zipfile import ZipFile
from esquema import ESQUEMA

BASE=Path(__file__).resolve().parent
ROOT=BASE.parents[1]


def q(s):
    return '['+s.replace(']',']]')+']'


def sha(data):
    return hashlib.sha256(data).hexdigest()


def signature(fields):
    return [(f['nombre'],f['tipo'],f['longitud'],f['decimales'],f['binario'],f['nullable_fox']) for f in fields]


def validate_package(folder):
    text=(folder/'manifest.json').read_text(encoding='utf-8')
    m=json.loads(text)
    if m['version']!=1:
        raise ValueError('Versión de paquete no soportada.')
    archive=folder/'origen.zip'
    if sha(archive.read_bytes())!=m['origen_zip_sha256']:
        raise ValueError('Hash ZIP no coincide.')
    with ZipFile(archive) as z:
        if set(z.namelist())!=set(m['archivos']):
            raise ValueError('Lista de originales inconsistente.')
        for name,checksum in m['archivos'].items():
            if sha(z.read(name))!=checksum:
                raise ValueError(f'Original alterado: {name}')
    for t in m['tablas']:
        if Path(t['archivo']).name!=t['archivo']:
            raise ValueError('Nombre de archivo de paquete inválido.')
        if sha((folder/t['archivo']).read_bytes())!=t['sha256']:
            raise ValueError('Hash de datos no coincide: '+t['nombre'])
        count=deleted=errors=0
        with gzip.open(folder/t['archivo'],'rt',encoding='utf-8') as stream:
            for line in stream:
                r=json.loads(line)
                count+=1
                if r['recno']!=count:
                    raise ValueError('Secuencia física inconsistente.')
                deleted+=int(r['eliminado'])
                errors+=bool(r['errores'])
        if (count-deleted,deleted,errors)!=(t['activas'],t['eliminadas'],t['errores']):
            raise ValueError('Conteos no coinciden con manifiesto: '+t['nombre'])
    return m,text


def connection(config):
    import pyodbc
    c=json.loads(config.read_text(encoding='utf-8-sig'))
    def escape(v):
        return '{'+str(v).replace('}','}}')+'}'
    s=';'.join(k+'='+escape(v) for k,v in [('DRIVER',c['driver']),('SERVER',c['servidor']),('DATABASE',c['base'])])
    s+=';Encrypt=yes;TrustServerCertificate='+('yes' if c.get('confiar_certificado_local',False) else 'no')
    if c['autenticacion']=='windows':
        s+=';Trusted_Connection=yes'
    elif c['autenticacion']=='sql':
        s+=';UID='+escape(c['usuario'])+';PWD='+escape(getpass.getpass('Contraseña SQL (no se guarda): '))
    else:
        raise ValueError('Autenticación debe ser windows o sql.')
    conn=pyodbc.connect(s,autocommit=False,timeout=15)
    conn.execute('SET XACT_ABORT ON; SET NOCOUNT ON;')
    return conn


def lock(cur, resource):
    cur.execute("IF @@TRANCOUNT=0 BEGIN TRANSACTION; DECLARE @r int; EXEC @r=sys.sp_getapplock @Resource=?, @LockMode='Exclusive', @LockOwner='Transaction', @LockTimeout=0; IF @r<0 THROW 51100,N'Otra carga está trabajando con este origen.',1;",resource)


def bronze(conn,args,m,manifest_text):
    cur=conn.cursor()
    lock(cur,'C34:'+args.empresa+':'+str(args.ejercicio))
    packagehash=sha(manifest_text.encode('utf-8'))
    existing=cur.execute('SELECT LoteId,BronzeListo FROM bronze.Lote WHERE Empresa=? AND Ejercicio=? AND OrigenHash=?',args.empresa,args.ejercicio,m['origen_hash']).fetchone()
    if existing:
        if not existing[1]:
            raise ValueError('Lote existente incompleto: revisar estado antes de continuar.')
        print(f'Paquete ya cargado. LoteId={existing[0]}; no se duplicó.')
        return
    cur.execute('INSERT bronze.Lote(Empresa,Ejercicio,OrigenHash,PaqueteHash,OrigenZip,ManifestJson) OUTPUT inserted.LoteId VALUES(?,?,?,?,?,?)',
                args.empresa,args.ejercicio,m['origen_hash'],packagehash,(args.paquete/'origen.zip').read_bytes(),manifest_text)
    lote=int(cur.fetchone()[0])
    statement='INSERT bronze.Registro(LoteId,Tabla,RegistroOrigen,Eliminado,RegistroRaw,DatosJson,ErroresJson) VALUES(?,?,?,?,?,?,?)'
    for t in m['tablas']:
        batch=[]
        with gzip.open(args.paquete/t['archivo'],'rt',encoding='utf-8') as stream:
            for line in stream:
                r=json.loads(line)
                batch.append((lote,t['nombre'],r['recno'],r['eliminado'],base64.b64decode(r['raw']),
                    json.dumps(r['datos'],ensure_ascii=False) if r['datos'] is not None else None,
                    json.dumps(r['errores'],ensure_ascii=False)))
                if len(batch)==500:
                    cur.executemany(statement,batch)
                    batch=[]
            if batch:
                cur.executemany(statement,batch)
        print('Bronze:',t['nombre'],t['activas'],'activas')
    actual=cur.execute('SELECT COUNT_BIG(*) FROM bronze.Registro WHERE LoteId=?',lote).fetchone()[0]
    expected=sum(t['activas']+t['eliminadas'] for t in m['tablas'])
    if actual!=expected:
        raise ValueError('No concilian los conteos Bronze.')
    cur.execute('UPDATE bronze.Lote SET BronzeListo=1 WHERE LoteId=?',lote)
    print(f'Bronze preparado para commit: LoteId={lote}; filas={actual}. Usa este LoteId en el paso Silver.')


def value(v,f):
    if v is None:
        return None
    typ=f['tipo']
    if typ=='0' or (typ in ('C','M') and f['binario']):
        return base64.b64decode(v)
    if typ=='N':
        return Decimal(v)
    if typ=='D':
        return date.fromisoformat(v)
    if typ=='T':
        return datetime.fromisoformat(v)
    return v


def dependency_order(schema):
    pending=set(schema['tablas'])
    order=[]
    while pending:
        ready=sorted(n for n in pending if not any(r['hija']==n and r['padre'] in pending for r in schema['relaciones']))
        if not ready:
            raise ValueError('Ciclo en las dependencias de carga.')
        order.extend(ready)
        pending.difference_update(ready)
    return order


def silver(conn,args):
    cur=conn.cursor()
    lock(cur,'C34:Silver:'+str(args.lote))
    lote=cur.execute('SELECT BronzeListo,SilverListo,ManifestJson FROM bronze.Lote WHERE LoteId=?',args.lote).fetchone()
    if not lote or not lote[0]:
        raise ValueError('El lote Bronze no existe o no terminó.')
    if lote[1]:
        print('Silver ya está cargado para este lote; no se duplicó.')
        return
    m=json.loads(lote[2])
    schema=ESQUEMA
    tables={t['nombre']:t for t in m['tablas']}
    if set(tables)!=set(schema['tablas']):
        raise ValueError('Cambió el conjunto de tablas. Actualizar el DDL y esquema antes de promover Silver.')
    for name,t in tables.items():
        if signature(t['campos'])!=signature(schema['tablas'][name]):
            raise ValueError('Cambió la estructura de '+name+'. Revisar la nueva versión; Bronze se conserva.')
    for name in dependency_order(schema):
        t=tables[name]
        fields=schema['tablas'][name]
        field_names=['_BronzeId','_LoteId','_RegistroOrigen']+[f['nombre'] for f in fields]
        statement='INSERT silver.'+q(name)+' ('+','.join(map(q,field_names))+') VALUES('+','.join('?' for _ in field_names)+')'
        rows=cur.execute('SELECT BronzeId,RegistroOrigen,DatosJson,ErroresJson FROM bronze.Registro WHERE LoteId=? AND Tabla=? AND Eliminado=0 ORDER BY RegistroOrigen',args.lote,name).fetchall()
        accepted=rejected=0
        batch=[]
        for row in rows:
            errors=json.loads(row[3])
            if errors:
                cur.execute('INSERT control.Rechazo(BronzeId,Motivo) VALUES(?,?)',row[0],row[3])
                rejected+=1
                continue
            data=json.loads(row[2])
            converted=[value(data[f['nombre']],f) for f in fields]
            batch.append(tuple([row[0],args.lote,row[1]]+converted))
            accepted+=1
            if len(batch)==500:
                cur.executemany(statement,batch)
                batch=[]
        if batch:
            cur.executemany(statement,batch)
        actual=cur.execute('SELECT COUNT_BIG(*) FROM silver.'+q(name)+' WHERE _LoteId=?',args.lote).fetchone()[0]
        if actual!=accepted or accepted+rejected!=t['activas']:
            raise ValueError('No concilia Silver: '+name)
        cur.execute('INSERT control.CargaTabla VALUES(?,?,?,?,?,?)',args.lote,name,t['activas'],t['eliminadas'],accepted,rejected)
        print(f'Silver: {name}; aceptadas={accepted}; rechazadas={rejected}')
    cur.execute('UPDATE bronze.Lote SET SilverListo=1 WHERE LoteId=?',args.lote)


def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('paso',choices=['validar-paquete','bronze','silver'])
    p.add_argument('--config',type=Path,default=ROOT/'config'/'conexion.json')
    p.add_argument('--paquete',type=Path)
    p.add_argument('--empresa')
    p.add_argument('--ejercicio',type=int)
    p.add_argument('--lote',type=int)
    args=p.parse_args()
    if args.paso in ('validar-paquete','bronze'):
        if not args.paquete:
            p.error('Falta --paquete.')
        m,text=validate_package(args.paquete)
        if args.paso=='validar-paquete':
            print(f"Paquete verificado sin conexión SQL: {len(m['tablas'])} tablas, {sum(t['activas'] for t in m['tablas'])} activas.")
            return
        if not args.empresa or len(args.empresa)>80 or not args.ejercicio or not 1900<=args.ejercicio<=2100:
            p.error('Bronze necesita --empresa (hasta 80 caracteres) y --ejercicio (1900–2100).')
    if args.paso=='silver' and not args.lote:
        p.error('Silver necesita --lote.')
    conn=connection(args.config)
    try:
        if args.paso=='bronze':
            bronze(conn,args,m,text)
        else:
            silver(conn,args)
        conn.commit()
        print('COMMIT realizado. Paso terminado.')
    except BaseException:
        conn.rollback()
        print('ROLLBACK: este intento no se confirmó. Los pasos previos permanecen conservados.')
        raise
    finally:
        conn.close()


if __name__=='__main__':
    main()
