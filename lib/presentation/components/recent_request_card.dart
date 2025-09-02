import 'package:arch_approve/core/utils/formate_date.dart';
import 'package:arch_approve/core/utils/status_chip.dart';
import 'package:arch_approve/presentation/components/attachment_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:arch_approve/core/constants/app_route_constant.dart';

class RecentRequestCard extends StatelessWidget {
  final LeaveModel? recentLeave;
  final VoidCallback? onViewAll;

  const RecentRequestCard({Key? key, this.recentLeave, this.onViewAll})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.history, color: Colors.grey.shade700, size: 24),
                  const SizedBox(width: 8),
                  Text(
                    'Recent Request',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ],
              ),
              if (onViewAll != null)
                TextButton(
                  onPressed: onViewAll,
                  child: Text(
                    'View All',
                    style: TextStyle(
                      color: Colors.blue.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        Card(
          elevation: 4,
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
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
                // Content
                if (recentLeave != null) ...[
                  _buildLeaveInfo(recentLeave!),
                ] else ...[
                  _buildNoRecentLeave(),
                ],
              ],
            ),
          ),
        ),
      ],
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
                    '${formatStringDate(leave.startDate)} →  ${formatStringDate(leave.endDate)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            buildStatusChip(leave.status),
          ],
        ),

        const SizedBox(height: 16),

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
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: 16),

        // Additional Details
        Row(
          children: [
            Expanded(
              child: _buildDetailItem(
                icon: Icons.calendar_today,
                label: 'Submitted',
                value: formatDate(leave.submittedAt),
              ),
            ),
            Expanded(
              child: _buildDetailItem(
                icon: Icons.update,
                label: 'Updated',
                value: formatDate(leave.updatedAt),
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

  Widget _buildNoRecentLeave() {
    return Column(
      children: [
        Icon(Icons.inbox_outlined, size: 48, color: Colors.grey.shade400),
        const SizedBox(height: 16),
        Text(
          'No Recent Requests',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'You haven\'t applied for any leave recently.',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade500),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => Get.toNamed(AppRoutesConstant.applyLeave),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Apply for Leave',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
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
}
