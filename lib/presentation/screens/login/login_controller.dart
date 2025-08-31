import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  var emailError = "".obs;
  var passwordError = "".obs;

  Future<void> validateLogin() async {
    if (emailController.text.isEmpty) {
      emailError.value = "Email is required";
    } else {
      emailError.value = "";
    }

    if (passwordController.text.length < 6) {
      passwordError.value = "Password must be at least 6 characters";
    } else {
      passwordError.value = "";
    }

    await Future.delayed(Duration(seconds: 2));

    Get.offAllNamed(AppRoutesConstant.dashboard);
  }
}
