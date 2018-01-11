from PythonApp.dbconnection import *
import re as regexp

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


def simple_list_my_transactions(username: str) -> tuple:
    """
    lists all user's transactions. for now in very simple way, maybe it will be changed later
    format:
    single_record = list_my_transactions('examplejanusz')[i]
    single_record[0] - TransactionID
    single_record[1] - Date
    single_record[2] - username
    single_record[3] - salename
    single_record[4] - money spent
    single_record[5] - Currency
    single_record[6] - ShopID
    :param username: name of user
    :return: returns list of transactions in a tuple
    """
    if not regexp.match('[A-Za-z0-9]+'):
        print("username invalid. dont be a hacker")
        return ()
    try:
        connection = database_connect()
        return execute_sql_command(connection, "SELECT * FROM transactions WHERE NickName = \"" + username + "\"")
    except Exception as e:
        print(e)
        return ()

