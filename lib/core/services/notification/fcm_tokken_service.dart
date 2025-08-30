import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';

class FcmTokenService {
  static Future<String?> getToken() async {
    if (Platform.isAndroid) {
      final token = await FirebaseMessaging.instance.getToken();
      log('FCM Token: $token');
      return token;
    } else {
      final token = await FirebaseMessaging.instance.getAPNSToken();
      log('APNS FCM Token: $token');
      return token;
    }
  }

  static Future<void> updateToken() async {
    final token = await getToken();
    if (token != null) {
      log('Updating token in database');
      //  await UserProvider.updateTokenInDatabase(token);
    } else {
      log('Token is null');
    }
  }
}
