import 'package:arch_approve/presentation/screens/apply_leaves/apply_leave_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildLeaveTypeDropdown(
  ApplyLeaveController controller,
  TextTheme theme,
) {
  final leaveTypes = [
    'Annual',
    'Medical',
    'Emergency',
    'Maternity',
    'Hospitalization',
    'Marriage',
    'Personal',
  ];

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.grey[300]!),
      borderRadius: BorderRadius.circular(8.r),
    ),
    child: DropdownButton<String>(
      value: controller.selectedLeaveType.value.isEmpty
          ? null
          : controller.selectedLeaveType.value,
      hint: Text("Select leave type", style: theme.labelSmall),
      items: leaveTypes.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value, style: theme.bodyMedium),
        );
      }).toList(),
      isExpanded: true,
      underline: SizedBox(),
      onChanged: (value) {
        if (value != null) controller.setLeaveType(value);
      },
    ),
  );
}
