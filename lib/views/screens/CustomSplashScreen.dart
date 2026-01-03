import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nadi_user_app/services/notification_service.dart';
import 'package:video_player/video_player.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:nadi_user_app/core/network/dio_client.dart';
import 'package:nadi_user_app/core/utils/logger.dart';
import 'package:nadi_user_app/preferences/preferences.dart';
import 'package:nadi_user_app/routing/app_router.dart';
import 'package:nadi_user_app/services/onbording_service.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen> {
  final OnbordingService _onbordingService = OnbordingService();

  String? imageUrl;
  String? videoUrl;
  VideoPlayerController? _videoController;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    debugPrint("🚀 Splash initState()");
    _initNotifications();
    _loadSplashMedia();
    //     WidgetsBinding.instance.addPostFrameCallback((_) {
    //   /// TERMINATED CHECK
    //   NotificationService.checkInitialMessage(context);
    // });
  }

  // --------------------------------------------------
  // LOAD IMAGE / VIDEO FROM BACKEND
  // --------------------------------------------------
  Future<void> _loadSplashMedia() async {
    debugPrint("📡 Calling splash API...");

    try {
      final response = await _onbordingService.loading();
      debugPrint("✅ API Response: ${jsonEncode(response)}");

      if (response == null ||
          response['data'] == null ||
          response['data'].isEmpty) {
        debugPrint("⚠️ No splash data found");
        _startNavigation();
        return;
      }

      final item = response['data'][0];
      final image = item['image'];
      final video = item['video'];

      debugPrint("🖼 IMAGE VALUE => $image");
      debugPrint("🎬 VIDEO VALUE => $video");

      // VIDEO
      if (video != null && video.toString().isNotEmpty) {
        videoUrl = "${ImageBaseUrl.baseUrl}$video";
        debugPrint("🎥 VIDEO URL => $videoUrl");

        _videoController = VideoPlayerController.networkUrl(
          Uri.parse(videoUrl!),
        );

        await _videoController!.initialize();
        _videoController!
          ..setLooping(true)
          ..play();

        debugPrint("▶️ Video initialized & playing");
      }

      // IMAGE
      else if (image != null && image.toString().isNotEmpty) {
        imageUrl = "${ImageBaseUrl.baseUrl}/$image";
        debugPrint("🖼 Image URL => $imageUrl");
      }

      setState(() => isLoading = false);
      _startNavigation();
    } catch (e, s) {
      debugPrint("❌ Splash load error: $e");
      debugPrint("STACK: $s");
      _startNavigation();
    }
  }

  // --------------------------------------------------
  // FIREBASE NOTIFICATIONS
  // --------------------------------------------------
  Future<void> _initNotifications() async {
    debugPrint("🔔 Requesting FCM permission");

    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    final token = await FirebaseMessaging.instance.getToken();
    debugPrint("🔥 FCM TOKEN => $token");

    if (token != null) {
      await AppPreferences.savefcmToken(token);
    }
  }

  // --------------------------------------------------
  // NAVIGATION
  // --------------------------------------------------
  void _startNavigation() {
    debugPrint("⏱ Starting navigation timer (5 sec)");

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      _decideNavigation();
    });
  }

  Future<void> _decideNavigation() async {
    debugPrint("🧭 Deciding navigation");

    final isLoggedIn = await AppPreferences.isLoggedIn();
    final hasSeenAbout = await AppPreferences.hasSeenAbout();

    debugPrint("🔐 isLoggedIn => $isLoggedIn");
    debugPrint("📘 hasSeenAbout => $hasSeenAbout");

    if (!mounted) return;

    if (!hasSeenAbout) {
      debugPrint("➡️ Navigate: Language");
      context.go(RouteNames.language);
    } else if (isLoggedIn) {
      debugPrint("➡️ Navigate: BottomNav");
      context.go(RouteNames.bottomnav);
    } else {
      debugPrint("➡️ Navigate: Login");
      context.go(RouteNames.login);
    }
  }

  // --------------------------------------------------
  // MEDIA UI
  // --------------------------------------------------
  Widget _buildMedia() {
    if (_videoController != null &&
        _videoController!.value.isInitialized) {
      debugPrint("🎬 Rendering Video");
      return AspectRatio(
        aspectRatio: _videoController!.value.aspectRatio,
        child: VideoPlayer(_videoController!),
      );
    }

    if (imageUrl != null) {
      debugPrint("🖼 Rendering Image");
      return Image.network(
        imageUrl!,
        width: 180,
        height: 180,
        fit: BoxFit.contain,
      );
    }

    debugPrint("📦 Rendering Default Image");
    return Image.asset(
      'assets/icons/logo.png',
      width: 150,
      height: 150,
    );
  }

  @override
  void dispose() {
    debugPrint("🧹 Disposing splash");
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D5F48),
      body: Center(
        child: isLoading
            ?  Image.asset(
      'assets/icons/logo.png',
      width: 150,
      height: 150,
    )
            : _buildMedia(),
      ),
    );
  }
}
