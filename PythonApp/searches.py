from PythonApp.dbconnection import *


def list_all_shops() -> tuple:
    """
    lists all shops
    example usage:
    xd = list_all_shops()
    xd[i][0] - ID of shop in i position
    xd[i][1] - name of shop in i position
    :return: returns a tuple of shops.
    """
    try:
        connection = database_connect(CONST_DBHOST, CONST_DBUSER, CONST_DBPASSWD)
        return execute_sql_command(connection, "SELECT * FROM shops")
    except Exception as e:
        print(e)
