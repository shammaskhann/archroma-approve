import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:arch_approve/presentation/screens/leaves_history/widgets/leave_widget.dart';
import 'package:arch_approve/presentation/screens_admin/controllers/admin_requests_controller.dart';
import 'package:arch_approve/presentation/screens_admin/pages/components/pending_leave_widget.dart';
import 'package:arch_approve/presentation/screens_admin/pages/components/show_reject_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminRequestScreen extends StatefulWidget {
  const AdminRequestScreen({super.key});

  @override
  State<AdminRequestScreen> createState() => _AdminRequestScreenState();
}

class _AdminRequestScreenState extends State<AdminRequestScreen> {
  final controller = Get.put(AdminRequestsController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Manage Requests'),
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          bottom: TabBar(
            indicator: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
              color: Colors.white,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: kPrimaryColor,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            tabs: const [
              Tab(text: "Pending"),
              Tab(text: "Approved"),
              Tab(text: "Rejected"),
            ],
          ),
        ),
        body: Obx(() {
          return TabBarView(
            children: [
              _buildLeaveList(
                controller.allRequests
                    .where((leave) => leave.status == LeaveStatus.pending)
                    .toList(),
                isPending: true,
              ),
              _buildLeaveList(
                controller.allRequests
                    .where((leave) => leave.status == LeaveStatus.accepted)
                    .toList(),
              ),
              _buildLeaveList(
                controller.allRequests
                    .where((leave) => leave.status == LeaveStatus.rejected)
                    .toList(),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildLeaveList(List<LeaveModel> leaves, {bool isPending = false}) {
    if (leaves.isEmpty) {
      return _buildEmptyState(
        isPending ? "No pending leave requests" : "No leave requests",
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: leaves.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final leave = leaves[index];
        return isPending
            ? PendingLeaveItem(
                leave: leave,
                onApprove: () => controller.approve(leave),
                onReject: () =>
                    showRejectReasonBottomSheet(context, leave, controller),
                // controller.reject(leave.id!, reason: "Rejected by Admin"),
              )
            : LeaveHistoryItem(leave: leave, onViewDetails: () {});
      },
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 12),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:arch_approve/presentation/screens_admin/controllers/admin_stats_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AdminStatsScreen extends StatelessWidget {
//   const AdminStatsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final c = Get.put(AdminStatsController());

//     return Scaffold(
//       body: Obx(() {
//         return ListView(
//           padding: const EdgeInsets.all(16),
//           children: [
//             _buildLeaveStatistics(c),

//             const SizedBox(height: 24),

//             Text(
//               'Monthly Applications',
//               style: Theme.of(context).textTheme.titleMedium,
//             ),
//             const SizedBox(height: 12),

//             ...c.monthTotals.entries
//                 .map((e) => _Bar(label: e.key, value: e.value))
//                 .toList(),
//           ],
//         );
//       }),
//     );
//   }

//   Widget _buildLeaveStatistics(AdminStatsController c) {
//     return Container(
//       margin: const EdgeInsets.all(4),
//       padding: const EdgeInsets.all(20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.1),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(Icons.analytics, color: Colors.blue.shade600, size: 24),
//               const SizedBox(width: 8),
//               Text(
//                 'Leave Statistics',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.grey.shade800,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 20),

//           Row(
//             children: [
//               Expanded(
//                 child: _buildStatItem(
//                   icon: Icons.pending,
//                   label: 'Pending',
//                   value: c.pending.value.toString(),
//                   color: Colors.orange,
//                 ),
//               ),
//               Expanded(
//                 child: _buildStatItem(
//                   icon: Icons.check_circle,
//                   label: 'Approved',
//                   value: c.accepted.value.toString(),
//                   color: Colors.green,
//                 ),
//               ),
//               Expanded(
//                 child: _buildStatItem(
//                   icon: Icons.cancel,
//                   label: 'Rejected',
//                   value: c.rejected.value.toString(),
//                   color: Colors.red,
//                 ),
//               ),
//             ],
//           ),

//           const SizedBox(height: 16),

//           Container(
//             width: double.infinity,
//             padding: const EdgeInsets.all(16),
//             decoration: BoxDecoration(
//               color: Colors.blue.shade50,
//               borderRadius: BorderRadius.circular(12),
//               border: Border.all(color: Colors.blue.shade200, width: 1),
//             ),
//             child: Row(
//               children: [
//                 Icon(Icons.summarize, color: Colors.blue.shade600, size: 24),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Total Applications',
//                         style: TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.grey.shade700,
//                         ),
//                       ),
//                       Text(
//                         '${c.total.value}',
//                         style: TextStyle(
//                           fontSize: 24,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildStatItem({
//     required IconData icon,
//     required String label,
//     required String value,
//     required Color color,
//   }) {
//     return Column(
//       children: [
//         Icon(icon, color: color, size: 28),
//         const SizedBox(height: 6),
//         Text(
//           value,
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             color: color,
//           ),
//         ),
//         Text(
//           label,
//           style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
//         ),
//       ],
//     );
//   }
// }

// class _Bar extends StatelessWidget {
//   final String label;
//   final int value;
//   const _Bar({required this.label, required this.value});

//   @override
//   Widget build(BuildContext context) {
//     final maxWidth = MediaQuery.of(context).size.width - 64;
//     final int maxValue = value > 0 ? value : 1;
//     final double fraction = value / maxValue; // simple self-scaling

//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 6),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label),
//           const SizedBox(height: 4),
//           Stack(
//             children: [
//               Container(
//                 width: maxWidth,
//                 height: 10,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//               Container(
//                 width: maxWidth * fraction,
//                 height: 10,
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             '$value',
//             style: const TextStyle(fontSize: 12, color: Colors.black54),
//           ),
//         ],
//       ),
//     );
//   }
// }
