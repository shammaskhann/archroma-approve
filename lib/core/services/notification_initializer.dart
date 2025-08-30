import 'dart:developer';
import 'package:arch_approve/core/services/notification/firebase_notification.dart';
import 'package:arch_approve/core/services/notification/notification_navigation_handler.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationInitializer {
  static void setupForegroundAndBackgroundHandlers() {
    // Request permissions
    FirebaseNotification.initialize();

    // Foreground message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("=== Foreground Message ===");
      log("ID: ${message.messageId}");
      log("Data: ${message.data}");

      final notification = message.notification;
      if (notification != null) {
        FirebaseNotification.showLocalNotification(
          notification.title ?? '',
          notification.body ?? '',
          message.data,
        );
      }
    });

    // Opened app from notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("=== Notification Opened App ===");
      log("ID: ${message.messageId}");
      log("Data: ${message.data}");
      NotificationNavigationHandler.handleTap(message.data);
    });

    // Initial message (cold start)
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        log("=== Initial Notification Message ===");
        log("ID: ${message.messageId}");
        log("Data: ${message.data}");
        NotificationNavigationHandler.handleTap(message.data);
      }
    });
  }
}
