from flask import Flask, json, jsonify, request, session
from flaskext.mysql import MySQL

application = Flask(__name__)
mysql = MySQL()
application.config['MYSQL_DATABASE_USER'] = 'root'
application.config['MYSQL_DATABASE_PASSWORD'] = 'axolotl'
application.config['MYSQL_DATABASE_DB'] = 'EasyManage'
application.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(application)
application.secret_key = '8X2g= k9Q-2hsT6*M4#sT/f2!'
#session = {}

def clearSession():
    session.pop('user')
    session.pop('org')

#@application.route("/")
#@application.route("/home")

@application.route("/login")
def login():
    #Should do someting if there is already a user logged in to the session
    cur = mysql.get_db().cursor()
    data = (request.args.get('google_client_id'),)
    command = []
    command.append("SELECT d_type FROM user ")
    command.append("WHERE google_client_id='%s'" % data)
    cur.execute(''.join(command))
    fetched = cur.fetchone()
    if (fethced == None):
        return jsonify(result=[-1])
    tag = fetched[0]
    if(tag == 'ORG'):
        command = []
        command.append("SELECT user.user_id, organization.organization_id FROM user ")
        command.append("INNER JOIN organization ON user.user_id = organization.user_id ")
        command.append("WHERE google_client_id='%s'" % data)
        cur.execute(''.join(command))
        fetched = cur.fetchone()
        session['user'] = fetched[0]
        session['org'] = fetched[1]
    elif(tag == 'EMP'):
        command = []
        command.append("SELECT user.user_id, employee.organization_id FROM ((user ")
        command.append("INNER JOIN employee_user ON user.user_id = employee_user.user_id) ")
        command.append("INNER JOIN employee ON employee_user.employee_id = employee.employee_id) ")
        command.append("WHERE google_client_id='%s'" % data)
        cur.execute(''.join(command))
        fetched = cur.fetchone()
        session['user'] = fetched[0]
        session['org'] = fetched[1]
    elif(tag == 'CON'):
        command = []
        command.append("SELECT user_id FROM user ")
        command.append("WHERE google_client_id='%s'" % data)
        cur.execute(''.join(command))
        session['user'] = cur.fetchone()[0]
        session['org'] = None
    cur.close()
    return jsonify(result=[session['user']])

@application.route("/logout")
def logout():
    clearSession()
    return jsonify(result=[])

@application.route("/entries",methods=['GET'])
def getAllEntries():
    #If not logged in or not an employee return some error
    cur = mysql.get_db().cursor()
    data = (session.get('org'),)
    command = []
    command.append("SELECT title, date_created, description, d_type FROM entry ")
    command.append("WHERE organization_id=%s" % data)
    filter = request.args.get('filter', None)
    if filter != None:
        command.append(" AND title LIKE '%%%s%%'" % (filter,))
    cur.execute(''.join(command))
    toReturn = cur.fetchall()
    cur.close()
    return jsonify(result=data)

@application.route("/entries/new",methods=['POST'])
def addNewEntry():
    #If not logged in or not an employee return some error
    cur = mysql.get_db().cursor()
    entryType = request.args.get('entry_type')
    data = (session.get('user'), session.get('org'), request.args.get('title'), request.args.get('date_created'), request.args.get('description'), entryType)
    command = []
    command.append("INSERT INTO entry (employee_id, organization_id, title, date_created, description, d_type) ")
    command.append("VALUES (%s, %s, '%s', '%s', '%s', '%s')" % data)
    cur.execute(''.join(command))
    command = []
    command.append("SELECT @@IDENTITY")
    cur.execute(''.join(command))
    entryID = cur.fetchone()[0]
    if(entryType == 'WRK'):
        data = (entryID, request.args.get('status'), request.args.get('completion_date'))
        command = []
        command.append("INSERT INTO work_order (entry_id, status, completion_date) ")
        command.append("VALUES (%s, '%s', '%s')" % data)
        cur.execute(''.join(command))
    if(entryType == 'PRC'):
        data = (entryID, request.args.get('status'), request.args.get('purchase_ordercol'))
        command = []
        command.append("INSERT INTO purchase_order (entry_id, status, purchase_ordercol) ")
        command.append("VALUES (%s, '%s', '%s')" % data)
        cur.execute(''.join(command))
    mysql.get_db().commit()
    cur.close()
    return jsonify(result=[])

