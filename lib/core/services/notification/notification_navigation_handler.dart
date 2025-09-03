import 'dart:convert';
import 'dart:developer';
import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:get/get.dart';

class NotificationNavigationHandler {
  static void handleTap(Map<String, dynamic> data) async {
    final type = data['notification_type'];
    log('Notification tapped: $data');

    switch (type) {
      default:
        String? role = await UserPref.getRole();
        if (role == "admin") {
          Get.offAllNamed(
            AppRoutesConstant.adminDashboard,
            arguments: {"index": 2}, // 👈 go to AdminRequestScreen for admin
          );
        } else if (role == "employee") {
          Get.offAllNamed(
            AppRoutesConstant.dashboard,
            arguments: {"index": 1}, // 👈 go to LeaveHistoryScreen for employee
          );
        } else {
          Get.offAllNamed(AppRoutesConstant.login);
        }
    }
  }
}
