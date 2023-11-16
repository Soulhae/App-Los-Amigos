import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:soy_ese/bienvenido_page.dart';
// import 'package:soy_ese/facturas_page.dart';
// import 'package:soy_ese/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

Future<void> handleBackgroundMessage(RemoteMessage message) async{
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Data: ${message.data}');
}

typedef NotificationCallback = void Function(RemoteMessage message);

class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;
  NotificationCallback? onNotificationReceived;

  void handleMessage(RemoteMessage? message){
    // print('ola');
    if(message==null) return;
    // print('ola2');
    // print(message.data);
    onNotificationReceived?.call(message);

    // Navigator.of(context).push(
    //   MaterialPageRoute(
    //     builder: (context) => FacturasPage(idUsuario: idUsuario),
    //   ),
    // );
  }

  Future<void> sendNotification({
    required int idUsuario,
    required String nombreUsuario,
    required BuildContext context,
  }) async {
    await _localNotifications.show(
      0,
      'Recuerda revisar tus facturas!',
      '¡Bienvenido, $nombreUsuario!',
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChannel.id,
          _androidChannel.name,
          channelDescription: _androidChannel.description,
          icon: '@drawable/ic_launcher',
        ),
      ),
      payload: jsonEncode({'idUsuario': idUsuario}),
    );
    // print(idUsuario);
    // if(context.mounted){
    //   Navigator.of(context).push(
    //     MaterialPageRoute(
    //       builder: (context) => FacturasPage(idUsuario: idUsuario),
    //     ),
    //   );
    // }
  }

  Future initPushNotifications() async{
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
          alert: true,
          badge: true,
          sound: true,
        );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message){
      final notification = message.notification;
      // print(notification);
      // print(message.data);
      if(notification == null) return;

      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future initLocalNotifications() async{
    // const iOS = IOSInitializationSettings();     buscar cambio de nombre
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(android: android);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        final message = RemoteMessage.fromMap(jsonDecode(payload.payload!));
        // print(message);
        handleMessage(message);
      },
      
    );

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance,
  );
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async{
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('Token: $fCMToken');
    initPushNotifications();
    initLocalNotifications();
  }
}