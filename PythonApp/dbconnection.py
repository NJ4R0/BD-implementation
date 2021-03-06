import pymysql as mariadb

"""
this file contains operations on database
"""

CONST_DBHOST = 'localhost'
CONST_DBUSER = 'project'
CONST_DBPASSWD = 'x3roVm'


def database_connect(dbhost=CONST_DBHOST, dbuser=CONST_DBUSER, dbpasswd=CONST_DBPASSWD) -> mariadb.Connection:
    """
    connects to database. you can store the return to some variable to not repeat that
    :param dbhost: name or IP of mariadb host
    :param dbuser: mariadb username
    :param dbpasswd: password of username
    :return: returns Connection class
    """
    conn = mariadb.connect(
        host=dbhost,
        user=dbuser,
        passwd=dbpasswd,
        db='tu_wpisz_tytul',
        charset='utf8'
    )
    return conn


def execute_sql_command(connection: mariadb.Connection, statement: str):
    # Warning! that is insecure and musn't be used as GUI function!
    """
    executes any sql command
    :param connection: Connection class on wich query will operate
    :param statement: String to execute sql query
    :return:
    """
    isinstance(connection, mariadb.Connection.__class__)
    cursor = connection.cursor()
    try:
        cursor.execute(statement)
        connection.commit()
        return cursor.fetchall()
    except Exception as e:
        connection.rollback()
        print(e)
