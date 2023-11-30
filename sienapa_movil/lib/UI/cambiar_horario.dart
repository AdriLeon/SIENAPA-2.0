import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CambiarHorario extends StatefulWidget {
  final String? pozoId;

  const CambiarHorario({Key? key, this.pozoId}) : super(key: key);

  @override
  _CambiarHorarioState createState() => _CambiarHorarioState();
}

class _CambiarHorarioState extends State<CambiarHorario> {
  final DatabaseReference _database = FirebaseDatabase.instance.reference();

  List<bool> _isSelected = List.generate(7, (index) => false);
  late String _hEncendido = '';
  late String _hApagado = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      // Use `once()` without awaiting, as it returns a Future<DatabaseEvent>
      var event = await _database.child('data/pozos/${widget.pozoId}/horario').once();

      // Get the DataSnapshot from the DatabaseEvent
      DataSnapshot snapshot = event.snapshot;

      // Check if the snapshot is not null and the data is of the expected type
      if (snapshot.value is Map<dynamic, dynamic>) {
        Map<dynamic, dynamic>? horarioData = snapshot.value as Map?;

        setState(() {
          _isSelected = List.generate(7, (index) => horarioData?['dia${index + 1}'] == 1);
          _hEncendido = horarioData?['h_encendido'] ?? ''; // Provide a default value if it's nullable
          _hApagado = horarioData?['h_apagado'] ?? ''; // Provide a default value if it's nullable
        });
      } else {
        print('Unexpected data type: ${snapshot.value.runtimeType}');
      }
    } catch (error) {
      print('Error loading data: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar día y hora de encendido y apagado'),
        backgroundColor: const Color(0xFF599EAC),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CheckDiaHora(
              isSelected: _isSelected,
              onChanged: (List<bool> newValues) {
                setState(() {
                  _isSelected = newValues;
                });
              },
            ),
            SelectTimeToStart(
              initialTime: _hEncendido,
              onTimeSelected: (String selectedTime) {
                setState(() {
                  _hEncendido = selectedTime;
                });
              },
            ),
            SelectTimeToEnd(
              initialTime: _hApagado,
              onTimeSelected: (String selectedTime) {
                setState(() {
                  _hApagado = selectedTime;
                });
              },
            ),
            GuardarHorarioButton(
              onSave: () {
                _saveHorario();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _saveHorario() {
    // Aquí puedes guardar la información actualizada en Firebase
    _database.child('data/pozos/${widget.pozoId}/horario').set({
      'dia1': _isSelected[0] ? 1 : 0,
      'dia2': _isSelected[1] ? 1 : 0,
      'dia3': _isSelected[2] ? 1 : 0,
      'dia4': _isSelected[3] ? 1 : 0,
      'dia5': _isSelected[4] ? 1 : 0,
      'dia6': _isSelected[5] ? 1 : 0,
      'dia7': _isSelected[6] ? 1 : 0,
      'h_encendido': _hEncendido,
      'h_apagado': _hApagado,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Horario guardado')),
    );
  }
}

class CheckDiaHora extends StatefulWidget {
  final List<bool> isSelected;
  final ValueChanged<List<bool>> onChanged;

  const CheckDiaHora({Key? key, required this.isSelected, required this.onChanged}) : super(key: key);

  @override
  State<CheckDiaHora> createState() => _CheckDiaHoraState();
}

class _CheckDiaHoraState extends State<CheckDiaHora> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DiaHora(
            label: 'Lunes',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: widget.isSelected[0],
            onChanged: (bool newValue) {
              widget.onChanged(List.from(widget.isSelected)..[0] = newValue);
            },
          ),
          DiaHora(
            label: 'Martes',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: widget.isSelected[1],
            onChanged: (bool newValue) {
              widget.onChanged(List.from(widget.isSelected)..[1] = newValue);
            },
          ),
          DiaHora(
            label: 'Miércoles',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: widget.isSelected[2],
            onChanged: (bool newValue) {
              widget.onChanged(List.from(widget.isSelected)..[2] = newValue);
            },
          ),
          DiaHora(
            label: 'Jueves',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: widget.isSelected[3],
            onChanged: (bool newValue) {
              widget.onChanged(List.from(widget.isSelected)..[3] = newValue);
            },
          ),
          DiaHora(
            label: 'Viernes',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: widget.isSelected[4],
            onChanged: (bool newValue) {
              widget.onChanged(List.from(widget.isSelected)..[4] = newValue);
            },
          ),
          DiaHora(
            label: 'Sábado',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: widget.isSelected[5],
            onChanged: (bool newValue) {
              widget.onChanged(List.from(widget.isSelected)..[5] = newValue);
            },
          ),
          DiaHora(
            label: 'Domingo',
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            value: widget.isSelected[6],
            onChanged: (bool newValue) {
              widget.onChanged(List.from(widget.isSelected)..[6] = newValue);
            },
          ),
        ],
      ),
    );
  }
}

class DiaHora extends StatelessWidget {
  const DiaHora({
    Key? key,
    required this.label,
    required this.padding,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Expanded(child: Text(label)),
            Checkbox(
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            )
          ],
        ),
      ),
    );
  }
}

class SelectTimeToStart extends StatefulWidget {
  final String initialTime;
  final ValueChanged<String> onTimeSelected;

  const SelectTimeToStart({Key? key, required this.initialTime, required this.onTimeSelected})
      : super(key: key);

  @override
  State<SelectTimeToStart> createState() => _SelectHoraState();
}

class _SelectHoraState extends State<SelectTimeToStart> {
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    timeController.text = widget.initialTime;
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        readOnly: true,
        controller: timeController,
        decoration: const InputDecoration(hintText: 'Selecciona la hora de encendido'),
        onTap: () async {
          var time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (time != null) {
            timeController.text = time.format(context);
            widget.onTimeSelected(timeController.text);
          }
        },
      ),
    );
  }
}

class SelectTimeToEnd extends StatefulWidget {
  final String initialTime;
  final ValueChanged<String> onTimeSelected;

  const SelectTimeToEnd({Key? key, required this.initialTime, required this.onTimeSelected})
      : super(key: key);

  @override
  _SelectHoraEndState createState() => _SelectHoraEndState();
}

class _SelectHoraEndState extends State<SelectTimeToEnd> {
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    timeController.text = widget.initialTime;
  }

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        readOnly: true,
        controller: timeController,
        decoration: const InputDecoration(hintText: 'Selecciona la hora de apagado'),
        onTap: () async {
          var time = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );

          if (time != null) {
            timeController.text = time.format(context);
            widget.onTimeSelected(timeController.text);
          }
        },
      ),
    );
  }
}

class GuardarHorarioButton extends StatelessWidget {
  final VoidCallback onSave;

  const GuardarHorarioButton({Key? key, required this.onSave}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        onPressed: onSave,
        child: const Text('Guardar horario'),
      ),
    );
  }
}
