from pathlib import Path
from cargar import connection

conexion = None

try:
    config = Path(__file__).resolve().parents[2] / "config" / "conexion.json"
    conexion = connection(config)

    resultado = conexion.execute(
        "SELECT @@SERVERNAME, DB_NAME(), SUSER_SNAME()"
    ).fetchone()

    print("Conexión exitosa")
    print("Servidor:", resultado[0])
    print("Base de datos:", resultado[1])
    print("Usuario:", resultado[2])

except Exception as error:
    print("Error de conexión:")
    print(error)

finally:
    if conexion is not None:
        conexion.close()
