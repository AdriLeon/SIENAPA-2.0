import web
import pyrebase
import firebase_config as token
import app as app
import json

render = web.template.render("mvc/views/admin/") #ruta de las vistas
firebase = pyrebase.initialize_app(token.firebaseConfig)
auth = firebase.auth() 
db = firebase.database()

class ListaUsuarios: #clase Index
    def GET(self):
        try:
            firebase = pyrebase.initialize_app(token.firebaseConfig)
            db = firebase.database()
            cookie = web.cookies().get("localid") #almacena los datos de la cookie
            users = db.child('data').child('usuarios').get()
            db.child('data').child('pozos').get()
            for user in users.each():
                if user.key() == cookie and user.val()['nivel'] == 'administrador':
                    users = db.child("data").child("usuarios").get()
                    return render.lista_usuarios(users)
                elif user.key() == cookie and user.val()['nivel'] == 'operador':
                    web.setcookie('localid', None)
                    return web.seeother('/logout')
                elif user.key() == cookie and user.val()['nivel'] == 'informatica':
                    web.setcookie('localid', None)
                    return web.seeother('/logout')
            web.setcookie('localid', None)
            return web.seeother('/logout')
            
        except Exception as error:
            print("Error UsersList.GET: {}".format(error))