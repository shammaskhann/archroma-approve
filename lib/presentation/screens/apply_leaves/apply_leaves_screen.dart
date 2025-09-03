import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/presentation/components/app_button.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/apply_leave_controller.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/widget/attachment_section.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/widget/duaration_dropdown.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/widget/leave_type_dropdown.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/widget/select_date_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ApplyLeavesScreen extends StatelessWidget {
  final String leaveType;
  const ApplyLeavesScreen({super.key, this.leaveType = ""});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ApplyLeaveController());
    TextTheme theme = Theme.of(context).textTheme;

    if (leaveType != "") {
      controller.setLeaveType(leaveType);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Apply Leave"),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Leave Application Form", style: theme.headlineMedium),
              SizedBox(height: 8.h),
              Text(
                "Please provide information about your leave.",
                style: theme.labelSmall?.copyWith(color: Colors.grey[600]),
              ),
              SizedBox(height: 24.h),

              // Leave Type
              _buildSectionTitle("Leave Type", theme),
              SizedBox(height: 8.h),
              buildLeaveTypeDropdown(controller, theme),
              SizedBox(height: 20.h),
              _buildSectionTitle("Leave Duration", theme),
              SizedBox(height: 8),
              buildDurationDropdown(controller, theme),
              SizedBox(height: 20.h),
              // Date Selection
              Obx(() {
                if (controller.selectedLeaveDuration.value == 'Half Day') {
                  // Show only one Date (assign to both start & end)
                  return _buildSectionTitle("Select Date", theme);
                } else {
                  return _buildSectionTitle("Date Range", theme);
                }
              }),
              SizedBox(height: 8.h),
              Obx(() {
                if (controller.selectedLeaveDuration.value == 'Half Day') {
                  return buildDateField("Select Date", controller.startDate, (
                    date,
                  ) {
                    controller.setStartDate(date);
                    controller.setEndDate(date);
                  }, theme);
                } else {
                  // For Full Day, show range option
                  return Row(
                    children: [
                      Expanded(
                        child: buildDateField(
                          "Start Date",
                          controller.startDate,
                          (date) {
                            controller.setStartDate(date);
                            controller.setEndDate(date); // Initially same
                          },
                          theme,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: buildDateField("End Date", controller.endDate, (
                          date,
                        ) {
                          controller.setEndDate(date);
                        }, theme),
                      ),
                    ],
                  );
                }
              }),

              SizedBox(height: 20.h),

              // Reason
              _buildSectionTitle("Reason", theme),
              SizedBox(height: 8.h),
              _buildTextField(
                hint: "Enter reason for leave",
                onChanged: controller.setReason,
                maxLines: 2,
                theme: theme,
              ),
              SizedBox(height: 20.h),

              // Attachments
              _buildSectionTitle("Attachments", theme),
              SizedBox(height: 8.h),
              buildAttachmentSection(controller, theme),
              SizedBox(height: 24.h),

              // Error Message
              if (controller.errorMessage.isNotEmpty)
                Container(
                  padding: EdgeInsets.all(12.w),
                  margin: EdgeInsets.only(bottom: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Text(
                    controller.errorMessage.value,
                    style: TextStyle(color: Colors.red[700]),
                  ),
                ),

              // Submit Button
              AppButton(
                showGradient: false,
                text: "Submit",
                isLoading: controller.isSubmitting.value,
                onPressed: () async {
                  await controller.submitLeaveApplication();
                  Get.offAllNamed(AppRoutesConstant.dashboard);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, TextTheme theme) {
    return Text(
      title,
      style: theme.titleSmall?.copyWith(
        fontWeight: FontWeight.w600,
        color: kBlackColor,
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    required Function(String) onChanged,
    int maxLines = 1,
    required TextTheme theme,
  }) {
    return TextField(
      onChanged: onChanged,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: theme.labelSmall,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: kPrimaryColor),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }
}
