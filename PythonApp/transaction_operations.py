from PythonApp.dbconnection import *
import re as regexp


def add_transaction(
        date: str,
        username: str,
        transactionname: str,
        categoryname: str,
        price: float,
        currency: str,
        shopname: str
) -> bool:
    if not regexp.match('^\d\d\d\d-\d\d-\d\d$', date):
        print("wrong date format")
        return False
    if not (
            regexp.match('[A-Za-z0-9]+', username) and
            regexp.match('[A-Za-z0-9]+', transactionname) and
            regexp.match('[A-Z]{3}', currency) and
            regexp.match('[A-Za-z0-9]', shopname) and
            regexp.match('[A-Za-z]', categoryname)
    ):
        print("wrong input format")
        return False
    try:
        execute_sql_command(
            database_connect(),
            "CALL add_transaction(" +
            date + ", " +
            "\"" + username + "\", " +
            "\"" + transactionname + "\", " +
            "\"" + categoryname + "\", " +
            str(price) + ", " +
            "\"" + currency + "\", " +
            "\"" + shopname + "\");"
        )
        return True
    except Exception as e:
        print(e)
        return False


def monthly_balance(
        month: int,
        year: int,
        username: str
) -> dict:
    if not regexp.match('[A-Za-z0-9]+', username):
        return {'stacktrace': 'don\'t be a hacker!'}
    try:
        transactions = execute_sql_command(
            database_connect(),
            "SELECT * FROM transactions " +
            "WHERE YEAR(transactions.Date) = " + str(year) + " " +
            "AND MONTH(transactions.Date) = " + str(month) + " " +
            "AND transactions.NickName = \"" + username + "\";"
        )
        total_spent = 0.0
        for i in range(len(transactions)):
            total_spent = total_spent + transactions[i][5]
        return {'total_spent': total_spent, 'history': transactions}
    except Exception as e:
        return {'stacktrace': e}