@application.route("/entries/work",methods=['GET'])
def getAllWorkOrders():
    cur = mysql.get_db().cursor()
    data = (session.get('org'),)
    command = []
    command.append("SELECT * FROM entry ")
    command.append("FULL OUTER JOIN work_order ON entry.entry_id = work_order.entry_id ")
    command.append("WHERE entry.organization_id=%s AND entry.dType='WRK'" % data)
    filter = request.args.get('filter', None)
    if filter != None:
        command.append(" AND entry.title LIKE '%%%s%%'" % (filter,))
    cur.execute(''.join(command))
    data = cur.fetchall()
    cur.close()
    return jsonify(result=data)

@application.route("/entries/purchase",methods=['GET'])
def getAllPurchaseOrders():
    cur = mysql.get_db().cursor()
    data = (session.get('org'),)
    command = []
    command.append("SELECT * FROM entry ")
    command.append("FULL OUTER JOIN purchase_order ON entry.entry_id = purchase_order.entry_id ")
    command.append("WHERE entry.organization_id=%s AND entry.dType='PRC'" % data)
    filter = request.args.get('filter', None)
    if filter != None:
        command.append(" AND entry.title LIKE '%%%s%%'" % (filter,))
    cur.execute(''.join(command))
    data = cur.fetchall()
    cur.close()
    return jsonify(result=data)

#@application.route("/entries/<entryID>",methods=['GET'])

#@application.route("/entries/<entryID>/modify",methods=['PUT'])

#@application.route("/entries/<entryID>/remove",methods=['DELETE'])

#@application.route("/contacts",methods=['GET'])

#@application.route("/contacts/new",methods=['POST'])

#@application.route("/contacts/search?=<filter>",methods=['GET'])

#@application.route("/contacts/supplier",methods=['GET'])

#@application.route("/contacts/supplier/search?=<filter>",methods=['GET'])

#@application.route("/contacts/contractor",methods=['GET'])

#@application.route("/contacts/contractor/search?=<filter>",methods=['GET'])

#@application.route("/contacts/<contactID>",methods=['GET'])

#@application.route("/contacts/<contactID>/modify",methods=['PUT'])

#@application.route("/contacts/<contactID>/remove",methods=['DELETE'])

#@application.route("/contacts/<contactID>/personnel",methods=['GET']) #Should only work if contactID is a company

#@application.route("/contacts/<contactID>/personnel/search?=<filter>",methods=['GET'])

#@application.route("/about")

#@application.route("/about/axolDev")

#@application.route("/about/ezManage")

#@application.route("/help",methods=['GET'])

#@application.route("/help/search?=<filter>",methods=['GET'])

#@application.route("/help/<tutorialID>",methods=['GET'])

#@application.route("/account",methods=['GET'])

#@application.route("/account/settings",mentods=['GET'])

#@application.route("/account/settings/modify",methods=['PUT'])

#@application.route("/account/personnel",methods=['GET']) #Should only work for organization accounts

#@application.route("/account/personnel/new",methods=['POST'])

#@application.route("/account/personnel/search?=<filter>",methods=['GET'])

#@application.route("/account/personnel/<employeeID>",methods=['GET'])

#@application.route("/account/personnel/<employeeID>/modify",methods=['PUT'])

#@application.route("/account/personnel/<employeeID>/remove",methods=['DELETE'])

#@application.route("/account/personnel/<employeeID>/permissions",methods=['GET']) #Should only work if employeeID is an employee user

#@application.route("/account/personnel/<employeeID>/permissions/modify",methods=['PUT'])

if __name__ == '__main__':
    application.run(host='0.0.0.0', port=5000)
