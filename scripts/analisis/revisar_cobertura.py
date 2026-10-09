"""Relectura de DBF para comprobar cobertura funcional y temporal."""
from generar_modelo import read_table, SOURCE, OUT, digest
from collections import Counter
from datetime import date
from decimal import Decimal
import json

OUT.mkdir(parents=True, exist_ok=True)
tables = {p.stem.upper(): read_table(p) for p in sorted(SOURCE.glob('*.DBF'))}
dates = {}
years = {}
for name, t in tables.items():
    for f in t['campos']:
        col = f['nombre']
        values = [r[col] for r in t['rows'] if r[col] is not None]
        if f['tipo'] in ('D', 'T'):
            vals = [v for v in values if isinstance(v, date)]
            if vals:
                dates[name+'.'+col] = dict(min=str(min(vals)), max=str(max(vals)),
                                           por_anio=dict(Counter(v.year for v in vals)))
        if 'AÑO' in col or col in ('PERIODO','C_MMAA'):
            years[name+'.'+col] = dict(Counter(str(v) for v in values))

vouchers = tables['VOUCHER']['rows']
details = tables['DET_VOUCH']['rows']
cols = ['C_AÑO','C_MES','C_OPER','N_OPER']
def key(r):
    return tuple(r[c] for c in cols)
headers = {key(r): r for r in vouchers}
labels = {r['C_OPER']:r['L_OPER'] for r in tables['OPERACION']['rows']}
ops = []
for op,n in sorted(Counter(r['C_OPER'] for r in vouchers).items()):
    subset = [r for r in vouchers if r['C_OPER']==op]
    det = [r for r in details if r['C_OPER']==op]
    ops.append(dict(codigo=op,operacion=labels.get(op),cabeceras=n,detalles=len(det),
                    fecha_min=str(min(r['F_OPER'] for r in subset)),
                    fecha_max=str(max(r['F_OPER'] for r in subset)),
                    periodos=dict(sorted(Counter(r['C_MES'] for r in subset).items())),
                    total_no_nulo=sum(r['S_TOTA'] is not None for r in subset),
                    total_no_cero=sum(r['S_TOTA'] not in (None,Decimal(0)) for r in subset),
                    cuentas=len({r['C_CUEN'] for r in det}),
                    ruc_poblados=sum(bool(r['N_RUC']) for r in subset)))

account_names = {r['C_CUEN']:r['L_CUEN'] for r in tables['SC_PLAN']['rows']}
account_counts = Counter(r['C_CUEN'] for r in details)
# Los nombres orientan la investigación; no clasifican por sí solos el proceso.
inventory_accounts = [dict(cuenta=k,nombre=account_names.get(k,''),filas=n)
    for k,n in sorted(account_counts.items())
    if any(w in account_names.get(k,'').upper() for w in
           ('MERCADER','EXISTENC','INVENTAR','ALMAC','SUMINISTR','MATERIA','COSTO DE VENT','PRODUCTO'))]

product_fields = []
for name,t in tables.items():
    for f in t['campos']:
        if f['nombre'] in ('C_PROD','N_STOK','S_STOK','STOCKMIN','S_CANT','N_REGI','N_REGF'):
            values=[r[f['nombre']] for r in t['rows']]
            product_fields.append(dict(tabla=name,campo=f['nombre'],filas=t['filas'],
              poblados=sum(v is not None and v!='' for v in values),
              no_cero=sum(v not in (None,'',0) for v in values)))

extras=[]
metadata=[]
for p in sorted(SOURCE.iterdir()):
    if p.suffix.upper() not in ('.DBF','.FPT'):
        raw=p.read_bytes()
        extras.append(dict(archivo=p.name,bytes=len(raw),cabecera_hex=raw[:32].hex()))
        if p.suffix.lower()=='.mgr' and raw[:1]==b'\x30':
            meta=read_table(p)
            metadata=[{k:r[k] for k in ('L_NOMT','L_DESC','_KEY1','_KEY2','_KEY3','_KEY4','_KEY5')} for r in meta['rows']]

report=dict(conteos={n:dict(activas=t['filas'],eliminadas=t['eliminados']) for n,t in tables.items()},
            operaciones=ops,fechas=dates,periodos=years,cuentas_posible_inventario=inventory_accounts,
            campos_producto_stock=product_fields,otros_archivos=extras,metadatos_mgr=metadata,
            cabeceras_unicas=len(headers)==len(vouchers),
            detalles_sin_cabecera=sum(key(r) not in headers for r in details),
            archivos_sin_cambios=all(digest(SOURCE/(n+'.DBF'))==t['sha256'] for n,t in tables.items()))
