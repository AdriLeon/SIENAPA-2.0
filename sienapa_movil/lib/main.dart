import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Constants/auth_constants.dart';
import 'package:sienapa_movil/Controller/auth_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await firebaseInitialization.then((value) {
    Get.put(AuthController());
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: CircularProgressIndicator(),
    );
  }
}


