import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:arch_approve/core/constants/app_route_constant.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue.shade50, Colors.blue.shade100],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.flash_on, color: Colors.blue.shade700, size: 24),
                const SizedBox(width: 8),
                Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.calendar_today,
                    title: 'Apply Leave',
                    subtitle: 'Full day leave',
                    color: Colors.green,
                    onTap: () => _navigateToApplyLeave(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.access_time,
                    title: 'Half Day',
                    subtitle: 'Partial leave',
                    color: Colors.orange,
                    onTap: () => _navigateToApplyHalfDay(context),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Additional Actions
            Row(
              children: [
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.medical_services,
                    title: 'Sick Leave',
                    subtitle: 'Medical leave',
                    color: Colors.red,
                    onTap: () => _navigateToApplySickLeave(context),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.work_off,
                    title: 'Work From Home',
                    subtitle: 'Remote work',
                    color: Colors.purple,
                    onTap: () => _navigateToApplyWFH(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2), width: 1),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToApplyLeave(BuildContext context) {
    Get.toNamed(AppRoutesConstant.applyLeave);
  }

  void _navigateToApplyHalfDay(BuildContext context) {
    // Navigate to apply leave with half day pre-selected
    Get.toNamed(
      AppRoutesConstant.applyLeave,
      arguments: {'leaveType': 'Half Day'},
    );
  }

  void _navigateToApplySickLeave(BuildContext context) {
    // Navigate to apply leave with sick leave pre-selected
    Get.toNamed(
      AppRoutesConstant.applyLeave,
      arguments: {'leaveType': 'Sick Leave'},
    );
  }

  void _navigateToApplyWFH(BuildContext context) {
    // Navigate to apply leave with work from home pre-selected
    Get.toNamed(
      AppRoutesConstant.applyLeave,
      arguments: {'leaveType': 'Work From Home'},
    );
  }
}
