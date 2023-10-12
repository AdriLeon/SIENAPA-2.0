import web

urls = (
    '/', 'mvc.controllers.public.login.Login',
    '/admin/lista-pozos', 'mvc.controllers.admin.listapozos.ListaPozos',
    '/admin/generar-pozo', 'mvc.controllers.admin.generarpozo.GenerarPozo',
    '/admin/cambiar-horario/(.*)', 'mvc.controllers.admin.cambiarhorario.CambiarHorario',
    '/admin/control-pozo', 'mvc.controllers.admin.controlpozo.ControlPozo',
    '/admin/lista-usuarios', 'mvc.controllers.admin.listausuarios.ListaUsuarios',
    '/admin/generar-reporte', 'mvc.controllers.admin.generarreporte.GenerarReporte',
    '/logout', 'mvc.controllers.public.logout.Logout',
    '/operador/cambiar-horario/(.*)', 'mvc.controllers.operador.cambiarhorario.CambiarHorario',
    '/operador/control-pozo', 'mvc.controllers.operador.controlpozo.ControlPozo',
    '/operador/generar-reporte', 'mvc.controllers.operador.generarreporte.GenerarReporte',
    '/operador/lista-pozos', 'mvc.controllers.operador.listapozo.ListaPozo',
    '/operador/lista-usuarios', 'mvc.controllers.operador.listausuarios.ListaUsuarios',
    '/informatica/agregar-usuario', 'mvc.controllers.informatica.agregarusuario.AgregarUsuario',
    '/informatica/modificar-usuario', 'mvc.controllers.informatica.modificarusuario.ModificarUsuario',
)

app = web.application(urls, globals())

if __name__ == "__main__":
    web.config.debug = False
    app.run()
