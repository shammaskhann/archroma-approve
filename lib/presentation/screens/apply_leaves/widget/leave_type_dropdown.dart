import 'package:arch_approve/presentation/screens/apply_leaves/apply_leave_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // if you're using GetX for your controller

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart'; // if you're using GetX

Widget buildLeaveTypeDropdown(
  ApplyLeaveController controller,
  TextTheme theme,
) {
  final leaveTypes = [
    {'label': 'Full Day', 'icon': Icons.work},
    {'label': 'Half Day', 'icon': Icons.schedule},
    {'label': 'Annual', 'icon': Icons.event},
    {'label': 'Medical', 'icon': Icons.local_hospital},
    {'label': 'Emergency', 'icon': Icons.warning},
    {'label': 'Maternity', 'icon': Icons.child_friendly},
    {'label': 'Hospitalization', 'icon': Icons.hotel},
    {'label': 'Marriage', 'icon': Icons.favorite},
    {'label': 'Personal', 'icon': Icons.person},
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
            padding: EdgeInsets.only(top: 12.h, bottom: 24.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  "Select Leave Type",
                  style: theme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: leaveTypes.length,
                    separatorBuilder: (_, __) => Divider(
                      color: Colors.grey[300],
                      height: 1,
                      thickness: 1,
                      indent: 16.w,
                      endIndent: 16.w,
                    ),
                    itemBuilder: (context, index) {
                      final item = leaveTypes[index];
                      return ListTile(
                        leading: Icon(
                          item['icon'] as IconData,
                          color: Colors.grey[700],
                        ),
                        title: Text(
                          item['label'] as String,
                          style: theme.bodyLarge,
                        ),
                        onTap: () {
                          controller.setLeaveType(item['label'] as String);
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
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
              controller.selectedLeaveType.value.isEmpty
                  ? "Select leave type"
                  : controller.selectedLeaveType.value,
              style: theme.bodyMedium?.copyWith(
                color: controller.selectedLeaveType.value.isEmpty
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
