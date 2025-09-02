import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:arch_approve/presentation/screens/leaves_history/history_screen.dart';
import 'package:arch_approve/presentation/screens/login/login_screen.dart';
import 'package:arch_approve/presentation/screens/splash/splash_screen.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/apply_leaves_screen.dart';
import 'package:arch_approve/presentation/screens_admin/admin_dashboard_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_employees_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_requests_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_stats_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_calendar_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

class AppRoutes {
  static List<GetPage> appRoute() {
    return [
      GetPage(
        name: AppRoutesConstant.splash,
        page: () => const SplashScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.login,
        page: () => const LoginScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.dashboard,
        page: () => const DashboardScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transition: Transition.fadeIn,
      ),
      // Admin routes
      GetPage(
        name: AppRoutesConstant.adminDashboard,
        page: () => const AdminDashboardScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.adminEmployees,
        page: () => const AdminEmployeesScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.adminRequests,
        page: () => const AdminRequestsScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.adminStats,
        page: () => const AdminStatsScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.adminCalendar,
        page: () => const AdminCalendarScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.fadeIn,
      ),

      // routes.dart
      GetPage(
        name: AppRoutesConstant.applyLeave,
        page: () {
          final args = Get.arguments as String?; // retrieve the argument
          return ApplyLeavesScreen(leaveType: args ?? "");
        },
        transitionDuration: const Duration(milliseconds: 500),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.history,
        page: () => const LeaveHistoryScreen(),
        transitionDuration: const Duration(milliseconds: 500),
        transition: Transition.fadeIn,
      ),
    ];
  }
}
