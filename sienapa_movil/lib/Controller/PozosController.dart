import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:sienapa_movil/Model/PozosModel.dart';

class WordController extends GetxController {
  var pozoslist = <PozosModel>[].obs;
  var isLoading = false.obs;

  Future<void> getData() async {
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('data/pozos').onValue.listen((event) {
        dynamic data = event.snapshot.value;
        pozoslist.clear();
        data.forEach((key, value) {
          pozoslist.add(PozosModel(
              key,
              value['nombre'],
              value['convenio'],
              value['estado_pozo']['electricidad'],
              value['estado_pozo']['estado'],
              value['ubicacion'],
              value['informacion']
          ));
        });
      });
      isLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
