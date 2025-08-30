import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';

class NotificationNavigationHandler {
  static void handleTap(Map<String, dynamic> data) {
    final type = data['notification_type'];
    log('Notification tapped: $data');

    switch (type) {
      case 'appointment_confirmed':
        // Get.offAllNamed(
        //   AppRoutesConstant.dashboard,
        //   arguments: {'navIndex': 1, 'notificationDoctor': null},
        // );
        break;

      case 'appointment_cancelled':
        try {
          // final doctorData = jsonDecode(data['doctor']);
          // final doctor = DoctorModel.fromJson(doctorData);
          // Get.offAllNamed(
          //   AppRoutesConstant.dashboard,
          //   arguments: {'navIndex': null, 'notificationDoctor': doctor},
          // );
        } catch (e) {
          log('Error parsing doctor data: $e');
        }
        break;

      case 'appointment_requested':
        // Get.offAll(() => DashboardScreen(navIndex: 1));
        break;

      default:
        log('Unknown notification type: $type');
      // Get.offAllNamed(AppRoutesConstant.dashboard);
    }
  }
}
