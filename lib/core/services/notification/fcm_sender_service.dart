import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'fcm_auth_service.dart';

class FcmSenderService {
  static const String _endpoint =
      'https://fcm.googleapis.com/v1/projects/archroma-approve/messages:send';

  static Future<void> sendNotification(
    String deviceToken,
    String title,
    String body,
    Map<String, String> data,
  ) async {
    try {
      final serverKey = await FcmAuthService.getAccessToken();
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $serverKey',
      };

      final payload = {
        "message": {
          "token": deviceToken,
          "notification": {"title": title, "body": body},
          "data": data,
          "android": {
            "notification": {"click_action": "FLUTTER_NOTIFICATION_CLICK"},
          },
          "apns": {
            "payload": {
              "aps": {
                "alert": {"title": title, "body": body},
                "sound": "default",
              },
            },
          },
        },
      };

      final response = await http.post(
        Uri.parse(_endpoint),
        headers: headers,
        body: json.encode(payload),
      );

      if (response.statusCode == 200) {
        log('Notification sent successfully');
      } else {
        log('Failed to send notification: ${response.body}');
      }
    } catch (e) {
      log('Error sending notification: $e');
    }
  }
}
