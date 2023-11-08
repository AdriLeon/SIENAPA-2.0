import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Controller/PozosController.dart';
import 'package:sienapa_movil/UI/theme.dart';
import 'package:sienapa_movil/UI/usuarios.dart'; 

class ListaPozos extends StatelessWidget {
  ListaPozos({super.key});

  WordController pozoController = Get.put(WordController());

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return GetBuilder<WordController>(
      init: WordController(),
      initState: (_) {},
      builder: (pozoController) {
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          pozoController.getData();
        });
        return Scaffold(
            backgroundColor: customColors.backgroundColor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Lista de Pozos'),
              // backgroundColor: customColors.appBarColor,
            ),
            body: Center(
                child: pozoController.isLoading.value == true
                    ? const CircularProgressIndicator(
                  color: Colors.blue,
                )
                    : Obx(
                      () => ListView.separated(
                    itemBuilder: (BuildContext context, index) {
                      return Column(children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Obx(() => SizedBox(
                            child: CardExample(
                              nombrePozo:
                              pozoController.pozoslist[index].nombre!,
                              estadoPozo:
                              pozoController.pozoslist[index].estado!,
                              electricidadPozo: pozoController
                                  .pozoslist[index].electricidad,
                              informacionPozo: pozoController
                                  .pozoslist[index].informacion!,
                              ubicacionPozo: pozoController
                                  .pozoslist[index].ubicacion!,
                            ))),
                      ]);
                    },
                    separatorBuilder: (BuildContext context, index) {
                      return const SizedBox(
                        height: 30,
                      );
                    },
                    itemCount: pozoController.pozoslist.length,
                  ),
                )));
      },
    );
  }
}

class CardExample extends StatelessWidget {
  final String? nombrePozo;
  final String? estadoPozo;
  final int? electricidadPozo;
  final String? informacionPozo;
  final String? ubicacionPozo;
  const CardExample(
      {required this.nombrePozo,
        required this.estadoPozo,
        required this.electricidadPozo,
        required this.informacionPozo,
        required this.ubicacionPozo,
        super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return Center(
      child: Card(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.75,
          height: MediaQuery.of(context).size.height * 0.35,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.water_drop,
                size: 60,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                nombrePozo!,
                style:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Estado:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    estadoPozo!,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Electricidad:",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  if (electricidadPozo == 0)
                    const Text(
                      "No",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  if (electricidadPozo == 1)
                    const Text(
                      "Si",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                width: 190,
                child: MaterialButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Usuarios()));
                    },
                    color: customColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Icon(
                      Icons.power_settings_new,
                      color: Colors.white,
                      size: 30,
                    )),
              ),
              const SizedBox(
                height: 15,
              ),
              DialogExample(
                informacionPozo: informacionPozo,
                ubicacionPozo: ubicacionPozo,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DialogExample extends StatelessWidget {
  final String? informacionPozo;
  final String? ubicacionPozo;
  const DialogExample(
      {required this.informacionPozo, required this.ubicacionPozo, super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Detalles del Pozo'),
          content: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: <TextSpan>[
                const TextSpan(
                  text: 'Información: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text: informacionPozo,
                ),
                const TextSpan(
                  text: '\nUbicación: ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                TextSpan(
                  text: ubicacionPozo,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('Cerrar'),
            ),
          ],
        ),
      ),
      child: const Text(
        'Informacion del pozo',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}