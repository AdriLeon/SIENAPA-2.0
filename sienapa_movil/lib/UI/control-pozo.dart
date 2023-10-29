import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer';

import 'cambiar_horario.dart';

const List<String> list = <String>['Pozo 1', 'Pozo 2', 'Pozo 3', 'Pozo 4'];

class ControlPozoPage extends StatelessWidget {
  const ControlPozoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color(0xFF599EAC),
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Roboto'),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Control de Pozos'),
        ),
        body: Center(
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
                  SizedBox(height: 8.0),
                  DropdownList(),
                  SizedBox(height: 8.0),
                  SwitchObject(),
                  SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CambiarHorario(),
                        ),
                      );
                    },
                    child: Text('Cambiar Horario'),
                  ),
                ],
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
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      items: list.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
    );
  }
}

class SwitchObject extends StatefulWidget {
  const SwitchObject({super.key});

  @override
  State<SwitchObject> createState() => _SwitchObjectState();
}

class _SwitchObjectState extends State<SwitchObject> {
  bool light = true;

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
