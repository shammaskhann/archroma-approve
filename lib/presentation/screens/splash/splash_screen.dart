import 'dart:developer';

import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:arch_approve/presentation/components/custom_loader.dart';
import 'package:arch_approve/presentation/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    final _auth = FirebaseAuth.instance;
    final uid = _auth.currentUser?.uid;
    final role = await UserPref.getRole();
    log("ROLE: $role $uid");
    if (role == 'admin' && uid != null) {
      Get.offAllNamed(AppRoutesConstant.dashboard);
    } else if (role == "Employee" && uid != null) {
      Get.offAllNamed(AppRoutesConstant.dashboard);
    } else {
      Get.offAllNamed(AppRoutesConstant.login);
      // Get.offAllNamed(AppRoutesConstant.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/icons/logo.png', width: 250),
            //Linear Progress Indicator
            DotsLoader(kLightPrimaryColor),
          ],
        ),
      ),
    );
  }
}
