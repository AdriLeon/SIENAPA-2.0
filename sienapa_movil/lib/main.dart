import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/UI/login.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/Home',
    defaultTransition: Transition.fade,
    getPages: [
      GetPage(name: '/Home', page: () => Login()),
    ],
  ));
}