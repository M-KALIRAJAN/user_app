// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';

// class NotificationService {
   
//    static void initialize(BuildContext context) {
//     // FOREGROUND MESSAGE

//     FirebaseMessaging.onMessage.listen((RemoteMessage message){
//       if(message.notification != null){
//         String title = message.notification!.title ?? "";
//         String body = message.notification!.body ?? "";

//         //Show UI(Snackbar)
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text(title,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold
//                 ),),
//                 Text(body)
//               ],
//             ),
//             duration: Duration(seconds: 7),
//             )
//         );
//       }
//     });
//    }
// }

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nadi_user_app/routing/app_router.dart';


class NotificationService {

  static void initialize(BuildContext context) {

    /// FOREGROUND
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification == null) return;

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(message.notification!.title ?? "OTP"),
          content: Text(message.notification!.body ?? ""),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    });

    /// BACKGROUND TAP
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      final otp = message.data['otp'];
      if (otp != null) {
        context.go(RouteNames.opt, extra: otp);
      }
    });
  }

  /// TERMINATED STATE
  static Future<void> checkInitialMessage(BuildContext context) async {
    final message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      final otp = message.data['otp'];
      if (otp != null) {
        context.go(RouteNames.opt, extra: otp);
      }
    }
  }
}
