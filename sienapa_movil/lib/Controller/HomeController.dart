import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/UI/lista_pozos.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();
  var currentIndex = 0.obs;

  final pages = <String> [
    '/ListaPozos',
    '/ControlRemoto',
    '/Usuarios',
    '/Reportes',
    '/CerrarSesion',
  ];

  void changePage(int index) {
    currentIndex.value = index;
    Get.toNamed(pages[index], id: 1);
  }

  Route? onGenerateRoute(RouteSettings settings) {
    if(settings.name == '/ListaPozos'){
      return GetPageRoute(
        settings: settings,
        page: () => ListaPozos(),
      );
    }
    if(settings.name == '/Profile'){
      return GetPageRoute(
        settings: settings,
        page: () => ListaPozos(),
      );
    }
    if(settings.name == '/ControlRemoto'){
      return GetPageRoute(
        settings: settings,
        page: () => ListaPozos(),
      );
    }
    if(settings.name == '/Usuarios'){
      return GetPageRoute(
        settings: settings,
        page: () => ListaPozos(),
      );
    }
    if(settings.name == '/Reportes'){
      return GetPageRoute(
        settings: settings,
        page: () => ListaPozos(),
      );
    }
    if(settings.name == '/CerrarSesion'){
      return GetPageRoute(
        settings: settings,
        page: () => ListaPozos(),
      );
    }
  }
}