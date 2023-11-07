import 'package:flutter/material.dart';

class AgregarUsuarioPage extends StatelessWidget {
  const AgregarUsuarioPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Agregar Usuario',
      home: AgregarUsuario(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AgregarUsuario extends StatefulWidget {
  const AgregarUsuario({Key? key});

  @override
  State<AgregarUsuario> createState() => _AgregarUsuarioState();
}

class _AgregarUsuarioState extends State<AgregarUsuario> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _numeroControlController = TextEditingController();
  String _selectedNivel = 'Operador'; // Valor predeterminado
  final TextEditingController _contrasenaController = TextEditingController();

  final List<String> niveles = ['Administrador', 'Operador'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Usuario'),
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
                    labelText: 'Correo',
                    border: OutlineInputBorder(),
                  ),
                  controller: _correoController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el correo.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'N° de Control',
                    border: OutlineInputBorder(),
                  ),
                  controller: _numeroControlController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa el N° de control.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedNivel,
                  items: niveles.map((String nivel) {
                    return DropdownMenuItem<String>(
                      value: nivel,
                      child: Text(nivel),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedNivel = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: 'Nivel',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                  ),
                  controller: _contrasenaController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, ingresa la contraseña.';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final correo = _correoController.text;
                        final numeroControl = _numeroControlController.text;
                        final nivel = _selectedNivel;
                        final contrasena = _contrasenaController.text;

                        //Codigo para agregar el usuario al sistema
                      }
                    },
                    child: const Text('Agregar Usuario'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
