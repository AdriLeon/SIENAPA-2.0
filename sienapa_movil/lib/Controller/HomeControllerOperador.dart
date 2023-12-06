import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/UI/control-pozo.dart';
import 'package:sienapa_movil/UI/lista_pozos.dart';
import 'package:sienapa_movil/UI/logout.dart';
import 'package:sienapa_movil/UI/reportes_page.dart';

class HomeControllerOperador extends GetxController {
  static HomeControllerOperador get to => Get.find();
  var currentIndex = 0.obs;

  final pages = <String> [
    '/ListaPozos',
    '/ControlRemoto',
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
    if(settings.name == '/ControlRemoto'){
      return GetPageRoute(
        settings: settings,
        page: () => ControlPozoPage(),
      );
    }
    if(settings.name == '/Reportes'){
      return GetPageRoute(
        settings: settings,
        page: () => ReportesPage(),
      );
    }
    if(settings.name == '/CerrarSesion'){
      return GetPageRoute(
        settings: settings,
        page: () => const LogoutDialog(),
      );
    }
  }
}