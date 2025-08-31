import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:arch_approve/presentation/screens/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkRole();
  }

  void checkRole() async {
    await Future.delayed(const Duration(seconds: 2));
    final role = await UserPref.getRole();
    if (role == 'admin') {
      Get.offAll(() => const LoginScreen());
    } else if (role == "employee") {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAllNamed(AppRoutesConstant.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/logo.png'),
            //Linear Progress Indicator
            Container(
              width: width * 0.6,
              child: LinearProgressIndicator(
                color: kPrimaryColor,
                backgroundColor: kLightPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
