import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Controller/HorarioController.dart';
import 'package:sienapa_movil/Model/HorarioModel.dart';
import 'package:sienapa_movil/UI/theme.dart';
import 'cambiar_horario.dart';

String? dropdownValue;
var estado = 'Apagado';
bool light = false;

class ControlPozoPage extends StatelessWidget {
  const ControlPozoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).extension<CustomColors>()!;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: customColors.appBarColor,
          title: const Text('Control de Pozos'),
        ),
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.9, // Limitar el ancho al 90% del ancho de la pantalla
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Text(
                      'Selección de Pozo de Agua',
                      style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    const DropdownList(),
                    const SizedBox(height: 8.0),
                    SwitchObject(estado: estado!),
                    const SizedBox(height: 8.0),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CambiarHorario(),
                          ),
                        );
                      },
                      child: const Text('Cambiar Horario'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropdownList extends StatefulWidget {
  const DropdownList({super.key});

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {

  HorarioController horarioController = Get.put(HorarioController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HorarioController(),
      initState: (_) {
        horarioController.getData();
      },
      builder: (horarioController) {
        print('Nombre: $dropdownValue Estado: $estado');
        return DropdownButton<String>(
          value: dropdownValue,
          items: horarioController.horariolist.map((HorarioModel value) {
            return DropdownMenuItem<String>(
              value: value.nombre,
              child: Text(value.nombre!),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
               dropdownValue = newValue!;
            });
            horarioController.horariolist.forEach((element) {
              if (element.nombre == dropdownValue) {
                estado = element.estado!;
                print(estado);
              }
            });
          },
        );
      },
    );
    // return DropdownButton<String>(
    //   value: dropdownValue,
    //   items: list.map((String value) {
    //     return DropdownMenuItem<String>(
    //       value: value,
    //       child: Text(value),
    //     );
    //   }).toList(),
    //   onChanged: (String? newValue) {
    //     setState(() {
    //       dropdownValue = newValue!;
    //     });
    //   },
    // );
  }
}

class SwitchObject extends StatefulWidget {
  const SwitchObject({super.key, required this.estado});
  final String estado;
  @override
  State<SwitchObject> createState() => _SwitchObjectState(estado);
}

class _SwitchObjectState extends State<SwitchObject> {

  _SwitchObjectState(this.estado);
  String? estado;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      activeColor: Colors.green,
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}

