import web
import app
import pyrebase
import firebase_config as token
import json
from datetime import datetime

render = web.template.render("mvc/views/informatica/") #ruta de las vistas
firebase = pyrebase.initialize_app(token.firebaseConfig)
auth = firebase.auth() #verifica la conexión a firebase
db = firebase.database()

class AgregarUsuario: #clase Index
    def GET(self):
        mensaje = None
        cookie = web.cookies().get("localid") #almacena los datos de la cookie
        users = db.child('data').child('usuarios').get()
        for user in users.each():
            if user.key() == cookie and user.val()['nivel'] == 'administrador':
                return web.seeother('/logout')
            elif user.key() == cookie and user.val()['nivel'] == 'operador':
                web.setcookie('localid', None)
                return web.seeother('/logout')
            elif user.key() == cookie and user.val()['nivel'] == 'informatica':
                return render.agregar_usuario(mensaje)
        web.setcookie('localid', None)
        return web.seeother('/logout')

    def POST(self):
        try:
            cookie = web.cookies().get("localid") #almacena los datos de la cookie
            formulario = web.input() #almacena los datos del formulario web
            email = formulario['inputEmail14'] #almacena el email del formulario web
            no_control = formulario['inputControl14'] #almacena el no_control del formulario web
            password = formulario['inputPassword14'] #almacena el password del formulario web
            nivel = formulario['nivel'] #almacena el nivel del formulario web
            user = auth.create_user_with_email_and_password(email, password) #crea el usuario en firebase
            print(cookie)
            accion = "Registro del usuario #" + str(no_control)
            accion2 = "Realizo el registro del usuario #" + str(no_control)
            fecha = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            registro = {
                "actividad": accion,
                "fecha": fecha
            }
            registro2 = {
                "actividad": accion2,
                "fecha": fecha
            }
            data = { #crea el diccionario data
                'correo': email,
                'nivel': nivel,
                'status': "activo",
                'no_control': no_control
            }    
            db.child('data').child('usuarios').child(user['localId']).set(data) #almacena el diccionario data en la base de datos
            db.child("data").child("usuarios").child(user['localId']).child("logs").push(registro)
            db.child("data").child("usuarios").child(cookie).child("logs").push(registro2)
            return web.seeother('/informatica/agregar-usuario')
        except Exception as error:
            formato = json.loads(error.args[1])
            error = formato['error']['message']
            if (error == "EMAIL_EXISTS"):
                mensaje = "El correo ya existe"
                return render.agregar_usuario(mensaje)
            else:
                mensaje = "Error desconocido"
                return render.agregar_usuario(mensaje)