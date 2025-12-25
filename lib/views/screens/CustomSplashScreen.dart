import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nadi_user_app/core/network/dio_client.dart';
import 'package:nadi_user_app/preferences/preferences.dart';
import 'package:nadi_user_app/routing/app_router.dart';
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nadi_user_app/services/onbording_service.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  OnbordingService _onbordingService = OnbordingService();
  String? welcomeUrl;

  @override
  void initState() {
    super.initState();
    _initNotifications(); // 👈 ADD THIS
    decideNavigation(context);
    welcomeLogo();
  }

  Future<void> welcomeLogo() async {
    final welcomeLog = await _onbordingService.loading();

    if (welcomeLog != null) {
      final fileName = welcomeLog["data"]["image"];
      setState(() {
        welcomeUrl = "${ImageBaseUrl.baseUrl}$fileName";
      });
    }
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

  Future<void> decideNavigation(BuildContext context) async {
    final bool isLoggedIn = await AppPreferences.isLoggedIn();
    final bool hasSeenAbout = await AppPreferences.hasSeenAbout();

    await Future.delayed(Duration(seconds: 5));
    context.go(RouteNames.language);
    if(!hasSeenAbout){
       // FIRST TIME USER
      context.go(RouteNames.language);
    } else if (isLoggedIn){
       // Returning logged-in user with out click logout
      context.push(RouteNames.bottomnav);
    } else{
      // Returning logged-in user with  click logout
      context.go(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D5F48), // green background
      body: Center(
        child: welcomeUrl == null
            ? Image.asset('assets/icons/logo.png', width: 150, height: 150)
            : Image.network(
                welcomeUrl!,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
      ),
    );
  }
}
