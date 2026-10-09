from pathlib import Path
from collections import Counter
from decimal import Decimal
import csv
import hashlib
import json
from dbfread import DBF, FieldParser

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / 'C34Data' / 'tempc34'
OUT = Path(__file__).resolve().parent


class ExactParser(FieldParser):
    def parseN(self, field, data):
        value = data.strip(b' \x00')
        return Decimal(value.decode('ascii')) if value else None


def digest(p):
    return hashlib.sha256(p.read_bytes()).hexdigest()


def q(name):
    return '[' + name.replace(']', ']]') + ']'


def sqltype(f):
    t, n, d = f['tipo'], f['longitud'], f['decimales']
    if t in ('C', 'M') and f['binario']:
        return 'varbinary(max)' if t == 'M' else f'varbinary({n})'
    return {'C': f'nvarchar({n})', 'M': 'nvarchar(max)',
            'N': f'decimal({n},{d})', 'I': 'int', 'L': 'bit',
            'D': 'date', 'T': 'datetime2(3)', '0': f'varbinary({n})'}[t]


def read_table(path):
    table = DBF(str(path), encoding='cp1252', char_decode_errors='strict')
    raw = path.read_bytes()
    fields, offset, nullbit = [], 1, 0
    for i, f in enumerate(table.fields):
        flag = raw[32 + i * 32 + 18]
        nullable = bool(flag & 2)
        meta = dict(nombre=f.name, tipo=f.type, longitud=f.length,
                    decimales=f.decimal_count, nullable_fox=nullable,
                    binario=bool(flag & 4), offset=offset,
                    bit_nulo=nullbit if nullable else None)
        meta['sql'] = sqltype(meta)
        fields.append(meta)
        offset += f.length
        if nullable:
            nullbit += 1
    if offset != table.header.recordlen:
        raise ValueError(f'{path.name}: longitud inconsistente')
    nullfield = next((f for f in fields if f['tipo'] == '0'), None)
    rows, deleted, errors = [], 0, []
    # El parser público de dbfread interpreta tipos y memos; aquí aplicamos
    # el bitmap NULL y conservamos el orden/número físico de cada registro.
    with table._open_memofile() as memo:
        parser = ExactParser(table, memo)
        for index in range(table.header.numrecords):
            start = table.header.headerlen + index * table.header.recordlen
            record = raw[start:start + table.header.recordlen]
            if len(record) != table.header.recordlen or record[0:1] not in (b' ', b'*'):
                raise ValueError(f'{path.name}: registro físico inválido {index + 1}')
            if record[:1] == b'*':
                deleted += 1
                continue
            bitmap = 0
            if nullfield:
                n = nullfield
                bitmap = int.from_bytes(record[n['offset']:n['offset'] + n['longitud']], 'little')
            row = {}
            for f, meta in zip(table.fields, fields):
                value = record[meta['offset']:meta['offset'] + f.length]
                try:
                    if meta['bit_nulo'] is not None and bitmap & (1 << meta['bit_nulo']):
                        row[f.name] = None
                    elif f.type == '0' or (f.type == 'C' and meta['binario']):
                        row[f.name] = value
                    else:
                        row[f.name] = parser.parse(f, value)
                except Exception as exc:
                    errors.append(dict(registro=index + 1, campo=f.name, error=str(exc)))
                    row[f.name] = None
            rows.append(row)
    for f in fields:
        vals = [r[f['nombre']] for r in rows]
        populated = [v for v in vals if v is not None and v != '']
        failed = sum(e['campo'] == f['nombre'] for e in errors)
        f.update(nulos=sum(v is None for v in vals) - failed, errores_lectura=failed, vacios=sum(v == '' for v in vals),
                 distintos=len(set(populated)),
                 unico_completo=bool(vals) and len(set(populated)) == len(vals))
    return dict(nombre=path.stem.upper(), campos=fields, filas=len(rows),
                eliminados=deleted, cabecera=table.header.numrecords,
                errores=errors, rows=rows, sha256=digest(path))


