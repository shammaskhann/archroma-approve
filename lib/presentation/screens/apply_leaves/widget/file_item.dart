import 'package:arch_approve/presentation/screens/apply_leaves/apply_leave_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget buildFileItem({
  required String fileName,
  required int fileSize,
  bool isUploaded = false,
  required VoidCallback onRemove,
  required TextTheme theme,
}) {
  final controller = Get.find<ApplyLeaveController>();
  return Container(
    margin: EdgeInsets.only(bottom: 8.h),
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: isUploaded ? Colors.green[50] : Colors.grey[50],
      border: Border.all(
        color: isUploaded ? Colors.green[200]! : Colors.grey[300]!,
      ),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: Row(
      children: [
        Icon(
          isUploaded ? Icons.check_circle : Icons.insert_drive_file,
          color: isUploaded ? Colors.green : Colors.grey[600],
          size: 20.w,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                fileName,
                style: theme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                controller.getFileSize(fileSize),
                style: theme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onRemove,
          icon: Icon(Icons.close, size: 18.w, color: Colors.red),
          padding: EdgeInsets.zero,
          constraints: BoxConstraints(),
        ),
      ],
    ),
  );
}
