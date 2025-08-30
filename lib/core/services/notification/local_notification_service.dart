import 'dart:convert';
import 'dart:developer';
import 'package:arch_approve/core/services/notification/notification_navigation_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const settings = InitializationSettings(android: androidInit, iOS: iosInit);

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) {
        if (payload.payload == null) return;
        try {
          final data = json.decode(payload.payload!);
          log('Parsed notification data: $data');
          NotificationNavigationHandler.handleTap(data);
        } catch (e) {
          log('Error parsing notification payload: $e');
        }
      },
    );
  }

  Future<void> showNotification(
    String title,
    String body,
    Map<String, dynamic> payload,
  ) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(0, title, body, details, payload: json.encode(payload));
  }
}