def key(row, cols):
    # SQL Server ignora espacios finales en comparaciones de cadenas.
    return tuple(row[c].rstrip(' ') if isinstance(row[c], str) else row[c] for c in cols)


def present(k):
    return all(v is not None and v != '' for v in k)


def relation(tables, child, cc, parent, pc, reason):
    if child not in tables or parent not in tables:
        return None
    cf = {f['nombre']: f for f in tables[child]['campos']}
    pf = {f['nombre']: f for f in tables[parent]['campos']}
    if not set(cc) <= cf.keys() or not set(pc) <= pf.keys():
        return None
    ckeys = [key(r, cc) for r in tables[child]['rows']]
    pkeys = [key(r, pc) for r in tables[parent]['rows']]
    good = [k for k in ckeys if present(k)]
    parentset = set(pkeys)
    duplicates = len(pkeys) - len(parentset)
    parentempty = sum(not present(k) for k in pkeys)
    missing = sum(k not in parentset for k in good)
    empty = len(ckeys) - len(good)
    compatible = all(cf[c]['sql'] == pf[p]['sql'] for c, p in zip(cc, pc))
    if any(e['campo'] in cc for e in tables[child]['errores']) or any(e['campo'] in pc for e in tables[parent]['errores']):
        status = 'ERROR_LECTURA'
    elif duplicates or parentempty:
        status = 'CLAVE_PADRE_NO_VALIDA'
    elif missing:
        status = 'HUERFANOS'
    elif not good or not pkeys:
        status = 'SIN_EVIDENCIA'
    elif not compatible:
        status = 'REVISAR_TIPOS'
    elif empty:
        status = 'REVISAR_VACIOS'
    else:
        status = 'COMPATIBLE_EN_DATOS'
    return dict(hija=child, campos_hija=cc, padre=parent, campos_padre=pc,
                motivo=reason, estado=status, filas_hija=len(ckeys),
                evaluadas=len(good), vacias=empty, huerfanas=missing,
                duplicadas_padre=duplicates, vacias_padre=parentempty,
                tipos_identicos=compatible)


