import 'dart:developer';

import 'package:arch_approve/core/utils/formate_date.dart';
import 'package:arch_approve/core/utils/status_chip.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:arch_approve/presentation/components/attachment_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveHistoryItem extends StatelessWidget {
  final LeaveModel leave;
  final VoidCallback onViewDetails;

  const LeaveHistoryItem({
    Key? key,
    required this.leave,
    required this.onViewDetails,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey.shade50, Colors.grey.shade100],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Name: ",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  leave.user.name, // <-- shows the user's name
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            // Content
            _buildLeaveInfo(leave),
          ],
        ),
      ),
    );
  }

  Widget _buildLeaveInfo(LeaveModel leave) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leave Type and Status
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leave.leaveType,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isSameDateString(leave.startDate, leave.endDate)
                        ? formatStringDate(leave.startDate)
                        : '${formatStringDate(leave.startDate)} → ${formatStringDate(leave.endDate)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            buildStatusChip(leave.status),
          ],
        ),

        const SizedBox(height: 16),

        // Row(
        //   children: [
        //     Text(
        //       'Reason:',
        //       style: TextStyle(
        //         fontSize: 14,
        //         fontWeight: FontWeight.w600,
        //         color: Colors.grey.shade700,
        //       ),
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 4),
        // Text(
        //   leave.reason,
        //   style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        //   maxLines: 2,
        //   overflow: TextOverflow.ellipsis,
        // ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 📝 Reason (Left side)
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reason:',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    leave.reason,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            /// ✅ Approved By / ❌ Rejected Reason (Right side)
            if (leave.status == LeaveStatus.accepted ||
                leave.status == LeaveStatus.rejected)
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      leave.status == LeaveStatus.accepted
                          ? 'Approved By:'
                          : 'Rejected Reason:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      leave.status == LeaveStatus.accepted
                          ? (leave.approvedBy ?? 'N/A')
                          : (leave.rejectionReason ?? 'Not provided'),
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
          ],
        ),

        const SizedBox(height: 16),

        // Additional Details
        Row(
          children: [
            Expanded(
              child: _buildDetailItem(
                icon: Icons.calendar_today,
                label: 'Submitted',
                value: _formatDate(leave.submittedAt),
              ),
            ),
            Expanded(
              child: _buildDetailItem(
                icon: Icons.update,
                label: 'Updated',
                value: _formatDate(leave.updatedAt),
              ),
            ),
          ],
        ),

        if (leave.attachment != null) ...[
          const SizedBox(height: 16),
          buildAttachmentInfo(leave.attachment!),
        ],

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 16, color: Colors.grey.shade600),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _viewLeaveDetails(LeaveModel leave) {
    // Navigate to leave details screen
    // You can implement this based on your navigation structure
    // Note: This method needs BuildContext to show SnackBar
    // Consider moving this logic to the UI layer or using a different approach
  }

  bool isSameDateString(String a, String b) {
    final dateA = DateTime.parse(a);
    //log(dateA.toString());

    final dateB = DateTime.parse(b);
    //  log(dateB.toString());
    bool res =
        dateA.year == dateB.year &&
        dateA.month == dateB.month &&
        dateA.day == dateB.day;
    // log(res.toString());
    return res;
  }
}
