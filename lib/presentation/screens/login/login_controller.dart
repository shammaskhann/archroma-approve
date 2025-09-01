import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/services/firebase/auth_services.dart';
import 'package:arch_approve/core/services/firebase/data_service.dart';
import 'package:arch_approve/core/services/shared_pref/local_Storage_service.dart';
import 'package:arch_approve/data/repositories/auth_repository_impl.dart';
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
      if (user!.role == "employee") {
        Get.offAllNamed(AppRoutesConstant.dashboard);
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
      Get.snackbar(
        "Password Reset",
        "A reset link has been sent to your email.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green.shade600,
        colorText: Colors.white,
        margin: const EdgeInsets.all(12),
      );
    } catch (e) {
      _showErrorSnackbar(e.toString());
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Error",
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red.shade600,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
  }
}
