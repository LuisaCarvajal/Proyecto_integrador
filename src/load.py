from typing import Dict

from pandas import DataFrame
from sqlalchemy.engine.base import Engine


def load(data_frames: Dict[str, DataFrame], database: Engine):
    """Load the dataframes into the sqlite database.

    Args:
        data_frames (Dict[str, DataFrame]): A dictionary with keys as the table names
        and values as the dataframes.
    """
    # TODO: Implementa esta función. Por cada DataFrame en el diccionario, debes
    # usar pandas.DataFrame.to_sql() para cargar el DataFrame en la base de datos
    # como una tabla.
    # Para el nombre de la tabla, utiliza las claves del diccionario `data_frames`.
    try:
        for table_name, df in data_frames.items():
            df.to_sql(name=table_name, con=database, if_exists="replace", index=False)  # Usar database directamente
            print(f"Datos cargados en la tabla: {table_name}")
    except Exception as e:
        print(f"Error al cargar los datos: {e}")