def build_relations(tables):
    candidates = {}
    def add(child, cc, parent, pc=None, why='Código y catálogo por nombre; confirmar semántica'):
        pc = pc or cc
        r = relation(tables, child, cc, parent, pc, why)
        if r:
            candidates[(child, tuple(cc), parent, tuple(pc))] = r
    masters = {'C_AFP':'AFPS', 'C_ALMA':'ALMACEN', 'C_BANC':'BANCOS',
               'C_CARG':'CARGOS', 'C_COST':'CENTCOST', 'C_CUEN':'SC_PLAN',
               'C_PROD':'PRODUCTO', 'C_COMP':'TIPCOMPROB', 'C_DOCU':'TIPDCTOS',
               'C_OPER':'OPERACION', 'C_UBIG':'UBIGEO', 'C_VEND':'VENDEDOR',
               'C_MATR':'MATASIE', 'C_TALL':'TALLAS', 'C_UBIC':'UBICA',
               'C_SITU':'SITUACION', 'C_META':'METAPPTO', 'C_PLAN':'TIPPLA',
               'K_MEDI':'TIPOUNID', 'K_EXIS':'TIPEXPROD', 'K_MEDP':'TIPMEDPAGO',
               'K_SERV':'TIPSERV', 'K_MOVI':'MVTOCTA', 'K_SITU':'SITUMVTOCTA',
               'C_ISLA':'ISLAS', 'C_TANQ':'ALMCOMBCA', 'C_TIPO':'TIPOPER',
               'C_TRAN':'CONDUCTOR', 'C_TL08':'TABLA08', 'C_TL30':'TABLA30',
               'C_TL19S':'TABLA19S', **{f'C_DES{i}':f'DESPROD{i}' for i in range(1,6)}}
    for name, t in tables.items():
        names = {f['nombre'] for f in t['campos']}
        for code, parent in masters.items():
            if name != parent and code in names:
                add(name, [code], parent)
        for code in ('K_MONE', 'K_MONEC'):
            if code in names:
                add(name, [code], 'MONEDA', ['C_MONE'], 'Alias de moneda; confirmar equivalencia')
        for code in ('C_DEBE','C_HABE','C_CTAC','C_CTAV','C_CTAM','C_CUEP','C_CUE2','C_CUE3','C_CUE4'):
            if code in names:
                add(name, [code], 'SC_PLAN', ['C_CUEN'], 'Cuenta contable por rol; confirmar uso')
    voucher = ['C_AÑO','C_MES','C_OPER','N_OPER']
    for child in ('DET_VOUCH','ASIDEST','CTACTE','LISTCOMPA','RENDCAJA','BIENES','ENTRADAS','SALIDAS'):
        add(child, voucher, 'VOUCHER', why='Cabecera y movimiento contable; clave compuesta propuesta')
    for child, parent, cols in [
        ('ENTITEM','ENTRADAS',['ID_ENTR']), ('SALITEM','SALIDAS',['C_COMP','N_SERI','N_COMP']),
        ('PRESTADET','PRESTAMO',['ID_PRES']), ('DETTRANSAC','TRANSAC',['C_COMO','N_SERO','N_OPER']),
        ('MATASIEDET','MATASIE',['C_MATR']), ('DATPERSITEMS','DATPERS',['C_DOCU','N_DOCU']),
        ('DEUDAS','ASOCIADO',['C_DOCU','N_DOCU']), ('MEDICION','ASOCIADO',['C_DOCU','N_DOCU']),
        ('AGRESPRO','AGRECRED',['N_RUC','N_ITEM','N_CRED']),
        ('LETRAS','DEUDAS',['N_DEUD']), ('DETCTACTE','CTACTE',['N_DEUD']),
        ('DEPBIEN','BIENES',['C_BIEN']), ('PPTO_DET','PRESPTO',['C_PPTO'])]:
        add(child, cols, parent, why='Cabecera/detalle o maestro; clave propuesta por estructura')
    for child in ('VOUCHER','DET_VOUCH','ENTRADAS','SALIDAS','CTACTE','PRESTAMO','LISTCOMPA'):
        add(child, ['N_RUC'], 'AGENTES', why='Documento fiscal; comprobar unicidad, no asumir que es PK')
    return sorted(candidates.values(), key=lambda r:(r['padre'],r['hija'],r['campos_hija']))


def main():
    source_files = sorted(p for p in SOURCE.iterdir() if p.suffix.upper() in ('.DBF','.FPT'))
    hashes = {p.name:digest(p) for p in source_files}
    tables = {}
    for path in sorted(SOURCE.glob('*.DBF')):
        t = read_table(path)
        tables[t['nombre']] = t
        print(f"{t['nombre']}: {t['filas']} activas, {t['eliminados']} eliminadas, {len(t['errores'])} errores", flush=True)
    rels = build_relations(tables)
    with (ROOT/'C34Data'/'inventario_dbf.csv').open(encoding='utf-8-sig', newline='') as f:
        inventory = list(csv.DictReader(f))
    inv = {(r['tabla'].upper(),r['campo'].upper()):r for r in inventory}
    differences = []
    for name,t in tables.items():
        for field in t['campos']:
            old = inv.get((name,field['nombre'].upper()))
            if old is None or int(old['filas']) != t['filas'] or old['tipo'] != field['tipo'] or int(old['longitud']) != field['longitud'] or int(old['decimales']) != field['decimales']:
                differences.append(f"{name}.{field['nombre']}: ausente o estructura/conteo distinto al CSV")
    for name, field in inv:
        if name not in tables or field not in {f['nombre'].upper() for f in tables[name]['campos']}:
            differences.append(f'{name}.{field}: solo figura en el CSV')
    if hashes != {p.name:digest(p) for p in source_files}:
        raise RuntimeError('Los archivos de origen cambiaron durante el análisis; repetir con una copia estable.')
    report = dict(tablas=[{k:v for k,v in t.items() if k!='rows'} for t in tables.values()],
                  relaciones=rels, diferencias_inventario=differences, archivos_sha256=hashes)
    (OUT/'perfil.json').write_text(json.dumps(report,ensure_ascii=False,indent=2,default=str),encoding='utf-8')
    generate_sql(tables, rels)
    generate_md(tables, rels, differences)
    print('RESUMEN', json.dumps(dict(tablas=len(tables),activas=sum(t['filas'] for t in tables.values()),
          eliminadas=sum(t['eliminados'] for t in tables.values()),vacias=sum(t['filas']==0 for t in tables.values()),
          errores=sum(len(t['errores']) for t in tables.values()), relaciones=Counter(r['estado'] for r in rels),
          diferencias_inventario=len(differences)),ensure_ascii=False))


