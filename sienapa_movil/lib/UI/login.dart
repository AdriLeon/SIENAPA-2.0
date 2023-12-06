import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Constants/auth_constants.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:sienapa_movil/Controller/auth_controller.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Image(
                image: AssetImage('assets/sienapa.png'),
                height: 150,
                width: 150,
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: Form(
                  child: Column(
                    children: [

                      const Text(
                        'Inicia Sesion',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _emailController,
                        decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: _passwordController,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                authController.emailLogin(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim());
                              },
                              child: const Text('Iniciar Sesion'))
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          child: SignInButton(
                        Buttons.google,
                        text: "Iniciar Sesion con Google",
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(5),
                        onPressed: () async {
                          authController.signInWithGoogle();
                        },
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
