import web
import app as app
import firebase_config as token
from fpdf import FPDF
import pyrebase
from datetime import datetime
import os
import string

firebase = pyrebase.initialize_app(token.firebaseConfig)
auth = firebase.auth() 
db = firebase.database()
storage = firebase.storage()

meses_en_espanol = {
    1: "enero",
    2: "febrero",
    3: "marzo",
    4: "abril",
    5: "mayo",
    6: "junio",
    7: "julio",
    8: "agosto",
    9: "septiembre",
    10: "octubre",
    11: "noviembre",
    12: "diciembre",
}
mes = meses_en_espanol[datetime.now().month]
count = 0
total_fallas = 0
logo = os.path.abspath("static/img/sienapa_extend.png")
render = web.template.render("mvc/views/admin/") #ruta de las vistas

class GenerarReporte: #clase Index
    def GET(self):
        try:
            cookie = web.cookies().get("localid") # almacena los datos de la cookie
            users = db.child('data').child('usuarios').get()
            pozos = db.child('data').child('pozos').get()
            for user in users.each():
                if user.key() == cookie and user.val().get('status') == 'activo':
                    if user.val()['nivel'] == 'administrador':
                        return render.generar_reporte(total_fallas)
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

    def POST(self):
        try:
            cookie = web.cookies().get("localid") #almacena los datos de la cookie
            pozos = db.child('data').child('pozos').get()
            user = db.child('data').child('usuarios').child(cookie).get()
            reportes = db.child('data').child('reportes').get()
            formulario = web.input()
            fechaInicio = formulario.fechaInicio
            fechaFin = formulario.fechaFinal
            generarReporte(fechaInicio, fechaFin, pozos, user, reportes, cookie)
            datos = {
                'fecha_reporte': datetime.now().strftime("%Y-%m-%d"),
                'no_control': user.val().get('no_control'),
                'total_fallas': total_fallas,
            }
            db.child('data').child('reportes').push(datos)
            cont = 0
            for i in reportes.each():
                cont += 1
            id_reporte = str(cont).zfill(5)
            web.setcookie('documentId', id_reporte)
            ruta_pdf = "static/pdf/Reporte.pdf"
            nom_doc = "R-" + id_reporte + "-" + datetime.now().strftime('%d-%m-%Y')
            storage.child("data/reportes").child(nom_doc).put(ruta_pdf)
            tokens = web.cookies().get("tokenUser")
            url = storage.child("data/reportes/"+nom_doc).get_url(tokens)
            return render.generar_reporte(total_fallas, url)
        except Exception as error:
            print("Error GenerarReporte.POST: {}".format(error))
            return render.generar_reporte(total_fallas)
    
def generarReporte(fechaInicio, fechaFin, pozos, user, reportes, cookie):
    global count
    global total_fallas
    total_fallas = 0
    cont = 0
    for i in reportes.each():
        cont += 1
    id_reporte = str(cont).zfill(5)
    pdf = FPDF ('P', 'mm', 'Letter')
    pdf.set_auto_page_break(auto=True, margin = 15)
    pdf.add_page()
    pdf.image(logo, 10, 12, 40)
    pdf.set_font('helvetica', '', 12)
    pdf.cell(0, 10, 'SISTEMA PARA EL ENCENDIDO Y APAGADO', border=False, ln=1, align='C')        
    pdf.cell(0, 2, 'DE POZOS DE AGUA', border=False, ln=1, align='C')
    pdf.set_font('helvetica', 'B', 12)
    pdf.cell(0, 20, 'REPORTE DE FALLAS EN POZOS DE AGUA', border=False, align='C')        
    pdf.set_font('helvetica', '', 12)
    pdf.cell(0, 15, ln=1,)
    pdf.cell(0, 20, 'Tulancingo de Bravo, Hidalgo a {} de {} del {}'.format(datetime.now().day, mes, datetime.now().year), ln=1, align='R')
    pdf.set_font('helvetica', '', 12)
    pdf.cell(0, 10, ln=1,)
    pdf.cell(0, 0, '**Persona que solicita**: #' + user.val().get('no_control'), ln=1, align='R', markdown=True)
    pdf.cell(0, 20, '**N° de Reporte**: '+ id_reporte, border=False, ln=1, align='R', markdown=True)
    pdf.set_font('helvetica', '', 12)
    pdf.cell(0, 10, ln=1,)
    fechaI_d_m_a_str = datetime.strptime(fechaInicio, "%Y-%m-%d")
    fechaI_d_m_a = fechaI_d_m_a_str.strftime("%d-%m-%Y")
    fechaF_d_m_a_str = datetime.strptime(fechaFin, "%Y-%m-%d")
    fechaF_d_m_a = fechaF_d_m_a_str.strftime("%d-%m-%Y")
    pdf.cell(0, 0, 'Incidencias ocurridas durante el período comprendido entre el **{}** y el **{}**.'.format(str(fechaI_d_m_a), str(fechaF_d_m_a)), ln=1, align='L', markdown=True)        
    pdf.cell(0, 10, ln=1,)

    # Initialize the flag to check if there are any records
    has_records = False
    for pozo in pozos.each():
        fallas = db.child('data').child('pozos').child(pozo.key()).child('fallas').get()
        for falla in fallas.each():
            fecha_hora_str = falla.val().get('tiempo')
            fecha_hora = datetime.strptime(fecha_hora_str, "%Y-%m-%d %H:%M:%S")
            fecha_falla = fecha_hora.strftime("%Y-%m-%d")
            fecha_doc = fecha_hora.strftime("%d-%m-%Y %H:%M:%S")
            fecha_inicio_str = datetime.strptime(fechaInicio, "%Y-%m-%d")
            fecha_inicio = fecha_inicio_str.strftime("%Y-%m-%d")
            fecha_fin_str = datetime.strptime(fechaFin, "%Y-%m-%d")
            fecha_fin = fecha_fin_str.strftime("%Y-%m-%d")
            if fecha_falla >= fecha_inicio and fecha_falla <= fecha_fin:
                if not has_records:
                    pdf.set_font('helvetica', 'B', 12)
                    # Generate the name of the well and the table headers only once
                    pdf.cell(0, 20, '**Pozo**: ' + string.capwords(pozo.val().get('nombre')), ln=1, align='C', markdown=True)
                    pdf.cell(0, 0, '**Ubicación del pozo**: ' + pozo.val().get('ubicacion'), ln=1, align='C', markdown=True)
                    pdf.cell(0, 15, ln=1,)
                    pdf.set_font('helvetica', 'B', 12)
                    pdf.cell(45, 20, 'Numero de falla', border=True, align='C')
                    pdf.cell(105, 20, 'Descripcion de falla', border=True, align='C')
                    pdf.cell(50, 20, 'Tiempo de la falla', border=True, ln=True, align='C')
                    has_records = True  # Set the flag to True once the headers are generated
                count += 1
                total_fallas += 1
                pdf.set_font('helvetica', '', 12)
                pdf.cell(45, 20, f'Falla: {count}', border=True, align='C')
                pdf.cell(105, 20, falla.val().get('falla'), border=True, align='C')
                pdf.cell(50, 20, fecha_doc, border=True, ln=True, align='C')
        has_records = False  # Reset the flag for each pozo   
        count = 0  # Reset the count for each pozo
    #pdf.output('static/pdf/R-{}-{}-{}.pdf'.format(user.val().get('no_control'), cont, datetime.now().strftime("%Y-%m-%d")), 'F')
    pdf.output('static/pdf/Reporte.pdf', 'F')
    return total_fallas