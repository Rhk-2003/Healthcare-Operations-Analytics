from sqlalchemy import create_engine
from config import DB_CONFIG

engine = create_engine(

    f"postgresql+psycopg2://"
    f"{DB_CONFIG['user']}:"
    f"{DB_CONFIG['password']}@"
    f"{DB_CONFIG['host']}:"
    f"{DB_CONFIG['port']}/"
    f"{DB_CONFIG['database']}"

)

from sqlalchemy import text

def test_connection():

    try:

        with engine.connect() as conn:

            conn.execute(text("SELECT 1"))

        return True

    except Exception as e:

        print(e)

        return False