def generate_sql(tables, rels):
    lines = ['-- C34: estructura de 110 DBF. No contiene datos ni crea una base de datos.',
             '-- Elegir una base de datos vacía/de desarrollo en SSMS antes de ejecutar.',
             '-- Sección 1: tablas. Sección 2: relaciones opcionales. Sección 3: propuestas pendientes.',
             '-- Los campos originales admiten NULL para la carga inicial. _NullFlags se conserva como binario.',
             '-- Hay incidencias de origen: consultar el MD antes de preparar una carga de datos.',
             '-- Textos BIN2 para evitar fusionar códigos por mayúsculas o acentos.',
             'SET NOCOUNT ON;', 'SET XACT_ABORT ON;', 'GO',
             'BEGIN TRY', 'BEGIN TRANSACTION;',
             "IF SCHEMA_ID(N'c34') IS NULL EXEC(N'CREATE SCHEMA [c34]');"]
    for name,t in tables.items():
        lines += [f"IF OBJECT_ID(N'c34.{name}', N'U') IS NOT NULL THROW 50001, N'Ya existe c34.{name}; no se sobrescribe.', 1;"]
        fields = [f'    [__c34_id] bigint IDENTITY(1,1) NOT NULL CONSTRAINT {q("PK_"+name)} PRIMARY KEY']
        for f in t['campos']:
            typ = f['sql'] + (' COLLATE Latin1_General_100_BIN2' if f['sql'].startswith('nvarchar') else '')
            fields.append(f"    {q(f['nombre'])} {typ} NULL")
        lines += [f"-- {name}: {t['filas']} registros activos, {t['eliminados']} eliminados en DBF.",
                  f'CREATE TABLE [c34].{q(name)} (', ',\n'.join(fields), ');']
    lines += ['COMMIT TRANSACTION;', 'END TRY', 'BEGIN CATCH',
              'IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;', 'THROW;', 'END CATCH;', 'GO',
              '-- SECCIÓN 2. Ejecutar aparte, después de cargar y revisar la semántica.',
              '-- Cambiar a 1 solo para aplicar las relaciones compatibles con la copia analizada.',
              '-- Las restricciones vuelven a comprobar los datos actuales con WITH CHECK.',
              'DECLARE @AplicarRelaciones bit = 0;', 'IF @AplicarRelaciones = 1', 'BEGIN',
              'BEGIN TRY', 'BEGIN TRANSACTION;']
    valid = [r for r in rels if r['estado']=='COMPATIBLE_EN_DATOS']
    unique_keys = sorted({(r['padre'],tuple(r['campos_padre'])) for r in valid})
    for i,(parent,cols) in enumerate(unique_keys,1):
        lines += [f'ALTER TABLE [c34].{q(parent)} ADD CONSTRAINT {q("UQ_C34_"+str(i))} UNIQUE ('+', '.join(map(q,cols))+');']
    for i,r in enumerate(valid,1):
        lines += [f"-- {r['hija']} -> {r['padre']}: {r['evaluadas']} filas comprobadas, 0 huérfanas.", fk_sql(r, f'FK_C34_{i}')]
    lines += ['COMMIT TRANSACTION;', 'END TRY', 'BEGIN CATCH', 'IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;',
              'THROW;', 'END CATCH;', 'END;', 'GO',
              '-- SECCIÓN 3. Candidatas NO ejecutables hasta resolver las observaciones.',
              '-- Además de la FK se necesita una clave UNIQUE válida en las columnas del padre.',
              '-- Los vacíos de texto no equivalen a NULL. No convertirlos sin una regla de negocio.']
    for i,r in enumerate(rels,1):
        if r['estado']!='COMPATIBLE_EN_DATOS':
            lines += [f"-- {r['estado']}: evaluadas={r['evaluadas']}, vacías={r['vacias']}, huérfanas={r['huerfanas']}, duplicadas padre={r['duplicadas_padre']}, vacías padre={r['vacias_padre']}.",
                      '-- '+fk_sql(r,f'FK_PROPUESTA_{i}')]
    (OUT/'C34_tablas_relaciones.sql').write_text('\n'.join(lines)+'\n',encoding='utf-8-sig')


