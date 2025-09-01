import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/apply_leave_controller.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/widget/file_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildAttachmentSection(
  ApplyLeaveController controller,
  TextTheme theme,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Add Attachment Button
      Container(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: controller.isUploading.value ? null : controller.pickFile,
          icon: controller.isUploading.value
              ? SizedBox(
                  width: 16.w,
                  height: 16.h,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Icon(Icons.attach_file, size: 20.w),
          label: Text(
            controller.isUploading.value ? "Uploading..." : "Add Attachment",
          ),
          style: OutlinedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
      ),

      SizedBox(height: 12.h),

      // Selected File
      if (controller.selectedFile.value != null) ...[
        Text("Selected File:", style: theme.titleSmall),
        SizedBox(height: 8.h),
        buildFileItem(
          fileName: controller.selectedFile.value!.path.split('/').last,
          fileSize: controller.selectedFile.value!.lengthSync(),
          onRemove: controller.removeSelectedFile,
          theme: theme,
        ),
        SizedBox(height: 16.h),
      ],

      // Uploaded File
      if (controller.uploadedFile.value != null) ...[
        Text("Uploaded File:", style: theme.titleSmall),
        SizedBox(height: 8.h),
        buildFileItem(
          fileName: controller.uploadedFile.value!['fileName'],
          fileSize: controller.uploadedFile.value!['fileSize'],
          isUploaded: true,
          onRemove: controller.removeUploadedFile,
          theme: theme,
        ),
        SizedBox(height: 16.h),
      ],
    ],
  );
}
