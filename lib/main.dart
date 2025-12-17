import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:mannai_user_app/providers/theme_provider.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'package:mannai_user_app/routing/route_names.dart';


/// 🔥 STEP 1: ADD THIS HERE (TOP LEVEL, NOT INSIDE CLASS)
Future<void> firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 🔥 STEP 2: INITIALIZE FIREBASE
  await Firebase.initializeApp();

  /// 🔥 STEP 3: REGISTER BACKGROUND HANDLER
  FirebaseMessaging.onBackgroundMessage(firebaseBackgroundHandler);

  /// Hive init
  await Hive.initFlutter();
  await Hive.openBox("aboutBox");
  await Hive.openBox("blockbox");

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}


class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
      ),
    );
  }
}
