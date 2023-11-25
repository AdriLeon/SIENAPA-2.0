import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Model/UsuariosModel.dart';

class UsuariosController extends GetxController{
  var usuarioslist = <UserModel>[].obs;
  var isLoading = false.obs;

  Future<void> getData() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('data/usuarios').onValue.listen((event) {
        dynamic data = event.snapshot.value;
        usuarioslist.clear();
        data.forEach((key, value) {
          usuarioslist.add(UserModel(
              key,
              value['correo'],
              value['nivel'],
              value['logs']
          ));
        });
        // imprimir cada dato de usuarioslist
        usuarioslist.forEach((element) {
          print(element.email);
          print(element.nivel);
          element.logs.forEach((key, value) {
            print('Correo ${element.email} - Nivel: ${element.nivel} - Logs: ${value['fecha']} - ${value['actividad']}');
          });
        });
      });
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}