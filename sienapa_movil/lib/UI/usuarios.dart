import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Controller/UsuariosController.dart';
import 'package:sienapa_movil/UI/theme.dart';

class Usuarios extends StatelessWidget {
  Usuarios({super.key});

  UsuariosController userController = Get.put(UsuariosController());

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return GetBuilder<UsuariosController>(
      init: UsuariosController(),
      initState: (_) {},
      builder: (userController) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          userController.getData();
        });
        return Scaffold(
          backgroundColor: customColors.backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Usuarios'),
            backgroundColor: customColors.appBarColor,
          ),
          body: Center(
                child: userController.isLoading.value == true
                    ? const CircularProgressIndicator(
                        color: Colors.blue,
                      )
                    : Obx(
                      () => ListView.separated(
                    itemBuilder: (BuildContext context, index) {
                      // Verificar si el índice es 0 o si el nivel ha cambiado
                      bool showHeader = index == 0 ;

                      return Column(
                        children: [
                          // Mostrar el encabezado solo si es necesario
                          if (showHeader)
                            Container(
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(width: 30,height: 50,),
                                  Text('Correo', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                  SizedBox(height: 20,),
                                  Text('Nivel', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                ],
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.person),
                              TextButton(
                                onPressed: () {
                                  _mostrarDialog(context, userController.usuarioslist[index].logs!);
                                },
                                child: Text(userController.usuarioslist[index].email!, style: TextStyle(fontSize: 16),),
                              ),
                              Text(userController.usuarioslist[index].nivel!, style: TextStyle(fontSize: 16),),
                            ],
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, index) {
                      return const SizedBox(
                        height: 5,
                      );
                    },
                    itemCount: userController.usuarioslist.length,
                  ),
                ),

          ),
        );
      },
    );
  }
}

void _mostrarDialog(BuildContext context, dynamic logs) {
  String? fecha = '';
  String? act = '';
  // crear una lista para agregar los datos
  List<String> lista = [];
  logs.forEach((key, value) {
    fecha = value['fecha'];
    act = value['actividad'];
    lista.add('$act - $fecha');
  });
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: const Text('Registro de Actividades'),
      content: SingleChildScrollView(
        child: Text(lista.join('\n')),),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context, 'Cerrar');
          },
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}
