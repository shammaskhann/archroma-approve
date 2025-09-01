import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget buildDateField(
  String label,
  RxString dateValue,
  Function(String) onDateSelected,
  TextTheme theme,
) {
  return GestureDetector(
    onTap: () async {
      final date = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)),
      );
      if (date != null) {
        onDateSelected(
          "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        );
      }
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Icon(Icons.calendar_today, size: 20.w, color: Colors.grey[600]),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              dateValue.value.isEmpty ? label : dateValue.value,
              style: TextStyle(
                color: dateValue.value.isEmpty ? Colors.grey[600] : kBlackColor,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
