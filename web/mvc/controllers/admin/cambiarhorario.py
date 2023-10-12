import web
import app as app
import pyrebase
import firebase_config as token
import json

render = web.template.render("mvc/views/admin/") 
firebase = pyrebase.initialize_app(token.firebaseConfig)
auth = firebase.auth() 
db = firebase.database()

class CambiarHorario:
    def GET(self, id_pozo):
        try:
            cookie = web.cookies().get("localid") # almacena los datos de la cookie
            users = db.child('data').child('usuarios').get()
            horarios = db.child('data').child('pozos').child(id_pozo).child('horario').get() #obtiene los horarios de la base de datos
            for user in users.each():
                    if user.key() == cookie and user.val().get('status') == 'activo':
                        if user.val()['nivel'] == 'administrador':
                            return render.cambiar_hora(id_pozo, horarios)
                        elif user.val()['nivel'] in ['operador', 'informatica']:
                            web.setcookie('localid', None)
                            return web.seeother('/logout')
                        else:
                            web.setcookie('localid', None)
                            return web.seeother('/logout')
            web.setcookie('localid', None)
            return web.seeother('/logout')
        except Exception as e:
            # Manejo de errores en caso de que ocurra una excepción
            return "Ocurrió un error: " + str(e)

    def POST(self, id_pozo):
        try:
            formulario = web.input() #almacena los datos del formulario
            time1 = formulario['time1']
            time2 = formulario['time2']
            data = { #crea el diccionario data
                'h_encendido': str(time1),
                'h_apagado': str(time2),
            }
            db.child('data').child('pozos').child(id_pozo).child('horario').update(data) #actualiza los datos del horario
            return web.seeother('/admin/control-pozo') #redirecciona a la pagina de pozos
        except Exception as error:
            horarios = db.child('data').child('pozos').child(id_pozo).child('horario').get()
            print("Error cambiar_horario POST: {}".format(error.args))
            return render.cambiar_hora(id_pozo, horarios)