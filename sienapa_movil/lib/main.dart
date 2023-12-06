import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Constants/auth_constants.dart';
import 'package:sienapa_movil/Controller/HomeController.dart';
import 'package:sienapa_movil/Controller/auth_controller.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sienapa_movil/UI/localNoti.dart';
import 'package:sienapa_movil/UI/theme.dart';

import 'Controller/HomeControllerOperador.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalNotification.init();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
    Get.put(HomeController());
    Get.put(HomeControllerOperador());
  });
  FlutterNativeSplash.preserve(widgetsBinding: WidgetsFlutterBinding.ensureInitialized());
  runApp(const MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      title: 'Flutter Demo',
      // we don't really have to put the home page here
      // GetX is going to navigate the user and clear the navigation stack
      home: SizedBox(),
    );
  }
}

