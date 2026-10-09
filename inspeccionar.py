
from pathlib import Path
from collections import defaultdict
from dbfread import DBF
import csv

CARPETA = Path(
    r"D:\Universidad\Cursos\Inteligencia de Negocios"
    r"\Semana 6\Proyecto\C34Data\tempc34"
)

SALIDA = CARPETA.parent / "inventario_dbf.csv"

if not CARPETA.exists():
    raise FileNotFoundError(f"No existe la carpeta: {CARPETA}")

tablas = {}
campos_por_nombre = defaultdict(list)

for archivo in sorted(CARPETA.glob("*.DBF")):
    try:
        tabla = DBF(
            str(archivo),
            encoding="cp1252",
            load=True
        )
        registros = list(tabla)
        nombre_tabla = archivo.stem.upper()

        campos = []
        for campo in tabla.fields:
            nombre = campo.name.upper()
            valores = [r.get(campo.name) for r in registros]
            no_vacios = [
                v for v in valores
                if v is not None and str(v).strip() != ""
            ]
            distintos = set(str(v).strip() for v in no_vacios)

            info = {
                "tabla": nombre_tabla,
                "campo": nombre,
                "tipo": campo.type,
                "longitud": campo.length,
                "decimales": getattr(campo, "decimal_count", 0),
                "filas": len(registros),
                "vacios": len(registros) - len(no_vacios),
                "distintos": len(distintos),
                "unico_no_vacio": (
                    len(distintos) == len(no_vacios)
                    and len(no_vacios) > 0
                ),
            }
            campos.append(info)
            campos_por_nombre[nombre].append(info)

        tablas[nombre_tabla] = {
            "archivo": archivo.name,
            "registros": registros,
            "campos": campos,
        }

        print(f"OK: {archivo.name} — {len(registros)} filas")

    except Exception as error:
        print(f"ERROR: {archivo.name}: {error}")

with SALIDA.open("w", newline="", encoding="utf-8-sig") as f:
    columnas = [
        "tabla", "campo", "tipo", "longitud", "decimales",
        "filas", "vacios", "distintos", "unico_no_vacio"
    ]
    escritor = csv.DictWriter(f, fieldnames=columnas)
    escritor.writeheader()

    for datos in tablas.values():
        for campo in datos["campos"]:
            escritor.writerow(campo)

print("\n=== CAMPOS COMPARTIDOS ENTRE TABLAS ===")
for nombre, apariciones in sorted(campos_por_nombre.items()):
    nombres_tablas = sorted({x["tabla"] for x in apariciones})
    if len(nombres_tablas) > 1:
        print(f"{nombre}: {', '.join(nombres_tablas)}")

print(f"\nInventario guardado en: {SALIDA}")