from flask import Flask, render_template, json, request, redirect, session
from flask.ext.mysql import MySQL
from PythonApp.searches import *
from PythonApp.transaction_operations import *
from PythonApp.account_operations import *
import datetime

app = Flask(__name__)
app.secret_key = 'Why on heaven do we need to have so much work to do?'

mysql = MySQL()

# MySQL configurations
app.config['MYSQL_DATABASE_USER'] = CONST_DBUSER
app.config['MYSQL_DATABASE_PASSWORD'] = CONST_DBPASSWD
app.config['MYSQL_DATABASE_DB'] = 'tu_wpisz_tytul'
app.config['MYSQL_DATABASE_HOST'] = CONST_DBHOST
mysql.init_app(app)


@app.route("/")
def main():
    return render_template('index.html')


@app.route('/showSignUp')
def showSignUp():
    return render_template('signup.html')


@app.route('/showSignin')
def showSignin():
    return render_template('signin.html')


@app.route('/userHome')
def userHome():
    if session.get('user'):
        return render_template('userHome.html')
    else:
        return render_template('error.html', error='Unauthorized Access')


@app.route('/showTransactions')
def showTransactions():
    return render_template('transactions.html')


@app.route('/showRoutines')
def showRoutines():
    return render_template('routines.html')


@app.route('/showFavourites')
def showFavourites():
    return render_template('favourites.html')


@app.route('/showShops')
def showShops():
    return render_template('shops.html')


@app.route('/showAddTransaction')
def showAddTransaction():
    return render_template('addTransaction.html')


@app.route('/showAddRoutine')
def showAddRoutine():
    return render_template('addRoutine.html')


@app.route('/showAddFavourite')
def showAddFavourite():
    return render_template('addFavourite.html')


@app.route('/showAddShop')
def showAddShop():
    return render_template('addShop.html')


# Methods that finally do something

@app.route('/getShops')
def getShops():
    try:
        if session.get('user'):

            return list_all_shops()
        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/getBudget')
def getBudget():
    try:
        if session.get('user'):
            _user = session.get('user')
            return monthly_balance(int(datetime.datetime.now().month), int(datetime.datetime.now().year), _user)
        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/getRoutines')
def getRoutines():
    try:
        if session.get('user'):
            _user = session.get('user')
            return list_routines(_user)
        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/getFavourites')
def getFavourites():
    try:
        if session.get('user'):
            _user = session.get('user')
            return list_favourites(_user)
        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/getTransactions')
def getTransactions():
    try:
        if session.get('user'):
            _user = session.get('user')
            return simple_list_my_transactions(_user)
        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/addTransaction', methods=['POST'])
def addTransaction():
    try:
        if session.get('user'):
            _title = request.form['inputTitle']
            _cost = request.form['inputCost']
            _date = request.form['inputDate']
            _currency = request.form['inputCurrency']
            _category = request.form['inputCategory']
            _shop = request.form['inputShops']
            _user = session.get('user')
            if add_transaction(_date, _user, _title, _category, _cost, _currency, _shop):
                return redirect('/showTransactions')
            else:
                return render_template('error.html', error='An error occurred!')
        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/addRoutine', methods=['POST'])
def addRuotine():
    try:
        if session.get('user'):
            _title = request.form['inputTitle']
            _cost = request.form['inputCost']
            _dayy = request.form['inputDay']
            _currency = request.form['inputCurrency']
            _fdate = request.form['inputStartDate']
            _ldate = request.form['inputFinishDate']
            _user = session.get('user')

            if not regexp.match('[A-Za-z0-9]', _title):
                return render_template('error.html', error='Input data is unsecure. Please use only digits and letters')
            if not (regexp.match('\d{4}-\d{2}-\d{2}', _fdate) and regexp.match('\d{4}-\d{2}-\d{2}')):
                return render_template('error.html', error='Wrong date format')

            connection = database_connect()
            cur = connection.cursor()
            cur.callproc('add_routine', (_fdate, _ldate, _dayy, _user, _title, _cost, _currency))
            data = cur.fetchall()

            if len(data) is 0:
                connection.commit()
                return redirect('/showRoutines')
            else:
                return render_template('error.html', error='An error occurred!')

        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/addFavourite', methods=['POST'])
def addFavourite():
    try:
        if session.get('user'):
            _title = request.form['inputTitle']
            _cost = request.form['inputCost']
            _currency = request.form['inputCurrency']
            _shop = request.form['inputShops']
            _user = session.get('user')
            if not (
                regexp.match('[A-Za-z0-9]', _title) and
                regexp.match('[A-Za-z0-9]', _shop) and
                regexp.match('[A-Za-z0-9]', _user)
            ):
                return render_template('error.html', error='Input data is unsecure. Please use only digits and letters')

            con = database_connect()
            cur = con.cursor()
            cur.callproc('add_favourite', (_user, _title, _cost, _currency, _shop))
            data = cur.fetchall()

            if len(data) is 0:
                con.commit()
                return redirect('/showFavourites')
            else:
                return render_template('error.html', error='An error occurred!')

        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/addShop', methods=['POST'])
def addShop():
    try:
        if session.get('user'):
            _name = request.form['inputName']
            _country = request.form['inputCountry']
            _city = request.form['inputCity']
            _address = request.form['inputAddress']

            if not (
                regexp.match('[A-Za-z0-9]', _name) and
                regexp.match('[A-Za-z0-9]', _city) and
                regexp.match('[A-Za-z0-9]', _address) and
                regexp.match('[A-Za-z0-9]', _country)
            ):
                return render_template('error.html', error='Input data is unsecure. Please use only digits and letters')

            con = database_connect()
            cur = con.cursor()
            if _name and _country and _city and _address:
                cur.callproc('add_shop', (_name,))
                cur.callproc('describe_shop', (_name, _address, _country, _city))
                data = cur.fetchall()
            else:
                cur.callproc('add_shop', (_name,))
                data = cur.fetchall()

            if len(data) is 0:
                con.commit()
                return redirect('/showShops')
            else:
                return render_template('error.html', error='An error occurred!')

        else:
            return render_template('error.html', error='Unauthorized Access')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/logout')
def logout():
    session.pop('user', None)
    return redirect('/')


@app.route('/validateLogin', methods=['POST'])
def validateLogin():
    try:
        _username = request.form['inputEmail']
        _password = request.form['inputPassword']

        if not regexp.match('[A-Za-z0-9]', _username):
            return render_template('error.html', error='WTF? Do you want to hack me?')

        if validate_user(_username, _password):
                session['user'] = execute_sql_command(
                    database_connect(),
                    """
                        SELECT NickName FROM users WHERE EMail = '{0}'
                    """.format(_username))[0][0]  # here is the only place with select enjoy hacking! (ofc impossible)
                return redirect('/userHome')
        else:
            return render_template('error.html', error='XDWrong Email address or Password.')
    except Exception as e:
        return render_template('error.html', error=str(e))


@app.route('/signUp', methods=['POST', 'GET'])
def signUp():
    try:
        # read the posted values from the UI
        _name = request.form['inputName']
        _email = request.form['inputEmail']
        _password = request.form['inputPassword']

        # validate the received values
        if _name and _email and _password:
            if signup_user(_name, _email, _password):
                return json.dumps({'message': 'User created successfully !'})
            else:
                return json.dumps({'error': 'something went wrong'})
        else:
            return json.dumps({'html': '<span>Enter the required fields</span>'})

    except Exception as e:
        return json.dumps({'errorxd': str(e)})


if __name__ == "__main__":
    app.run(host="localhost", port=5010)
