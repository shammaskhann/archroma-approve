import 'package:arch_approve/core/services/notification/fcm_tokken_service.dart';
import 'package:arch_approve/core/services/notification/local_notification_service.dart';
import 'package:arch_approve/core/services/notification/notification_permission_service.dart';

class FirebaseNotification {
  static final LocalNotificationService _localService =
      LocalNotificationService();

  static Future<void> initialize() async {
    await _localService.initialize();
    await FcmTokenService.updateToken();
    await NotificationPermissionService.requestPermissions();
  }

  static void showLocalNotification(
    String title,
    String body,
    Map<String, dynamic> payload,
  ) {
    _localService.showNotification(title, body, payload);
  }
}
