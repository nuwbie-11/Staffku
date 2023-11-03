from flask import Flask,request,jsonify
from flask_cors import CORS
import mysql.connector
from dbConfig import db

app = Flask(__name__)
CORS(app)

myconn = mysql.connector.connect(**db)


@app.route('/api/read_data',methods=["GET"])
def get_data():
    try:
        cursor = myconn.cursor()
        cursor.execute("SELECT * from decoy")
        data = cursor.fetchall()
        cursor.close()

        return jsonify(data)
    except:
        response = {
            'message':'error'
        }
        return jsonify(response)


@app.route('/api/auth_user',methods=["POST"])
def auth_user():
    try:
        if request.method == 'POST':
            postBody = request.json
            cursor = myconn.cursor()
            query  = "SELECT * FROM staffku WHERE username = %s AND password = %s"
            cursor.execute(query,(postBody["uname"],postBody["passwd"]))
            data = cursor.fetchall()
            
            response = {
                'message': True,
                'role': data[0][-1],
                
            }
            query = "SELECT nama FROM profile WHERE idAkun = %s"
            cursor.execute(query,(data[0][0],))
            data = cursor.fetchall()
            cursor.close()
            response["loggedAs"] = data[0][0]
            return jsonify(response)
    except:
        response = {
            'message':False
        }
        return jsonify(response)

        



if __name__ == '__main__':
    app.run(debug=True,port=8080)