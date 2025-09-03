import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/data/models/Leave_Model.dart';
import 'package:arch_approve/presentation/screens/leaves_history/widgets/leave_widget.dart';
import 'package:arch_approve/presentation/screens_admin/controllers/admin_requests_controller.dart';
import 'package:arch_approve/presentation/screens_admin/controllers/admin_stats_controller.dart';
import 'package:arch_approve/presentation/screens_admin/pages/components/leaves_Statistics.dart';
import 'package:arch_approve/presentation/screens_admin/pages/components/pending_leave_widget.dart';
import 'package:arch_approve/presentation/screens_admin/pages/components/show_reject_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.put(AdminRequestsController());
    final c2 = Get.put(AdminStatsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Mobile layout
          return Scaffold(
            body: Obx(() {
              final items = c.allRequests;
              // if
              // }
              return SingleChildScrollView(
                child: Column(
                  children: [
                    buildLeaveStatistics(c2),
                    SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.inbox_outlined,
                                color: Colors.blue.shade600,
                                size: 24,
                              ),
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
                          (items.isNotEmpty)
                              ? TextButton(
                                  onPressed: () {
                                    Get.toNamed(AppRoutesConstant.adminRequest);
                                  },
                                  child: Text(
                                    'View All',
                                    style: TextStyle(
                                      color: Colors.blue.shade600,
                                      fontWeight: FontWeight.w600,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                    ),

                    (items.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            child: (items.first.status == LeaveStatus.pending)
                                ? PendingLeaveItem(
                                    leave: items.first,
                                    onApprove: () => c.approve(items.first!),
                                    onReject: () => showRejectReasonBottomSheet(
                                      context,
                                      items.first,
                                      c,
                                    ),
                                  )
                                : LeaveHistoryItem(
                                    leave: items.first,
                                    onViewDetails: () {},
                                  ),
                          )
                        : SizedBox(
                            height: 100.h,
                            child: Center(
                              child: Text(
                                'No requests',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                  ],
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
