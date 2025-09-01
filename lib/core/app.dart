import 'package:arch_approve/core/constants/app_route_constant.dart';
import 'package:arch_approve/core/constants/app_theme.dart';
import 'package:arch_approve/core/services/notification_initializer.dart';
import 'package:arch_approve/presentation/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to ensure all bindings are initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      NotificationInitializer.setupForegroundAndBackgroundHandlers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, __) => GetMaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        title: "ArchApprove",
        theme: lightTheme,
        themeMode: ThemeMode.light, // Switches based on device setting
        initialRoute: AppRoutesConstant.splash,
        getPages: AppRoutes.appRoute(),
      ),
    );
  }
}
