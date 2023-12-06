import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart'; // Importa shared_preferences
import 'package:sienapa_movil/Constants/auth_constants.dart';
import 'package:sienapa_movil/UI/home_page.dart';
import 'package:sienapa_movil/UI/home_page_operador.dart';
import 'package:sienapa_movil/UI/login.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;
  late Rx<GoogleSignInAccount?> googleSignInAccount;
  List<dynamic> idList = [];
  final bool isLoggedIn = false.obs.value;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(auth.currentUser);
    googleSignInAccount = Rx<GoogleSignInAccount?>(googleSignIn.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
    googleSignInAccount.bindStream(googleSignIn.onCurrentUserChanged);
    ever(googleSignInAccount, _setInitialScreenGoogle);
    super.onReady();
    _getId();
  }

  _getId() async {
    final ref = FirebaseDatabase.instance.ref();
    final usuarios = await ref.child('data/usuarios').get();
    //guardar los id en una lista
    dynamic snapshot = usuarios.value;
    snapshot.forEach((key, value) {
      idList.add(key);
    });
    print('ID List: $idList');
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => const Login());
    } else {
      final id = user.uid;
      //validar si el id se encuentra en idList
      if (idList.contains(id)) {
        print('ID: $id');
        final ref = FirebaseDatabase.instance.ref();
        final dataUser = await ref.child('data/usuarios/$id').get();
        dynamic snapshot = dataUser.value;
        print('Nivel: ${snapshot['nivel']}');
        print('Status: ${snapshot['status']}');
        if (snapshot['status'] == 'activo' &&
            snapshot['nivel'] == 'administrador') {
          isLoggedIn.obs.value = true;
          Get.offAll(() => const HomePage());
        } else if (snapshot['status'] == 'activo' && snapshot['nivel'] == 'operador') {
          isLoggedIn.obs.value = true;
          Get.offAll(() => const HomePageOperador());
        } else if (snapshot['status'] == 'inactivo') {
          Get.snackbar(
            "Cuenta inactiva",
            "Comunicate con el administrador para activar tu cuenta",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[400],
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            borderRadius: 10,
            colorText: Colors.white,
            animationDuration: const Duration(seconds: 1),
            duration: const Duration(milliseconds: 1500),
          );
        }
      }else{
        signOut();
        Get.snackbar(
          "No tienes acceso",
          "Comunicate con el administrador",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[400],
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          borderRadius: 10,
          colorText: Colors.white,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 1500),
        );
      }
    }
  }

  _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) async {
    print(googleSignInAccount);
    if (googleSignInAccount != null) {
      Get.offAll(() => const Login());
    } else {
      final id = googleSignInAccount?.id;
      if(idList.contains(id)){
        print('ID: $id');
        final ref = FirebaseDatabase.instance.ref();
        final dataUser = await ref.child('data/usuarios/$id').get();
        dynamic snapshot = dataUser.value;
        print('Nivel: ${snapshot['nivel']}');
        print('Status: ${snapshot['status']}');
        if (snapshot['status'] == 'activo' &&
            snapshot['nivel'] == 'administrador') {
          isLoggedIn.obs.value = true;
          Get.offAll(() => const HomePage());
        } else if (snapshot['status'] == 'activo' && snapshot['nivel'] == 'operador') {
          isLoggedIn.obs.value = true;
          Get.offAll(() => const HomePageOperador());
        } else if (snapshot['status'] == 'inactivo') {
          Get.snackbar(
            "Cuenta inactiva",
            "Comunicate con el administrador para activar tu cuenta",
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red[400],
            margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            borderRadius: 10,
            colorText: Colors.white,
            animationDuration: const Duration(seconds: 1),
            duration: const Duration(milliseconds: 1500),
          );
        }
      }else{
        signOut();
      }
    }
  }

  void signInWithGoogle() async {
    try {
      await googleSignIn.signIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        await auth.signInWithCredential(credential).catchError((onError) {
          print("Error is: $onError");
        });
      }
    } catch (e) {
      Get.snackbar(
        "Oops something happen...",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[400],
        margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
        borderRadius: 10,
        colorText: Colors.white,
        animationDuration: const Duration(seconds: 1),
        duration: const Duration(milliseconds: 1500),
      );
    }
  }

  void emailRegister(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          'Algo sucedio...',
          'Contraseña debil',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[400],
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          borderRadius: 10,
          colorText: Colors.white,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 1500),
        );
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          'Algo sucedio...',
          'Correo ya en uso',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[400],
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          borderRadius: 10,
          colorText: Colors.white,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 1500),
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Algo sucedio...',
          'Correo invalido',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[400],
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          borderRadius: 10,
          colorText: Colors.white,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 1500),
        );
      }
    }
  }

  Future<void> emailLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await _saveTokenAndId();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar(
          'Algo sucedio...',
          'Usuario no encontrado',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red[400],
          margin: const EdgeInsets.fromLTRB(10, 20, 10, 0),
          borderRadius: 10,
          colorText: Colors.white,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 1500),
        );
      } else if (e.code == 'wrong-password') {
        Get.snackbar(
          'Algo sucedio...',
          'Contraseña incorrecta',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
          borderRadius: 10,
          colorText: Colors.white,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 1500),
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          'Algo sucedio...',
          'Correo invalido',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
          borderRadius: 10,
          colorText: Colors.white,
          animationDuration: const Duration(seconds: 1),
          duration: const Duration(milliseconds: 1500),
        );
      }
    }
  }

  void signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }

  Future<void> _saveTokenAndId() async {
    try {
      String token = await auth.currentUser?.getIdToken() ?? '';
      String uid = auth.currentUser?.uid ?? '';

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('id', uid);
    } catch (e) {
      print("Error al obtener el token: $e");
    }
  }


  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('Token: ${prefs.getString('token')}');
    return prefs.getString('token');
  }

  // Obtener el ID almacenado
  Future<String?> getId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }
}