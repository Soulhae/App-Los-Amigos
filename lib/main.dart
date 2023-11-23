import 'package:flutter/material.dart';
import 'notifiers.dart';
// import 'bienvenido_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'api/firebase_api.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'facturas_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseApi firebaseApi = FirebaseApi();

  firebaseApi.onNotificationReceived = (RemoteMessage message){
    final Map<String, dynamic> data = message.data;
    final int idUsuario = int.parse(data['idUsuario']);

    // print(message);
    // print(idUsuario);

    Navigator.of(navigatorKey.currentContext!).push(
      MaterialPageRoute(
        builder: (context) => FacturasPage(idUsuario: idUsuario),
      ),
    );
  };

  await FirebaseApi().initNotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkModeNotifier,
      builder: (context, isDark, child){
        return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
      },
    );
      }); 
  }
}