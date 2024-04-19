import 'dart:developer';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FCMService extends GetxService {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    sound: RawResourceAndroidNotificationSound("ringtone"),

  );
  bool _initialized = false;
  Future<void> init() async {
    if (!_initialized) {
      initFCM();
      AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings("@drawable/ic_notification");
      const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.initialize(initializationSettingsIOS);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      final InitializationSettings initializationSettings =
      InitializationSettings(android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
      await flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: selectNotification);
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      _initialized = true;
    }
  }
  Future selectNotification(NotificationResponse? notificationResponse) async {
    debugPrint("selectNotification :: ${notificationResponse?.payload}");
    String payload = notificationResponse?.payload ?? "{clickAction: Home}";
   openAppFromFindActionNotification();
  }
  void initFCM() async {
    if (!_initialized) {
      if (Platform.isIOS) {
        FirebaseMessaging.instance.requestPermission();
        // FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        //   alert: true,
        //   badge: true,
        //   sound: true,
        // );
      }
      FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
        debugPrint(" MESSAGE :: ${message?.data.toString()}");
        if (message != null) {
          openAppFromFindActionNotification();
        }
      });
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        debugPrint("------------ ON MESSAGE $message");
        //in a ios when set this my notification show twice when open app so set as below :
        if (!Platform.isIOS) {
          showNotification(message);
        }
      });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
        debugPrint("-------------- ON onMessageOpenedApp ${message?.data}");
        if (message != null) {
          openAppFromFindActionNotification();
        }
      });
    }
  }
  void showNotification(RemoteMessage message) async {
    debugPrint("==========>showNotification ${message.data}");
    // ignore: unused_local_variable
    AndroidNotification? android = message.notification?.android;
    if (!isNullEmptyOrFalse(message.data)) {
      flutterLocalNotificationsPlugin.show(
          0,
          message.notification?.title,
          message.notification?.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
              icon: "@drawable/ic_notification",
              sound: RawResourceAndroidNotificationSound("ringtone"),

            ),
            iOS: const DarwinNotificationDetails(
              presentAlert: true,
              presentSound: true,
              presentBadge: true,
            ),
          ),
          payload: "${message.data}");
    }
  }
}
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log('Handling a background message ${message.messageId}');
  // openAppFromFindActionNotification(findAction: message.data['clickAction'].trim());
}
bool isNullEmptyOrFalse(dynamic o) {
  if (o is Map<String, dynamic> || o is List<dynamic>) {
    return o == null || o.length == 0;
  }
  return o == null || false == o || "" == o;
}
void openAppFromFindActionNotification(
){  // Handle opening the app based on findAction

}





