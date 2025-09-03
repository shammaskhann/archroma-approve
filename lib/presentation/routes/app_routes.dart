import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:arch_approve/presentation/screens/leaves_history/history_screen.dart';
import 'package:arch_approve/presentation/screens/login/login_screen.dart';
import 'package:arch_approve/presentation/screens/login/forgot_password_screen.dart';
import 'package:arch_approve/presentation/screens/splash/splash_screen.dart';
import 'package:arch_approve/presentation/screens/apply_leaves/apply_leaves_screen.dart';
import 'package:arch_approve/presentation/screens/profile/update_profile_screen.dart';
import 'package:arch_approve/presentation/screens/profile/change_password_screen.dart';
import 'package:arch_approve/presentation/screens/profile/terms_conditions_screen.dart';
import 'package:arch_approve/presentation/screens_admin/admin_dashboard_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_employees_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_home_screen.dart';
import 'package:arch_approve/presentation/screens_admin/pages/admin_request_screen.dart';
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
        name: AppRoutesConstant.forgotPassword,
        page: () => const ForgotPasswordScreen(),
        transitionDuration: const Duration(milliseconds: 300),
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
        name: AppRoutesConstant.dashboard,
        page: () {
          final args = Get.arguments as Map<String, dynamic>? ?? {};
          final index = args["index"] ?? 0;
          return DashboardScreen(initialIndex: index);
        },
        transitionDuration: const Duration(milliseconds: 500),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.adminDashboard,
        page: () {
          final args = Get.arguments as Map<String, dynamic>? ?? {};
          final index = args["index"] ?? 0;
          return AdminDashboardScreen(initialIndex: index);
        },
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
        name: AppRoutesConstant.adminHome,
        page: () => const AdminHomeScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.adminRequest,
        page: () => const AdminRequestScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.fadeIn,
      ),
      GetPage(
        name: AppRoutesConstant.adminCalendar,
        page: () => const AdminProfileScreen(),
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

      // Profile Routes
      GetPage(
        name: AppRoutesConstant.updateProfile,
        page: () => const UpdateProfileScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.fadeIn,
      ),

      GetPage(
        name: AppRoutesConstant.changePassword,
        page: () => const ChangePasswordScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.fadeIn,
      ),

      GetPage(
        name: AppRoutesConstant.terms,
        page: () => const TermsConditionsScreen(),
        transitionDuration: const Duration(milliseconds: 300),
        transition: Transition.fadeIn,
      ),
    ];
  }
}