def fk_sql(r,name):
    return f"ALTER TABLE [c34].{q(r['hija'])} WITH CHECK ADD CONSTRAINT {q(name)} FOREIGN KEY (" + ', '.join(map(q,r['campos_hija'])) + f") REFERENCES [c34].{q(r['padre'])} (" + ', '.join(map(q,r['campos_padre'])) + ');'


def generate_md(tables, rels, differences):
    active=sum(t['filas'] for t in tables.values())
    deleted=sum(t['eliminados'] for t in tables.values())
    errors=sum(len(t['errores']) for t in tables.values())
    lines=['# C34: plan de migración y modelo entidad-relación', '',
           'Fecha: 8 de octubre de 2026. Fuente: `C34Data/tempc34` y `C34Data/inventario_dbf.csv`.', '',
           '## Alcance y resultado del procesamiento', '',
           f'Se leyeron las {len(tables)} tablas DBF y sus memos FPT. Hay **{active:,} registros activos**, **{deleted:,} registros marcados como eliminados** y **{sum(t["filas"]==0 for t in tables.values())} tablas vacías**. Se detectaron **{errors} errores de interpretación** en registros activos. Las {len(differences)} diferencias de estructura/conteo con el inventario se detallan abajo.', '',
           'Se generó el esquema SQL, sin conectar a SQL Server ni cargar registros. Los DBF/FPT se abrieron en lectura y sus hashes SHA-256 no cambiaron durante el procesamiento. El detalle reproducible está en `perfil.json` y el generador en `generar_modelo.py`.', '',
           'No se encontraron DBC ni CDX en la carpeta. Las relaciones son hipótesis basadas en nombres, estructura y comparación completa de claves de registros activos; no son relaciones originales recuperadas. Una coincidencia de datos no confirma por sí sola la regla de negocio. No se extraen reglas, triggers ni índices de la aplicación FoxPro.', '',
           '## Hallazgos que requieren atención', '',
           '- `AGENTES` no figura en el inventario original y contiene 2.069 filas. El registro físico 2020, campo `L_AGEN`, tiene el byte `0x8D`, no definido en Windows-1252. El script original captura errores por tabla y puede haber omitido esta tabla por ese motivo. Confirmar el texto con el sistema original antes de corregirlo; no usar reemplazo silencioso de caracteres.',
           '- Las estadísticas separan errores de lectura de valores NULL. El valor ilegible no se usa para confirmar claves. No se generaron registros transformados ni se sustituyeron datos en los archivos fuente.',
           '- `DET_VOUCH → VOUCHER`: los 7.346 detalles coinciden con una cabecera mediante `(C_AÑO, C_MES, C_OPER, N_OPER)` y la clave de cabecera es única en la copia.',
           '- `AGENTES.N_RUC` tiene 39 repeticiones adicionales respecto de valores distintos, contando vacíos. No se puede imponer como clave única sin revisar la identificación de agentes.',
           '- `CTAPDT.C_CUEN → SC_PLAN.C_CUEN` deja 21 filas sin correspondencia; `AGENTES.C_UBIG → UBIGEO.C_UBIG`, 54; `BIENES → VOUCHER`, 10. Pueden ser problemas de datos o hipótesis de relación incorrectas.',
           '- `VOUCHER.C_ISLA → ISLAS.C_ISLA` deja 1.453 referencias sin padre; `ISLAS` está vacía. Confirmar si son códigos predeterminados o si falta ese catálogo.', '',
           '## Plan de trabajo', '',
           '| Etapa | Trabajo y criterio de salida | Estado |', '|---|---|---|',
           '| 1. Diagnóstico | Leer cabeceras, tipos, memos, bitmap NULL, conteos y contrastar inventario | Realizado |',
           '| 2. Modelo inicial | Crear las 110 tablas, proponer relaciones simples y compuestas, medir duplicados y huérfanos | Realizado; semántica pendiente |',
           '| 3. Confirmación funcional | Confirmar claves, relaciones, ámbito de empresa/año, códigos vacíos y registros eliminados con el sistema original | Pendiente |',
           '| 4. Preparar SQL Server | Elegir instancia/base y ejecutar sección 1 del SQL en una base de desarrollo | Lo realizará el usuario |',
           '| 5. ETL | Cargar primero maestros y luego cabeceras/detalles; lectura decimal exacta, Unicode, fechas y NULL; registrar rechazos | Pendiente |',
           '| 6. Conciliación | Comparar filas por tabla, nulos, sumas monetarias por moneda/período y documentos, claves duplicadas y huérfanos | Pendiente |',
           '| 7. Integridad | Aplicar UNIQUE/FK aprobadas con WITH CHECK; diseñar índices según consultas reales | Pendiente |',
           '| 8. Puesta en servicio | Copia estable final, repetir conciliación, respaldo, cambio de aplicación y posibilidad de retorno | Pendiente |', '',
           '## Decisiones de diseño', '',
           '- Esquema SQL `c34`; nombres originales, incluida la Ñ de `C_AÑO`. Se añade `__c34_id bigint IDENTITY` como PK técnica independiente de las claves del negocio.',
           '- `C` → `nvarchar(n)`; `N` → `decimal(longitud, decimales)`; `I` → `int`; `D` → `date`; `T` → `datetime2(3)`; `L` → `bit`; `M` → `nvarchar(max)` o binario según bandera. La longitud numérica incluye signo/separador en DBF: usarla como precisión SQL deja margen sin reducir los dígitos.',
           '- Codificación indicada en las 110 cabeceras: Windows-1252. Se utiliza decodificación estricta. Se conservan los ceros iniciales de códigos/documentos. Validar visualmente nombres y textos en la futura carga.',
           '- Los campos originales se crean nullable para la carga inicial. Esto no afirma que todos sean opcionales en el negocio. El diccionario muestra la bandera nullable original.',
           '- `_NullFlags` es un bitmap interno, no una entidad ni una clave. Se conserva como varbinary para trazabilidad y se aplica al leer valores; el importador futuro también debe hacerlo.',
           '- La comparación de claves conserva mayúsculas y acentos. El DDL usa `Latin1_General_100_BIN2`. El perfil solo retira espacios finales de claves; no normaliza ni corrige datos.',
           '- El perfil de relaciones excluye filas marcadas como eliminadas; se contabilizan aparte y no se han interpretado sus campos. Confirmar su política de conservación antes de cargar.',
           '- No se agregan eliminaciones en cascada. Las FK y UNIQUE candidatas están separadas de la creación inicial.', '',
           '## Cómo usar el archivo SQL', '',
           '1. Abrir `C34_tablas_relaciones.sql` en SSMS y seleccionar la base de desarrollo. El script no crea la base ni contiene INSERT.',
           '2. Ejecutar la sección 1 para crear todas las tablas dentro de una transacción. Si existe una tabla con ese nombre en `c34`, se detiene sin sobrescribirla.',
           '3. Cargar y conciliar los datos cuando se prepare el ETL. Los campos `__c34_id` los genera SQL Server.',
           '4. Revisar funcionalmente cada relación compatible. Ejecutar solo la sección 2, con `@AplicarRelaciones = 1`, para agregar sus UNIQUE/FK. Por defecto vale 0. No ejecutar otra vez la sección 1.',
           '5. La sección 3 contiene propuestas comentadas que requieren resolver huérfanos, vacíos, tipos o falta de evidencia. Antes de activarlas hay que definir una clave UNIQUE válida del padre.', '',
           'El SQL se revisó por correspondencia con los metadatos y cobertura de tablas/campos. No se ha ejecutado ni compilado en un motor SQL Server. Las FK se comprueban nuevamente al aplicarlas; su activación repetida requiere gestionar los nombres ya existentes.', '',
           '## Evidencia de relaciones', '',
           '| Estado | Cantidad | Interpretación |','|---|---:|---|']
    labels={'COMPATIBLE_EN_DATOS':'Padre único/completo, tipos iguales, claves hijas completas y sin huérfanos; pendiente confirmación funcional.',
            'SIN_EVIDENCIA':'No hay suficientes filas pobladas para validar.', 'HUERFANOS':'Hay claves hijas que no existen en el padre propuesto.',
            'CLAVE_PADRE_NO_VALIDA':'La clave del padre contiene duplicados o vacíos.', 'REVISAR_TIPOS':'Los tipos o longitudes SQL propuestos difieren.',
            'REVISAR_VACIOS':'Hay claves hijas vacías; definir opcionalidad/normalización.',
            'ERROR_LECTURA':'Algún campo de la clave no pudo interpretarse; no validar esta relación.'}
    for status,count in sorted(Counter(r['estado'] for r in rels).items()):
        lines.append(f'| {status} | {count} | {labels[status]} |')
    lines += ['', 'Los conteos de huérfanos son filas, no valores distintos. Las claves vacías se cuentan aparte y no se confunden con coincidencias válidas. Las claves compuestas se comparan completas.', '',
              '## Diagramas entidad-relación por área', '',
              'Las líneas discontinuas representan relaciones propuestas, no restricciones activas. La cardinalidad `0..1` a `0..N` es la cardinalidad de diseño candidata, pendiente validación. Un diagrama no corrige los problemas registrados en la matriz. Se incluyen los vínculos principales para que sea legible; la matriz posterior contiene todas las candidatas y el diccionario todas las tablas.', '']
    groups={'Contabilidad': {'VOUCHER','DET_VOUCH','ASIDEST','SC_PLAN','OPERACION','CENTCOST','MONEDA','AGENTES'},
            'Compras, ventas e inventario': {'ENTRADAS','ENTITEM','SALIDAS','SALITEM','PRODUCTO','ALMACEN','PRODSTOCK','TIPCOMPROB'},
            'Personas y financiamiento': {'DATPERS','DATPERSITEMS','AFPS','CARGOS','PRESTAMO','PRESTADET','ASOCIADO','DEUDAS','LETRAS','TRANSAC','DETTRANSAC'}}
    for title,names in groups.items():
        lines += [f'### {title}', '', '```mermaid', 'erDiagram']
        selected=[r for r in rels if r['hija'] in names and r['padre'] in names]
        for name in sorted(names):
            lines += [f'    {name} {{', '        bigint __c34_id PK']
            cols={c for r in selected for c in (r['campos_hija'] if r['hija']==name else r['campos_padre'] if r['padre']==name else [])}
            for col in sorted(cols):
                lines.append(f'        string {col.replace("Ñ","N")}')
            lines += ['    }']
        for r in selected:
            label=','.join(r['campos_hija']).replace('Ñ','N')
            mark='compatible' if r['estado']=='COMPATIBLE_EN_DATOS' else 'revisar'
            lines += [f'    {r["padre"]} |o..o{{ {r["hija"]} : "{label} ({mark})"']
        lines += ['```','']
    lines += ['En los diagramas se usa `N` por `Ñ` solo en las etiquetas técnicas para portabilidad. `string` es una representación simplificada; los tipos exactos están en el diccionario y en SQL.', '',
              '## Matriz completa de relaciones propuestas', '',
              '| Hija (campos) | Padre (campos) | Estado | Evaluadas | Vacías hija | Huérfanas | Duplicadas padre | Vacías padre |',
              '|---|---|---|---:|---:|---:|---:|---:|']
    for r in rels:
        lines.append(f"| {r['hija']} ({', '.join(r['campos_hija'])}) | {r['padre']} ({', '.join(r['campos_padre'])}) | {r['estado']} | {r['evaluadas']} | {r['vacias']} | {r['huerfanas']} | {r['duplicadas_padre']} | {r['vacias_padre']} |")
    lines += ['', '## Comparación con el inventario', ''] + (['- '+s for s in differences] or ['Coinciden las tablas, nombres de campos, tipos, longitudes, decimales y conteos activos. Los conteos de vacíos/distintos se recalcularon aplicando NULL de FoxPro; no se asumen equivalentes a los del script original.'])
    lines += ['', '## Inventario de tablas', '', '| Tabla | Activas | Eliminadas | Campos DBF |', '|---|---:|---:|---:|']
    for name,t in tables.items():
        lines.append(f"| {name} | {t['filas']} | {t['eliminados']} | {len(t['campos'])} |")
    lines += ['', '## Diccionario de datos completo', '', 'Se conservan nombres técnicos; las descripciones funcionales deben confirmarse con el sistema original. “Único completo” describe esta copia, no declara una clave de negocio.', '']
    for name,t in tables.items():
        lines += [f'### {name}', '', '| Campo | FoxPro | SQL Server | NULL en FoxPro | Nulos activos | Errores lectura | Vacíos texto | Distintos no vacíos | Único completo |', '|---|---|---|---|---:|---:|---:|---:|---|']
        for f in t['campos']:
            lines.append(f"| {f['nombre']} | {f['tipo']}({f['longitud']},{f['decimales']}) | {f['sql']} | {'Sí' if f['nullable_fox'] else 'No'} | {f['nulos']} | {f['errores_lectura']} | {f['vacios']} | {f['distintos']} | {'Sí' if f['unico_completo'] else 'No'} |")
        lines.append('')
    lines += ['## Referencias técnicas', '',
              '- [SQL Server: precisión y escala](https://learn.microsoft.com/en-us/sql/t-sql/data-types/precision-scale-and-length-transact-sql): precisión decimal máxima 38; los campos de esta copia están dentro del límite.',
              '- [dbfread: tipos de campo](https://dbfread.readthedocs.io/en/latest/field_types.html): interpretación de tipos y memos.',
              '- [Visual FoxPro: estructura DBF](https://www.vfphelp.com/help/html/465e7a94-51b7-4e0c-98f9-432864fe5bcc.htm): banderas de campos y registros.']
    (OUT/'C34_plan_y_modelo.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')


if __name__ == '__main__':
    main()
