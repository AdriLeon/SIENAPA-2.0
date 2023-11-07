import 'package:flutter/material.dart';

class GenerarReportePage extends StatelessWidget {
  const GenerarReportePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Generar Reporte',
      home: GenerarReporte(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class GenerarReporte extends StatefulWidget {
  const GenerarReporte({Key? key});

  @override
  State<GenerarReporte> createState() => _GenerarReporteState();
}

class _GenerarReporteState extends State<GenerarReporte> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _numeroController = TextEditingController();
  DateTime? _fechaInicio;
  DateTime? _fechaFin;

  Future<void> _selectFechaInicio() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaInicio ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _fechaInicio) {
      setState(() {
        _fechaInicio = picked;
        _fechaInicioController.text = "${_fechaInicio?.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectFechaFin() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _fechaFin ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _fechaFin) {
      setState(() {
        _fechaFin = picked;
        _fechaFinController.text = "${_fechaFin?.toLocal()}".split(' ')[0];
      });
    }
  }

  final TextEditingController _fechaInicioController = TextEditingController();
  final TextEditingController _fechaFinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generar Reporte'),
        backgroundColor: const Color(0xFF599EAC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Fecha de Inicio',
                    border: OutlineInputBorder(),
                  ),
                  controller: _fechaInicioController,
                  readOnly: true,
                  onTap: _selectFechaInicio,
                  validator: (value) {
                    if (_fechaInicio == null) {
                      return 'Por favor, selecciona una fecha de inicio.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Fecha de Fin',
                    border: OutlineInputBorder(),
                  ),
                  controller: _fechaFinController,
                  readOnly: true,
                  onTap: _selectFechaFin,
                  validator: (value) {
                    if (_fechaFin == null) {
                      return 'Por favor, selecciona una fecha de fin.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Total de incidentes',
                    border: OutlineInputBorder(),
                  ),
                  controller: _numeroController,
                  enabled: false,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Agregar lógica para generar el informe
                    }
                  },
                  child: const Text('Generar Reporte'),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    // Agregar lógica para descargar el informe
                  },
                  child: const Text('Descargar Informe'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
