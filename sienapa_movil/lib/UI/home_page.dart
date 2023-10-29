import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Controller/HomeController.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: Get.nestedKey(1),
        initialRoute: '/ListaPozos',
        onGenerateRoute: controller.onGenerateRoute,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          selectedItemColor: const Color(0xFF1D508E),
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Lista Pozos',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_remote),
              label: 'Control Remoto',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.supervised_user_circle),
              label: 'Usuarios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_page_break_sharp),
              label: 'Reportes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout),
              label: 'Cerrar Sesion',
            ),
          ],
        ),
      ),
    );
  }
}
