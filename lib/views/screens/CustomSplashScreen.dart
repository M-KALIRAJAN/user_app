import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';



class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  @override
  void initState() {
    super.initState();
    _initNotifications();   // 👈 ADD THIS
    _goNext();
  }
  Future<void> _initNotifications() async {
    // 🔔 Ask notification permission (iOS + Android 13+)
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    // 🧪 Get FCM token (for testing)
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint("FCM TOKEN: $token");
  }
  void _goNext() {
    Timer(const Duration(seconds: 2), () {
      if (!mounted) return; // safety check
      context.go(RouteNames.language);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D5F48), // green background
      body: Center(
        child: Image.asset('assets/icons/logo.png', width: 150, height: 150),
      ),
    );
  }
}
