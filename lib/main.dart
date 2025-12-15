import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mannai_user_app/providers/theme_provider.dart';


import 'package:mannai_user_app/routing/route_names.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  Initialize Hive
   await  Hive.initFlutter();
  // open the hive container
   await Hive.openBox("aboutBox");
   await Hive.openBox("blockbox");
  runApp(
   ProviderScope(
    child: MyApp())
    );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider); 
    //  themeProvider watch pannina,
    // theme change aana whole app rebuild aagum

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,

      themeMode: themeMode, //  IMPORTANT

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


