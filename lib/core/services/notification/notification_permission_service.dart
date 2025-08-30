import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationPermissionService {
  static Future<void> requestPermissions() async {
    final settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        log('User granted full permission');
        break;
      case AuthorizationStatus.provisional:
        log('User granted provisional permission');
        break;
      default:
        log('User declined permission');
    }
  }
}
