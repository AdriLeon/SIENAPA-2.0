import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Controller/auth_controller.dart';
import 'package:sienapa_movil/Controller/HomeController.dart';

//Create a Dialog Widget for Logout
class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Estas a punto de cerrar sesión'),
      content: const Text('¿Está seguro que desea cerrar sesión?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
            //cambiar al anterior elemento seleccionado del bottom navigation bar
            HomeController.to.changePage(0);
          },
          child: const Text('No'),
        ),
        TextButton(
          onPressed: () {
            AuthController.instance.signOut();
          },
          child: const Text('Si'),
        ),
      ],
    );
  }
}