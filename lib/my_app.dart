import 'package:flutter/material.dart';
import 'package:notificaciones_wear/screens/home.dart';
import 'package:notificaciones_wear/screens/message_screen.dart';
import 'package:notificaciones_wear/screens/principal_screen.dart';
import 'package:notificaciones_wear/services/push_notification_service.dart';


//convertir a statefulwidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    PushNotificationService.messagesStream.listen((mensaje) {
      print('------------DESDE MYAPP mensaje: $mensaje');

      navigatorKey.currentState?.pushNamed('/mensaje', arguments: mensaje);

      final snackBar =
          SnackBar(content: Text('Esto es snackbar msj: $mensaje'));
      scaffoldKey.currentState?.showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notificaciones push',
      initialRoute: '/home',
      scaffoldMessengerKey: scaffoldKey,
      navigatorKey: navigatorKey,
      routes: {
        '/home': (_) => const Home(),
        '/mensaje': (_) => const MessageScreen(),
        '/principal': (_) => EnviarNotificacionScreen(),
      },
    );
  }
}