(OUT/'cobertura_datos.json').write_text(json.dumps(report,ensure_ascii=False,indent=2),encoding='utf-8')
lines=['# Revisión de cobertura de datos C34','',
       'Se volvieron a leer los 110 DBF de `C34Data/tempc34`. Los conteos incluyen comprobación de registros marcados como eliminados. No se modificaron los DBF.', '',
       '## Operaciones registradas en VOUCHER y DET_VOUCH','',
       '| Código | Operación según catálogo | Cabeceras | Detalles | Fecha mínima | Fecha máxima | Cabeceras con total no nulo |',
       '|---|---|---:|---:|---|---|---:|']
for r in ops:
    lines.append(f"| {r['codigo']} | {r['operacion']} | {r['cabeceras']} | {r['detalles']} | {r['fecha_min']} | {r['fecha_max']} | {r['total_no_nulo']} |")
lines+=['','Estos son asientos/cabeceras contables, no necesariamente comprobantes comerciales únicos. Los detalles son líneas contables, no productos vendidos. Las medidas monetarias necesitan validar signos, anulaciones, moneda y notas de crédito antes de agregarse.',
        '', '## Conclusión de la búsqueda ampliada', '',
        '- Sí hay registros contables de compras y ventas en VOUCHER y DET_VOUCH aunque sus tablas operativas estén vacías.',
        '- PRODUCTO contiene un registro, con N_STOK = -1 y F_ACTP vacío. MEDIPROD contiene un registro. No constituyen una serie histórica de existencias.',
        '- ENTITEM, ENTRADAS, SALITEM, SALIDAS y PRODSTOCK tienen cero registros activos y cero eliminados. No hay movimientos por producto para reconstruir kardex con esta entrega.',
        '- Se encontraron 54 líneas contables en cuentas cuyo nombre es MERCADERIAS MANUFACTURADAS (601111 y 611111). Esto aporta importes contables; no movimientos físicos por producto.',
        '- El archivo auxiliar _r23m34g.mgr también tiene formato DBF: contiene 108 registros de configuración, con descripciones de tablas y expresiones de claves/índices. Se extrajo su contenido relevante a cobertura_datos.json. Ayudará a revisar el modelo; no contiene nuevas compras, ventas ni existencias. La configuración no prueba por sí sola unicidad ni integridad referencial.',
        '- En ventas no hay cabeceras con períodos 04 y 05; en compras no hay con 04, 05 y 06. Confirmar con el dueño de la información si refleja la actividad real o una entrega parcial.', '',
        '## Existencia física de registros por tabla','', '| Tabla | Activos | Eliminados |', '|---|---:|---:|']
for n,t in tables.items():
    lines.append(f"| {n} | {t['filas']} | {t['eliminados']} |")
lines+=['','## Fechas y períodos','',
        '`VOUCHER.F_OPER` corresponde a 2020, desde 2020-01-01 hasta 2020-12-31. C_AÑO también es 2020 en VOUCHER, DET_VOUCH, ASIDEST y DEPBIEN. Hay seis cabeceras con fecha de comprobante de 2019 y fechas de digitación hasta 2022. Los bienes tienen adquisiciones entre 2010 y 2020. Estas fechas no convierten la copia en varios ejercicios completos. La evidencia por campo está en `cobertura_datos.json`.','',
        '## Cómo incorporar más años','',
        '1. Guardar cada entrega en una carpeta independiente y registrar empresa, ejercicio, archivo de origen y lote de carga.',
        '2. Comparar estructuras y comprobar si cada entrega es anual, acumulada o una corrección de una copia previa.',
        '3. Diseñar claves de origen con empresa y ejercicio cuando corresponda. Los códigos locales pueden repetirse entre años; una PK IDENTITY no detecta duplicación de negocio.',
        '4. Consolidar maestros con reglas de equivalencia. Conservar historia cuando cambien los atributos que deban analizarse históricamente.',
        '5. Extender fecha y período contable. Separar períodos especiales 00 y 13 de los meses calendario.',
        '6. Cargar por lotes repetibles y conciliar por empresa/año/moneda. Evitar sumar saldos de apertura y cierre como movimientos ordinarios.',
        '7. Reperfilar claves y relaciones sobre todos los años. Las relaciones compatibles con 2020 pueden fallar al incorporar otra copia.','',
        'El SQL anterior describe una copia del origen; debe ampliarse con trazabilidad y reglas de consolidación antes de realizar una carga de múltiples años.']
(OUT/'C34_revision_cobertura.md').write_text('\n'.join(lines)+'\n',encoding='utf-8')
print(json.dumps({k:v for k,v in report.items() if k in ('operaciones','cuentas_posible_inventario','campos_producto_stock','cabeceras_unicas','detalles_sin_cabecera','archivos_sin_cambios')},ensure_ascii=False,indent=2))
print('PERIODOS',json.dumps(years,ensure_ascii=False))
print('FECHAS_CLAVE',json.dumps({k:v for k,v in dates.items() if k.startswith(('VOUCHER.','BIENES.','DEPBIEN.','DATPERS.'))},ensure_ascii=False))
