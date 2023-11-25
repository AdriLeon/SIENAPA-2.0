import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static bool notificationShown = false; // Indicador para rastrear si la notificación ya se mostró

  static Future init() async {
    // Configura un temporizador para ejecutar la validación cada minuto
    Timer.periodic(Duration(minutes: 1), (timer) {
      validateDatabaseAndNotify();
    });

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('splash');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) => null);
    final LinuxInitializationSettings initializationSettingsLinux =
    LinuxInitializationSettings(defaultActionName: 'Open notification');
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin,
        linux: initializationSettingsLinux);
    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          // Se establece la variable de indicación como false cuando se hace clic en la notificación
          notificationShown = false;
        });
  }
  static void validateDatabaseAndNotify() {
    DateTime now = DateTime.now();
    try {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = ref.child('/data/pozos').once().then((event) {
        dynamic data = event.snapshot.value;
        for (var key in data.keys) {
          var nombre = data[key]['nombre'];
          var hora = data[key]['estado_pozo']['hora'];
          print('Nombre: $nombre - Hora: $hora');
          if (hora != formattedCurrentTime(now) && !notificationShown) {
            showSimpleNotification(
              title: 'Error',
              body: 'Algo falló en el $nombre',
              payLoad: '',
            );
            notificationShown = true; // Se establece la variable de indicación como true después de mostrar la notificación
            print('ERROR! Hora db: ${hora} - Hora actual: ${formattedCurrentTime(now)}');
          } else {
            print(
                'Hora db: ${hora} - Hora actual: ${formattedCurrentTime(now)}');
          }
        }
      });
    } catch (e) {
      print(e);
    }
  }
  static Future showSimpleNotification({
    String? title,
    String? body,
    String? payLoad,
  }) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('your channel id', 'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);
    await _flutterLocalNotificationsPlugin
        .show(0, title, body, notificationDetails, payload: payLoad);
  }
  static String formattedCurrentTime(DateTime dateTime) {
    return '${dateTime.hour}:${dateTime.minute}';
  }
}