import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//se requiere que desde aqui nos escuche my app
class PushNotificationService {
  //envia eventos e información a otros widget, canal por donde pasan datos
  //broadcast mas de un widget que se suscriba (que escuche notificaciones)
  static StreamController<String> _msjStream = new StreamController.broadcast();
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static Stream<String> get messagesStream => _msjStream.stream;
  //cada dispositivo que descargue nuestra app debe tener un token - una cadena que contiene información
  //codificada y cuando se decodifica se puede acceder a esa info
  //nombre usuario - fecha - datos -
  //los token son únicos para un usuario - aplicación
  //app1 - disp1 - obtener un token -> pedir firebase - regresa el TOKEN-A - recibir notificaciones
  //app2 - disp2 - obtener un token -> pedir firebase - regresa el TOKEN-B - recibir notificaciones
  static String? token;
  static Future initApp() async {
    //inicializa y carga los valores de los archivos de firebase
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('TOKEN Firebase: $token');

    FirebaseMessaging.onBackgroundMessage(_backgroundController);
    FirebaseMessaging.onMessage.listen(_onMsjController);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMsjOpenApp);
  }

  static Future _backgroundController(RemoteMessage msj) async {
    print('Estado BACKGROUND segundo plano');
    _msjStream.add(msj.notification?.body ?? 'No body');
  }

  static Future _onMsjController(RemoteMessage msj) async {
    print('Estado FOREGROUND abierta');
    //print('MENSAJE NOTIFICACION ${msj.messageId}');
    print('MENSAJE TITULO ${msj.notification?.title}');
    _msjStream.add(msj.notification?.body ?? 'No body');
    _msjStream.add(msj.data['usuario'] ?? 'No hay datos');
    print('MENSAJE DATOS-DATA datos adicionales: ${msj.data}');
  }

  static Future _onMsjOpenApp(RemoteMessage msj) async {
    print('Estado OPEN APP cerrada');
    _msjStream.add(msj.notification?.body ?? 'No body');
  }

  static closedStreams() {
    _msjStream.close();
  }
}
