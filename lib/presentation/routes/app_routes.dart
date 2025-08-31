import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/presentation/screens/dashboard/dashboard_screen.dart';
import 'package:arch_approve/presentation/screens/login/login_screen.dart';
import 'package:arch_approve/presentation/screens/splash/splash_screen.dart';
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
    ];
  }
}
