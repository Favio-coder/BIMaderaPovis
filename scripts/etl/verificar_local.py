"""Audita el paquete sin importar pyodbc ni abrir una conexión a SQL Server."""
import ast
import base64
from collections import Counter
import gzip
import json
from pathlib import Path
from zipfile import ZipFile
from cargar import validate_package, value, dependency_order, signature
from esquema import ESQUEMA

BASE=Path(__file__).resolve().parent
ROOT=BASE.parents[1]
folder=ROOT/'local'/'paquetes'/'2020'
manifest,_=validate_package(folder)
schema=ESQUEMA
order=dependency_order(schema)
assert len(order)==110 and len(set(order))==110
for r in schema['relaciones']:
    assert order.index(r['padre'])<order.index(r['hija'])
for path in BASE.glob('*.py'):
    ast.parse(path.read_text(encoding='utf-8'))

accepted={}
rejected=[]
physical=0
with ZipFile(folder/'origen.zip') as archive:
    files={n.upper():n for n in archive.namelist()}
    for t in manifest['tablas']:
        name=t['nombre']
        assert signature(t['campos'])==signature(schema['tablas'][name])
        dbf=archive.read(files[name+'.DBF'])
        header=int.from_bytes(dbf[8:10],'little')
        size=int.from_bytes(dbf[10:12],'little')
        records=[]
        with gzip.open(folder/t['archivo'],'rt',encoding='utf-8') as stream:
            for line in stream:
                r=json.loads(line)
                physical+=1
                offset=header+(r['recno']-1)*size
                assert base64.b64decode(r['raw'])==dbf[offset:offset+size]
                assert r['eliminado']==(dbf[offset:offset+1]==b'*')
                if r['eliminado']:
                    continue
                if r['errores']:
                    rejected.append((name,r['recno'],r['errores']))
                    continue
                data={f['nombre']:value(r['datos'][f['nombre']],f) for f in t['campos']}
                for f in t['campos']:
                    v=data[f['nombre']]
                    if v is not None and f['sql'].startswith('nvarchar(') and f['tipo']=='C':
                        assert len(v.encode('utf-16-le'))//2 <= f['longitud']
                    if v is not None and f['tipo']=='N':
                        assert v==v.quantize(__import__('decimal').Decimal(1).scaleb(-f['decimales']))
                        assert abs(v)<__import__('decimal').Decimal(10)**(f['longitud']-f['decimales'])
                records.append(data)
        accepted[name]=records

def key(r,cols):
    return tuple(r[c].rstrip(' ') if isinstance(r[c],str) else r[c] for c in cols)

for r in schema['relaciones']:
    parent=[key(row,r['campos_padre']) for row in accepted[r['padre']]]
    assert len(parent)==len(set(parent)),r
    parent=set(parent)
    assert all(key(row,r['campos_hija']) in parent for row in accepted[r['hija']]),r

headerkey=['C_AÑO','C_MES','C_OPER','N_OPER']
parents={key(r,headerkey) for r in accepted['VOUCHER']}
assert len(parents)==len(accepted['VOUCHER'])==1528
assert all(key(r,headerkey) in parents for r in accepted['DET_VOUCH'])
assert all(r['C_AÑO']=='2020' and r['F_OPER'].year==2020 and r['C_MES'] in [f'{i:02}' for i in range(14)] for r in accepted['VOUCHER'])
assert len(accepted['DET_VOUCH'])==7346
assert len(rejected)==1 and rejected[0][:2]==('AGENTES',2020)
assert sum(map(len,accepted.values()))==22025
ddl=(ROOT/'sql'/'medallion'/'01_crear_capas.sql').read_text(encoding='utf-8-sig')
assert ddl.count('CREATE TABLE silver.')==110
for name,fields in schema['tablas'].items():
    assert 'CREATE TABLE silver.['+name+']' in ddl
    for f in fields:
        assert '['+f['nombre']+'] '+f['sql'] in ddl
summary={'modo':'sin conexión SQL', 'tablas':len(accepted),'registros_fisicos_verificados':physical,
         'silver_aceptadas':sum(map(len,accepted.values())), 'rechazadas':len(rejected),
         'relaciones_comprobadas_sobre_aceptados':len(schema['relaciones']),
         'cabeceras':len(accepted['VOUCHER']),'detalles':len(accepted['DET_VOUCH']),
         'operaciones':dict(Counter(r['C_OPER'] for r in accepted['VOUCHER'])),
         'sql_ejecutado':False,'resultado':'correcto'}
reports=ROOT/'local'/'reportes'
reports.mkdir(parents=True,exist_ok=True)
(reports/'verificacion_local.json').write_text(json.dumps(summary,ensure_ascii=False,indent=2),encoding='utf-8')
print(json.dumps(summary,ensure_ascii=False))
