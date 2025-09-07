import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:arch_approve/presentation/screens/leaves_history/history_controller.dart';
import 'package:arch_approve/presentation/screens/leaves_history/widgets/leave_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class LeaveHistoryScreen extends StatelessWidget {
  const LeaveHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LeavesHistoryController());

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Leave History"),
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
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Approved"),
              Tab(text: "Rejected"),
            ],
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              _buildLeaveList(
                controller.pendingLeaves,
                "No pending leaves",
                controller,
              ),
              _buildLeaveList(
                controller.acceptedLeaves,
                "No approved leaves",
                controller,
              ),
              _buildLeaveList(
                controller.rejectedLeaves,
                "No rejected leaves",
                controller,
              ),
            ],
          );
        }),

        floatingActionButton: Container(
          decoration: BoxDecoration(
            gradient: kLightPrimaryGradient,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.25)),
            ],
          ),
          child: FloatingActionButton.extended(
            backgroundColor: Colors.transparent, // important!
            elevation: 0, // so shadow matches container
            onPressed: () async {
              await Get.toNamed(AppRoutesConstant.applyLeave, arguments: "");
              controller.loadLeaves();
            },
            label: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add, color: kWhiteColor),
                SizedBox(width: 5),
                Text(
                  "Apply Leaves",
                  style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeaveList(
    RxList<LeaveModel> leaves,
    String emptyMessage,
    LeavesHistoryController controller,
  ) {
    return RefreshIndicator(
      onRefresh: () => controller.loadLeaves(),
      child: Obx(() {
        if (controller.isLoading.value && leaves.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }
        if (leaves.isEmpty) {
          return ListView(
            physics:
                const AlwaysScrollableScrollPhysics(), // Makes it scrollable even if empty
            children: [
              SizedBox(height: 150), // Push content to center
              _buildEmptyState(emptyMessage),
            ],
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: leaves.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final leave = leaves[index];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: LeaveHistoryItem(leave: leave, onViewDetails: () {}),
            );
          },
        );
      }),
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

  Color _getStatusColor(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.pending:
        return Colors.orange;
      case LeaveStatus.accepted:
        return Colors.green;
      case LeaveStatus.rejected:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(LeaveStatus status) {
    switch (status) {
      case LeaveStatus.pending:
        return Icons.pending_actions;
      case LeaveStatus.accepted:
        return Icons.check_circle;
      case LeaveStatus.rejected:
        return Icons.cancel;
    }
  }
}

// import 'package:arch_approve/core/constants/app_theme.dart';
// import 'package:arch_approve/data/models/Leave_Model.dart';
// import 'package:arch_approve/presentation/screens/leaves_history/history_controller.dart';
// import 'package:arch_approve/presentation/screens/leaves_history/widgets/leave_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// class LeaveHistoryScreen extends StatelessWidget {
//   const LeaveHistoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(LeavesHistoryController());

//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Leave History"),
//           backgroundColor: kPrimaryColor,
//           foregroundColor: Colors.white,
//           bottom: TabBar(
//             indicator: BoxDecoration(
//               borderRadius: BorderRadius.circular(25),
//               color: Colors.white.withOpacity(0.2),
//             ),
//             indicatorSize: TabBarIndicatorSize.tab,
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.white.withOpacity(0.7),
//             tabs: [
//               Tab(text: "Pending"),
//               Tab(text: "Approved"),
//               Tab(text: "Rejected"),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           controller: DefaultTabController.of(context),
//           physics: const BouncingScrollPhysics(),
//           children: [
//             _buildTabContent(controller.pendingLeaves, "No pending leaves",controller),
//             _buildTabContent(controller.acceptedLeaves, "No approved leaves",controller),
//             _buildTabContent(controller.rejectedLeaves, "No rejected leaves",controller),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTabContent(
//     RxList<LeaveModel> leaves,
//     String emptyMessage,
//     LeavesHistoryController controller,
//   ) {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return const Center(child: CircularProgressIndicator());
//       }

//       if (leaves.isEmpty) {
//         return _buildEmptyState(emptyMessage);
//       }

//       return ListView.separated(
//         padding: const EdgeInsets.all(16),
//         itemCount: leaves.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 12),
//         itemBuilder: (context, index) {
//           final leave = leaves[index];
//           return LeaveHistoryItem(leave: leave, onViewDetails: () {});
//         },
//       );
//     });
//   }

//   Widget _buildEmptyState(String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.inbox, size: 80, color: Colors.grey.shade400),
//           const SizedBox(height: 12),
//           Text(
//             message,
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.grey.shade600,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
