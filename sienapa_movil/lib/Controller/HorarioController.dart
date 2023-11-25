import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Model/HorarioModel.dart';

class HorarioController extends GetxController{
  var horariolist = <HorarioModel>[].obs;
  var isLoading = false.obs;

  Future<void> getData() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('data/pozos').onValue.listen((event) {
        dynamic data = event.snapshot.value;
        horariolist.clear();
        data.forEach((key, value) {
          horariolist.add(HorarioModel(
              key,
              value['nombre'],
              value['estado_pozo']['estado'],
              value['horario']['dia1'],
              value['horario']['dia2'],
              value['horario']['dia3'],
              value['horario']['dia4'],
              value['horario']['dia5'],
              value['horario']['dia6'],
              value['horario']['dia7'],
              value['horario']['h_apagado'],
              value['horario']['h_encendido']
          ));
        });
      });
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}