import 'package:flutter/material.dart';

class CambiarHorario extends StatelessWidget {
  const CambiarHorario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cambiar día y hora de encendido y apagado'),
        backgroundColor: const Color(0xFF599EAC),
      ),
      body:
      const CheckDiaHora(),
    );
  }
}

class DiaHora extends StatelessWidget {
  const DiaHora({
    super.key,
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
            })
          ],
        ),
      ),
    );
  }
}

class CheckDiaHora extends StatefulWidget {
  const CheckDiaHora({super.key});

  @override
  State<CheckDiaHora> createState() => _CheckDiaHoraState();
}

class _CheckDiaHoraState extends State<CheckDiaHora> {
  final List<bool> _isSelected = [false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DiaHora(
              label: 'Lunes',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected[0],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[0] = newValue;
                });
              },
            ),
            DiaHora(
              label: 'Martes',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected[1],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[1] = newValue;
                });
              },
            ),
            DiaHora(
              label: 'Miércoles',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected[2],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[2] = newValue;
                });
              },
            ),
            DiaHora(
              label: 'Jueves',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected[3],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[3] = newValue;
                });
              },
            ),
            DiaHora(
              label: 'Viernes',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected[4],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[4] = newValue;
                });
              },
            ),
            DiaHora(
              label: 'Sabado',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected[5],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[5] = newValue;
                });
              },
            ),
            DiaHora(
              label: 'Domingo',
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              value: _isSelected[6],
              onChanged: (bool newValue) {
                setState(() {
                  _isSelected[6] = newValue;
                });
              },
            ),
            const SelectTimeToStart(),
            const SelectTimeToEnd(),
          ],
        ),
      ),
    );
  }
}

class SelectTimeToStart extends StatefulWidget {
  const SelectTimeToStart({super.key});

  @override
  State<SelectTimeToStart> createState() => _SelectHoraState();
}

class _SelectHoraState extends State<SelectTimeToStart> {
  final timeController = TextEditingController();

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: timeController,
      decoration: const InputDecoration(hintText: 'Selecciona la hora'),
      onTap: () async {
        var time = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());

        if (time != null) {
          timeController.text = time.format(context);
        }
      },
    );
  }
}

class SelectTimeToEnd extends StatefulWidget {
  const SelectTimeToEnd({super.key});

  @override
  _SelectHoraEndState createState() => _SelectHoraEndState();
}

class _SelectHoraEndState extends State<SelectTimeToStart> {
  final timeController = TextEditingController();

  @override
  void dispose() {
    timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: true,
      controller: timeController,
      decoration: const InputDecoration(hintText: 'Selecciona la hora'),
      onTap: () async {
        var time = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());

        if (time != null) {
          timeController.text = time.format(context);
        }
      },
    );
  }
}




