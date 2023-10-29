import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Constants/auth_constants.dart';
import 'package:sienapa_movil/Controller/HomeController.dart';
import 'package:sienapa_movil/Controller/auth_controller.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
    Get.put(HomeController());
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
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF518DC3),
          ),
          scaffoldBackgroundColor: const Color(0xFFE5E5E5)
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF152B3E),
        ),
        scaffoldBackgroundColor: const Color(0xFF4D4D4D),
        cardColor: const Color(0xFF898989),
      ),
      themeMode: ThemeMode.system,
      title: 'Flutter Demo',
      // we don't really have to put the home page here
      // GetX is going to navigate the user and clear the navigation stack
      home: SizedBox(),
    );
  }
}

