import os
import mysql.connector

#_____CONNECT TO DB_____##############################
def db():
    try:
        db = mysql.connector.connect(
            host = os.environ.get("DB_HOST", "mariadb"),
            user = os.environ["DB_USER"],
            password = os.environ["DB_PASSWORD"],
            database = os.environ["DB_NAME"]
        )
        cursor = db.cursor(dictionary=True)
        return db, cursor
    except Exception as e:
        print(e, flush=True)
        raise Exception("Database under maintenance", 500)


def close(db, cursor):
    if cursor: cursor.close()
    if db: db.close()
##############################_____CONNECT TO DB_____#