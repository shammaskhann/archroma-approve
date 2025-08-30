import 'package:arch_approve/core/app.dart';
import 'package:arch_approve/core/services/firebase_initializer.dart';
import 'package:arch_approve/core/services/orientation_service.dart';
import 'package:arch_approve/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseInitializer.initialize();
  OrientationService.lockPortraitMode();
  runApp(const MyApp());
}
