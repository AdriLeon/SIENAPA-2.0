import web
import app
import json
import firebase_config as token
import pyrebase
from datetime import datetime

render = web.template.render("mvc/views/operador/") #ruta de las vistas
firebase = pyrebase.initialize_app(token.firebaseConfig)
auth = firebase.auth() #verifica la conexión a firebase
db = firebase.database()

class Logout: #clase Index
    def GET(self):
        cookie = web.cookies().get("localid") #almacena los datos de la cookie
        user = db.child('data').child('usuarios').child(cookie).get()
        data = {
            "actividad" : "Salio del sistema",
            "fecha" : datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        }
        db.child('data').child('usuarios').child(cookie).child('logs').push(data)
        web.setcookie('tokenUser', None)
        web.setcookie('localid', None) #establece la cookie en None
        return web.seeother('/')