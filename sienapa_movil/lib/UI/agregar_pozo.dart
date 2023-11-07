import 'package:flutter/material.dart';

class AgregarPozo extends StatelessWidget {
  const AgregarPozo({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Agregar nuevo pozo',
      home: Formulario(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Formulario extends StatefulWidget {
  const Formulario({Key? key});

  @override
  State<Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<Formulario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nombrePozoController = TextEditingController();
  final TextEditingController _ubicacionController = TextEditingController();
  final TextEditingController _numeroCFEController = TextEditingController();
  final TextEditingController _numeroCaamtController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF599EAC),
        title: const Text('Agregar nuevo pozo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Nombre del pozo',
                      ),
                      controller: _nombrePozoController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa el nombre del pozo.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Ubicación',
                      ),
                      controller: _ubicacionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa la ubicación del pozo.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Convenio (CFE) del pozo',
                      ),
                      controller: _numeroCFEController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa el número de convenio con CFE.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Concesión (CONAGUA) del pozo.',
                      ),
                      controller: _numeroCaamtController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa el número de concesión de CONAGUA del pozo.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Información extra.',
                      ),
                      controller: _descripcionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa mas información sobre el pozo.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // Si el formulario es válido, haz algo
                          }
                        },
                        child: const Text('Enviar'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
