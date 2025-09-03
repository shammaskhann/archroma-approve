import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/services/firebase/auth_services.dart';
import 'package:arch_approve/core/services/firebase/data_service.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:arch_approve/data/repositories/auth_repository_impl.dart';
import 'package:arch_approve/core/services/notification/fcm_tokken_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  var emailError = "".obs;
  var passwordError = "".obs;

  // Inject repository
  late final AuthRepository _authRepository;

  @override
  void onInit() {
    super.onInit();
    _authRepository = AuthRepository(
      FirebaseAuthService(),
      FirebaseDataService(),
    );
  }

  Future<void> validateLogin() async {
    // Reset errors
    emailError.value = "";
    passwordError.value = "";

    if (emailController.text.isEmpty) {
      emailError.value = "Email is required";
      return;
    }

    if (passwordController.text.length < 6) {
      passwordError.value = "Password must be at least 6 characters";
      return;
    }

    // Start loading
    isLoading.value = true;

    try {
      final user = await _authRepository.signIn(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
      await FcmTokenService.updateToken();
      if (user!.role.toLowerCase() == "employee") {
        Get.offAllNamed(AppRoutesConstant.dashboard);
      } else if (user.role.toLowerCase() == "admin" ||
          user.role.toLowerCase() == "it" ||
          user.role.toLowerCase() == "manager") {
        Get.offAllNamed(AppRoutesConstant.adminDashboard);
      } else {
        Get.offAllNamed(AppRoutesConstant.dashboard);
      }
    } catch (e) {
      _showErrorSnackbar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> forgotPassword() async {
    if (emailController.text.isEmpty) {
      _showErrorSnackbar("Please enter your email first.");
      return;
    }

    try {
      await _authRepository.forgotPassword(emailController.text.trim());
      // Note: This method needs BuildContext to show SnackBar
      // Consider moving this logic to the UI layer or using a different approach
    } catch (e) {
      _showErrorSnackbar(e.toString());
    }
  }

  void _showErrorSnackbar(String message) {
    // Note: This method needs BuildContext to show SnackBar
    // Consider moving this logic to the UI layer or using a different approach
  }
}
