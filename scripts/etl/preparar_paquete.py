"""Extrae un paquete local reproducible. No importa drivers ni conecta a SQL."""
import argparse
import base64
import gzip
import hashlib
import json
from pathlib import Path
import sys
from datetime import date
from decimal import Decimal
from zipfile import ZipFile, ZIP_DEFLATED

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'analisis'))
from generar_modelo import read_table


def sha(data):
    return hashlib.sha256(data).hexdigest()


def serialized(value):
    if isinstance(value, bytes):
        return base64.b64encode(value).decode('ascii')
    if isinstance(value, (date, Decimal)):
        return str(value)
    return value


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--origen', required=True, type=Path)
    parser.add_argument('--salida', required=True, type=Path)
    args = parser.parse_args()
    if args.salida.exists():
        raise SystemExit('La salida ya existe. Elige otra carpeta para no sobrescribir un paquete.')
    files = sorted(p for p in args.origen.iterdir() if p.is_file())
    dbfs = [p for p in files if p.suffix.upper()=='.DBF']
    if not dbfs:
        raise SystemExit('No se encontraron DBF.')
    hashes = {p.name:sha(p.read_bytes()) for p in files}
    args.salida.mkdir(parents=True)
    manifest = {'version':1, 'archivos':hashes, 'tablas':[]}
    with ZipFile(args.salida/'origen.zip', 'w', ZIP_DEFLATED) as archive:
        for p in files:
            archive.writestr(p.name, p.read_bytes())
    for path in dbfs:
        t = read_table(path)
        raw = path.read_bytes()
        headerlen = int.from_bytes(raw[8:10], 'little')
        recordlen = int.from_bytes(raw[10:12], 'little')
        errors = {}
        for error in t['errores']:
            errors.setdefault(error['registro'], []).append(error)
        data_path = args.salida/(t['nombre']+'.jsonl.gz')
        active = iter(t['rows'])
        with gzip.open(data_path,'wt',encoding='utf-8',newline='\n') as stream:
            for index in range(t['cabecera']):
                record = raw[headerlen+index*recordlen:headerlen+(index+1)*recordlen]
                deleted = record[:1] == b'*'
                values = None if deleted else {k:serialized(v) for k,v in next(active).items()}
                row = {'recno':index+1, 'eliminado':deleted,
                       'raw':base64.b64encode(record).decode('ascii'),
                       'datos':values, 'errores':errors.get(index+1,[])}
                stream.write(json.dumps(row,ensure_ascii=False,separators=(',',':'))+'\n')
        manifest['tablas'].append({'nombre':t['nombre'], 'activas':t['filas'],
            'eliminadas':t['eliminados'], 'errores':len(errors), 'campos':t['campos'],
            'archivo':data_path.name, 'sha256':sha(data_path.read_bytes())})
    if hashes != {p.name:sha(p.read_bytes()) for p in files}:
        raise RuntimeError('Cambió el origen durante la extracción. Este paquete no está completo; repetir en otra carpeta.')
    manifest['origen_zip_sha256'] = sha((args.salida/'origen.zip').read_bytes())
    manifest['origen_hash'] = sha(json.dumps(hashes,sort_keys=True).encode('utf-8'))
    # El manifiesto se escribe al final: su ausencia identifica un paquete incompleto.
    (args.salida/'manifest.json').write_text(json.dumps(manifest,ensure_ascii=False,indent=2),encoding='utf-8')
    print(f"Paquete local listo: {len(dbfs)} tablas, {sum(t['activas'] for t in manifest['tablas'])} activas, {sum(t['errores'] for t in manifest['tablas'])} filas con errores.")
    print(args.salida.resolve())


if __name__=='__main__':
    main()
