import 'package:flutter/material.dart';
import 'screens/login_layar.dart';
import 'screens/forgot_password.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const FitMotionApp());
}

class FitMotionApp extends StatelessWidget {
  const FitMotionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitMotion',
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginLayar(),
        '/forgot-password': (context) => const ForgotPassword(),
        '/dashboard': (context) => const DashboardScreen(),   // ← Route ini harus ada
      },
    );
  }
}