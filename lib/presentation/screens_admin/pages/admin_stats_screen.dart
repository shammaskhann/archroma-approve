// import 'package:arch_approve/presentation/screens_admin/controllers/admin_stats_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AdminStatsScreen extends StatelessWidget {
//   const AdminStatsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final c = Get.put(AdminStatsController());
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Mobile layout
//         return Scaffold(
//           body: Obx(() {
//             return ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 _StatCard(
//                   label: 'Total',
//                   value: c.total.value,
//                   color: Colors.blue,
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: _StatCard(
//                         label: 'Pending',
//                         value: c.pending.value,
//                         color: Colors.orange,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: _StatCard(
//                         label: 'Approved',
//                         value: c.accepted.value,
//                         color: Colors.green,
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: _StatCard(
//                         label: 'Rejected',
//                         value: c.rejected.value,
//                         color: Colors.red,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 16),
//                 Text(
//                   'Monthly Applications',
//                   style: Theme.of(context).textTheme.titleMedium,
//                 ),
//                 const SizedBox(height: 8),
//                 ...c.monthTotals.entries
//                     .map((e) => _Bar(label: e.key, value: e.value))
//                     .toList(),
//               ],
//             );
//           }),
//         );
//       },
//     );
//   }
// }

// class _StatCard extends StatelessWidget {
//   final String label;
//   final int value;
//   final Color color;
//   const _StatCard({
//     required this.label,
//     required this.value,
//     required this.color,
//   });
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 10,
//             height: 10,
//             decoration: BoxDecoration(color: color, shape: BoxShape.circle),
//           ),
//           const SizedBox(width: 8),
//           Expanded(
//             child: Text(
//               label,
//               style: const TextStyle(fontWeight: FontWeight.w600),
//             ),
//           ),
//           Text(
//             '$value',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               color: color,
//               fontSize: 18,
//             ),
//           ),
//         ],
//       ),
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
//     final double fraction = value / maxValue; // simple self-scaling per row
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
//                 color: Colors.grey.shade200,
//               ),
//               Container(
//                 width: maxWidth * fraction,
//                 height: 10,
//                 color: Colors.blue,
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
import 'package:arch_approve/presentation/screens_admin/controllers/admin_stats_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminStatsScreen extends StatelessWidget {
  const AdminStatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AdminStatsController());

    return Scaffold(
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildLeaveStatistics(c),

            const SizedBox(height: 24),

            Text(
              'Monthly Applications',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            ...c.monthTotals.entries
                .map((e) => _Bar(label: e.key, value: e.value))
                .toList(),
          ],
        );
      }),
    );
  }

  Widget _buildLeaveStatistics(AdminStatsController c) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.analytics, color: Colors.blue.shade600, size: 24),
              const SizedBox(width: 8),
              Text(
                'Leave Statistics',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.pending,
                  label: 'Pending',
                  value: c.pending.value.toString(),
                  color: Colors.orange,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.check_circle,
                  label: 'Approved',
                  value: c.accepted.value.toString(),
                  color: Colors.green,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.cancel,
                  label: 'Rejected',
                  value: c.rejected.value.toString(),
                  color: Colors.red,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue.shade200, width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.summarize, color: Colors.blue.shade600, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Applications',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      Text(
                        '${c.total.value}',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class _Bar extends StatelessWidget {
  final String label;
  final int value;
  const _Bar({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final maxWidth = MediaQuery.of(context).size.width - 64;
    final int maxValue = value > 0 ? value : 1;
    final double fraction = value / maxValue; // simple self-scaling

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          const SizedBox(height: 4),
          Stack(
            children: [
              Container(
                width: maxWidth,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Container(
                width: maxWidth * fraction,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
          Text(
            '$value',
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
