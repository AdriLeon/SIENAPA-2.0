import 'package:flutter/material.dart';
import 'package:sienapa_movil/UI/lista_pozos.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE5E5E5),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,),
                Image(image: AssetImage('assets/sienapa.png'), height: 150, width: 150,),
                Padding(padding: EdgeInsets.all(16),
                  child: Form(
                    // key: controller.formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Inicia Sesión',
                          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)
                          ,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          // validator: controller.emailValidator,
                          keyboardType: TextInputType.emailAddress,
                          // controller: controller.emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          // onSaved: (value) {
                          //   controller.email = value! as RxString;
                          // },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        TextFormField(
                          // validator: controller.passwordValidator,
                          obscureText: true,
                          // controller: controller.passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          // onSaved: (value) {
                          //   controller.password = value! as RxString;
                          // },
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          height: 50,
                          width: 150,
                          child: MaterialButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ListaPozos() ));
                          },
                            color: const Color(0xff599EAC),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Text('Ingresar', style: TextStyle(color: Colors.white, fontSize: 20),),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
        ));
    //Center(child: Text(Get.find<LoginPageController>().title.value)));
  }
}
