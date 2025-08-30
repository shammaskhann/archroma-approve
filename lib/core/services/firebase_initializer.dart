import 'dart:developer';
import 'dart:io';
import 'package:arch_approve/core/services/notification/firebase_notification.dart';
import 'package:arch_approve/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseInitializer {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Future.delayed(Duration(seconds: 2));

    // Background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Local notifications
    await FirebaseNotification.initialize();
    //getAPNSToken();
  }

  static Future<void> getAPNSToken() async {
    final firebaseMessaging = FirebaseMessaging.instance;
    if (Platform.isIOS) {
      String? apnsToken = await firebaseMessaging.getAPNSToken();
      log('APNS Token: $apnsToken', name: "Firebase.FCM.APNS-TOKEN");
      await Future.delayed(Duration(seconds: 2));
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _firebaseMessagingBackgroundHandler(
    RemoteMessage message,
  ) async {
    await Firebase.initializeApp();
    log("=== Incoming Background Message ===");
    log("ID: ${message.messageId}");
    log("Data: ${message.data}");
    log("Notification: ${message.notification}");
  }
}
