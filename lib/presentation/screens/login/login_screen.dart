import 'dart:ui';

import 'package:arch_approve/presentation/components/app_button.dart';
import 'package:arch_approve/presentation/components/app_textfield.dart';
import 'package:arch_approve/presentation/screens/login/login_controller.dart';
import 'package:arch_approve/presentation/screens/login/widgets/header_clipper.dart';
import 'package:flutter/material.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final controller = Get.put(LoginController());
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, size) {
          bool isWeb = size.maxWidth > 800;
          return isWeb
              ? _buildWebLayout(context, controller)
              : _mobileLayout(context, theme, controller, height, width);
        },
      ),
    );
  }

  // ---------------- WEB LAYOUT ----------------
  Widget _buildWebLayout(BuildContext context, LoginController controller) {
    return Row(
      children: [
        // LEFT SIDE - Colored Background
        Expanded(
          flex: 1,
          child: Container(
            color: kPrimaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/icons/logo-bg.png", height: 0.5.sh),
                const SizedBox(height: 20),
                const Text(
                  "Welcome Back!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    "Login to continue and manage your account securely.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),

        // RIGHT SIDE - Login Form
        Expanded(
          flex: 1,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(32),
              constraints: const BoxConstraints(maxWidth: 400),
              child: _buildLoginForm(controller),
            ),
          ),
        ),
      ],
    );
  }

  // ---------------- LOGIN FORM ----------------
  Widget _buildLoginForm(LoginController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Login to Continue",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        const SizedBox(height: 32), // Email
        AppTextField(
          label: "Enter Email",
          hintText: "example@email.com",
          prefixIcon: Icons.email,
          controller: controller.emailController,
          errorText: controller.emailError,
        ),
        const SizedBox(height: 16),
        AppTextField(
          label: "Enter Password",
          hintText: "••••••••",
          prefixIcon: Icons.lock,
          controller: controller.passwordController,
          isPassword: true,
          errorText: controller.passwordError,
        ),
        const SizedBox(height: 12), // Forgot password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Get.toNamed('/forgot-password'),
            child: const Text("Forgot Password?"),
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () => AppButton(
            text: "Login",
            isLoading: controller.isLoading.value,
            isDisabled: false,
            onPressed: () async {
              controller.isLoading.value = true;
              await controller.validateLogin();
              controller.isLoading.value = false;
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

Widget _mobileLayout(
  context,
  TextTheme theme,
  LoginController controller,
  double height,
  double width,
) {
  return SingleChildScrollView(
    child: Stack(
      children: [
        // Gradient curved header
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              clipper: HeaderClipper(),
              child: Container(
                height: height * 0.35,
                width: width,
                decoration: BoxDecoration(
                  gradient: kL,
                  boxShadow: [
                    BoxShadow(
                      color: kDarkPrimaryColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        "Welcome Back 👋",
                        style: kHeadingTextStyle.copyWith(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Login to continue your journey",
                        style: theme.labelSmall?.copyWith(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  AppTextField(
                    label: "Enter Email",
                    hintText: "example@email.com",
                    prefixIcon: Icons.email,
                    controller: controller.emailController,
                    errorText: controller.emailError,
                  ),
                  const SizedBox(height: 16),
                  AppTextField(
                    label: "Enter Password",
                    hintText: "••••••••",
                    prefixIcon: Icons.lock,
                    controller: controller.passwordController,
                    isPassword: true,
                    errorText: controller.passwordError,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.toNamed('/forgot-password'),
                      child: Text(
                        "Forgot Password?",
                        style: theme.displaySmall?.copyWith(
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),
                  Obx(
                    () => AppButton(
                      text: "Login",
                      isLoading: controller.isLoading.value,
                      isDisabled: false,
                      onPressed: () async {
                        controller.isLoading.value = true;
                        await controller.validateLogin();
                        controller.isLoading.value = false;
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),

        // Circular logo
        Positioned(
          top: height * 0.24,
          left: 0,
          right: 0,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: kWhiteColor,
              boxShadow: [
                BoxShadow(
                  color: kDarkPrimaryColor.withOpacity(0.25),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: CircleAvatar(
              radius: 70,
              backgroundColor: kWhiteColor,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.asset("assets/icons/logo.png"),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
