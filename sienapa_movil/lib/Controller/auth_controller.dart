import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sienapa_movil/Constants/auth_constants.dart';
import 'package:sienapa_movil/UI/login.dart';
import 'package:sienapa_movil/UI/lista_pozos.dart';

class AuthController extends GetxController{
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override

  void onReady(){
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSignIn.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    googleSignInAccount.bindStream(googleSignIn.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
    super.onReady();
  }

  _setInitialScreen(User? user){
    if(user == null){
      Get.offAll(()=>const Login());
    }
    else{
      Get.offAll(()=>const ListaPozos());
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount){
    print(googleSignInAccount);
    if(googleSignInAccount != null){
      Get.offAll(()=>const Login());
    }
    else{
      Get.offAll(()=>const ListaPozos());
    }
  }

  void signInWithGoogle()async{
    try{
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if(googleSignInAccount != null){
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken
        );
        await auth.signInWithCredential(credential).catchError((onError){
          print("Error is: $onError");
        });
      }
    }
    catch(e){
      Get.snackbar("Oops something happen...", e.toString(), snackPosition: SnackPosition.TOP, backgroundColor: Colors.red[400], margin: EdgeInsets.fromLTRB(10, 20, 10, 0), borderRadius: 10, colorText: Colors.white, animationDuration: Duration(seconds: 1), duration: Duration(milliseconds: 1500));
    }
  }

  void emailRegister(String email, String password)async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e){
      if(e.code == 'weak-password'){
        Get.snackbar('Algo sucedio...', 'Contraseña debil', snackPosition: SnackPosition.TOP, backgroundColor: Colors.red[400], margin: EdgeInsets.fromLTRB(10, 20, 10, 0), borderRadius: 10, colorText: Colors.white, animationDuration: Duration(seconds: 1), duration: Duration(milliseconds: 1500));
      }
      else if(e.code == 'email-already-in-use'){
        Get.snackbar('Algo sucedio...', 'Correo ya en uso', snackPosition: SnackPosition.TOP, backgroundColor: Colors.red[400], margin: EdgeInsets.fromLTRB(10, 20, 10, 0), borderRadius: 10, colorText: Colors.white, animationDuration: Duration(seconds: 1), duration: Duration(milliseconds: 1500));
      }
      else if(e.code == 'invalid-email'){
        Get.snackbar('Algo sucedio...', 'Correo invalido', snackPosition: SnackPosition.TOP, backgroundColor: Colors.red[400], margin: EdgeInsets.fromLTRB(10, 20, 10, 0), borderRadius: 10, colorText: Colors.white, animationDuration: Duration(seconds: 1), duration: Duration(milliseconds: 1500));
      }
    }
  }

  Future<void> emailLogin(String email, String password) async {
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch (e){
      if (e.code == 'user-not-found') {
        Get.snackbar('Algo sucedio...', 'Usuario no encontrado', snackPosition: SnackPosition.TOP, backgroundColor: Colors.red[400], margin: EdgeInsets.fromLTRB(10, 20, 10, 0), borderRadius: 10, colorText: Colors.white, animationDuration: Duration(seconds: 1), duration: Duration(milliseconds: 1500));
      }
      else if (e.code == 'wrong-password') {
        Get.snackbar('Algo sucedio...', 'Contraseña incorrecta', snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, margin: EdgeInsets.fromLTRB(10, 30, 10, 0), borderRadius: 10, colorText: Colors.white, animationDuration: Duration(seconds: 1), duration: Duration(milliseconds: 1500));
      }
      else if (e.code == 'invalid-email') {
        Get.snackbar('Algo sucedio...', 'Correo invalido', snackPosition: SnackPosition.TOP, backgroundColor: Colors.red, margin: EdgeInsets.fromLTRB(10, 30, 10, 0), borderRadius: 10, colorText: Colors.white, animationDuration: Duration(seconds: 1), duration: Duration(milliseconds: 1500));
    }
    }
  }

  void signOut() async{
    await auth.signOut();
  }
}