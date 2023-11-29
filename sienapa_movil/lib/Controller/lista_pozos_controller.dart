import 'package:get/get.dart';
import 'package:firebase_database/firebase_database.dart';

class ListaController {
  // Cambiar el estado del pozo
  Future<void> cambiarEstadoPozo(String pozoID, String estadoActual) async {
    try {
      final ref = FirebaseDatabase.instance.ref('data/pozos/$pozoID/estado_pozo/estado');

      // Cambiar el estado a "Encendido" si es "Apagado" y viceversa
      String nuevoEstado = (estadoActual == 'Apagado') ? 'Encendido' : 'Apagado';

      await ref.set(nuevoEstado);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
