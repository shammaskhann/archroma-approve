import 'package:arch_approve/presentation/screens/apply_leaves/apply_leave_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget buildDurationDropdown(ApplyLeaveController controller, TextTheme theme) {
  final durations = [
    {'label': 'Full Day', 'deduct': true},
    {'label': 'Half Day', 'deduct': false},
  ];

  return GestureDetector(
    onTap: () {
      showModalBottomSheet(
        context: Get.context!,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        builder: (context) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: durations.map((item) {
                return ListTile(
                  title: Text(item['label'].toString()!),
                  onTap: () {
                    controller.setLeaveDuration(
                      item['label'].toString(),
                      bool.parse(item['deduct'].toString()),
                    );
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ),
          );
        },
      );
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(
            () => Text(
              controller.selectedLeaveDuration.value.isEmpty
                  ? "Select leave duration"
                  : controller.selectedLeaveDuration.value,
              style: theme.bodyMedium?.copyWith(
                color: controller.selectedLeaveDuration.value.isEmpty
                    ? Colors.grey
                    : Colors.black,
              ),
            ),
          ),
          Icon(Icons.arrow_drop_down, color: Colors.grey),
        ],
      ),
    ),
  );
}
