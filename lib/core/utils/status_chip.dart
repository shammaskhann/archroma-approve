import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:flutter/material.dart';

Widget buildStatusChip(LeaveStatus status) {
  Color chipColor;
  String statusText;

  switch (status) {
    case LeaveStatus.pending:
      chipColor = Colors.orange;
      statusText = 'Pending';
      break;
    case LeaveStatus.accepted:
      chipColor = Colors.green;
      statusText = 'Approved';
      break;
    case LeaveStatus.rejected:
      chipColor = Colors.red;
      statusText = 'Rejected';
      break;
  }

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: chipColor.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: chipColor.withOpacity(0.3), width: 1),
    ),
    child: Text(
      statusText,
      style: TextStyle(
        color: chipColor,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
