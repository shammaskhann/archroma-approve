import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:arch_approve/presentation/components/custom_loader.dart';
import 'package:arch_approve/presentation/components/quick_action_card.dart';
import 'package:arch_approve/presentation/components/recent_request_card.dart';
import 'package:arch_approve/presentation/controllers/home_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final homeController = Get.put(HomeController());
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => homeController.refreshData(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildWelcomeSetion(context),
              SizedBox(height: 5),
              const QuickActionCard(),
              SizedBox(height: 5),
              // Recent Request Card
              Obx(
                () => RecentRequestCard(
                  recentLeave: homeController.getRecentLeave,
                  onViewAll: homeController.viewAllLeaves,
                ),
              ),

              // Leave Statistics
              Obx(() => _buildLeaveStatistics(homeController)),

              // Loading and Error States
              Obx(() => _buildLoadingAndErrorStates(homeController)),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSetion(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.28,
      width: width,
      decoration: BoxDecoration(
        gradient: kL,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: kBlackColor.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  final _auth = FirebaseAuth.instance;
                  UserPref.clearData();
                  _auth.signOut();
                  Get.offAllNamed(AppRoutesConstant.login);
                },
                child: Icon(Icons.logout, color: kWhiteColor),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //Avatar (person icon) and below "Welcome, back" next line "Adnan Ahmed"
              // SizedBox(height: 20),
              CircleAvatar(
                radius: 40,
                backgroundColor: kWhiteColor,
                child: Icon(Icons.person, size: 50, color: kDarkGreyColor),
              ),
              SizedBox(height: 10),
              Text(
                "Welcome, back",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: kWhiteColor,
                ),
              ),
              SizedBox(height: 5),
              FutureBuilder(
                future: UserPref.getName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return DotsLoader(kWhiteColor);
                  }
                  return Text(
                    "Shammas Khan",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: kWhiteColor,
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildLeaveStatistics(HomeController controller) {
  final stats = controller.getLeaveStats();

  return Container(
    margin: const EdgeInsets.all(16),
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
                value: stats['pending']?.toString() ?? '0',
                color: Colors.orange,
              ),
            ),
            Expanded(
              child: _buildStatItem(
                icon: Icons.check_circle,
                label: 'Approved',
                value: stats['accepted']?.toString() ?? '0',
                color: Colors.green,
              ),
            ),
            Expanded(
              child: _buildStatItem(
                icon: Icons.cancel,
                label: 'Rejected',
                value: stats['rejected']?.toString() ?? '0',
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
                      '${stats['total'] ?? 0}',
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
        value,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
    ],
  );
}

Widget _buildLoadingAndErrorStates(HomeController controller) {
  if (controller.getIsLoading) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading your leave information...'),
          ],
        ),
      ),
    );
  }

  if (controller.getErrorMessage.isNotEmpty) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200, width: 1),
      ),
      child: Column(
        children: [
          Icon(Icons.error_outline, color: Colors.red.shade600, size: 32),
          const SizedBox(height: 12),
          Text(
            'Error Loading Data',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            controller.getErrorMessage,
            style: TextStyle(fontSize: 14, color: Colors.red.shade600),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => controller.refreshData(),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  return const SizedBox.shrink();
}
