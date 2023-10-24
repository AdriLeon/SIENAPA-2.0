import 'dart:async';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:sienapa_movil/UI/login.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
        logo: Image.asset('assets/SIENAPA1.png'),
      title: Text(
        "SIENAPA",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
      backgroundColor: Color(0xFF518DC3),
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: Login(),
      durationInSeconds: 8,
    );
  }
}
