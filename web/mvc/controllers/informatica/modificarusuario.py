import web
import app
import pyrebase
import firebase_config as token
from datetime import datetime

render = web.template.render("mvc/views/informatica/") #ruta de las vistas
firebase = pyrebase.initialize_app(token.firebaseConfig)
auth = firebase.auth() #verifica la conexión a firebase
db = firebase.database()

class ModificarUsuario: #clase Index
    def GET(self):
        cookie = web.cookies().get("localid") #almacena los datos de la cookie
        horarios_data = db.child('data').child('pozos').child('horarios').get()
        users = db.child('data').child('usuarios').get()
        pozos = db.child('data').child('pozos').get()
        for user in users.each():
            if user.key() == cookie and user.val()['nivel'] == 'administrador':
                return web.seeother('/logout')
            elif user.key() == cookie and user.val()['nivel'] == 'operador':
                web.setcookie('localid', None)
                return web.seeother('/logout')
            elif user.key() == cookie and user.val()['nivel'] == 'informatica':
                return render.modificar_usuario(users)
        web.setcookie('localid', None)
        return web.seeother('/logout')
                
    def POST(self):
        try:
            #obtiene los datos del formulario
            cookie = web.cookies().get("localid") #almacena los datos de la cookie
            formulario = web.input()
            id = formulario['id']
            users = db.child('data').child('usuarios').child(id).get()
            a_nivel = users.val().get('nivel')
            n_control = users.val().get('no_control')
            no_control = formulario['inputControl14']
            nivel = formulario['nivel']
            data = { #crea el diccionario data
                'nivel': nivel,
                'no_control': no_control,
            }
            db.child('data').child('usuarios').child(id).update(data) #actualiza los datos del usuario
            if (int(n_control) != int(no_control)):
                actividad = 'Modificó numero de control ' + str(n_control) + ' a ' + str(no_control) + ' del usuario ' + str(users.val().get('correo'))
                fecha = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                log = {
                    'actividad': actividad,
                    'fecha': fecha
                }
                db.child('data').child('usuarios').child(cookie).child('logs').push(log)
            if (a_nivel != nivel):
                actividad = 'Modificó el nivel ' + str(a_nivel) + ' a ' + str(nivel) + ' del usuario' + str(users.val().get('correo'))
                fecha = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
                log = {
                    'actividad': actividad,
                    'fecha': fecha
                }
                db.child('data').child('usuarios').child(cookie).child('logs').push(log)
            return web.seeother('/informatica/modificar-usuario') #redirecciona a la pagina de usuarios
        except Exception as error:
            users = db.child('data').child('usuarios').get()
            print("Error modificar_usuario POST: {}".format(error.args))
            return render.modificar_usuario(users)