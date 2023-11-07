import 'package:flutter/material.dart';

class ModificarUsuarioPage extends StatelessWidget {
  const ModificarUsuarioPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Modificar Usuario',
      home: ModificarUsuario(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ModificarUsuario extends StatefulWidget {
  const ModificarUsuario({Key? key});

  @override
  State<ModificarUsuario> createState() => _ModificarUsuarioState();
}

class _ModificarUsuarioState extends State<ModificarUsuario> {
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
        title: const Text('Modificar Usuario'),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Procesar la información y modificar el usuario
                          final correo = _correoController.text;
                          final numeroControl = _numeroControlController.text;
                          final nivel = _selectedNivel;
                          final contrasena = _contrasenaController.text;

                          // Puedes utilizar estos valores para modificar el usuario en tu sistema.
                        }
                      },
                      child: const Text('Modificar'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Agregar lógica para eliminar al usuario
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      child: const Text('Eliminar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
