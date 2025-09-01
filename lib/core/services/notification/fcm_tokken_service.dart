import 'dart:developer';
import 'dart:io';
import 'package:arch_approve/core/services/firebase/data_service.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:arch_approve/domain/repositories/firebase_data_repositroy.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final FirebaseDataService _firebaseDataRepository = FirebaseDataService();
    final oldToken = await UserPref.getDeviceToken();
    final _auth = FirebaseAuth.instance;
    final uid = _auth.currentUser?.uid;
    final token = await getToken();

    if (token != null && token != oldToken && uid != null) {
      await UserPref.setDeviceToken(token);
      await _firebaseDataRepository.updateDeviceToken(uid, token);
      log('Token updated in SharedPreferences and Firestore $uid: $token');
    } else {
      log(
        'Token is the same as old token or user is not logged in. No update needed.',
      );
    }
  }
}
