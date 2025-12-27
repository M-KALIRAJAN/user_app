import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationService {
   
   static void initialize(BuildContext context) {
    // FOREGROUND MESSAGE

    FirebaseMessaging.onMessage.listen((RemoteMessage message){
      if(message.notification != null){
        String title = message.notification!.title ?? "";
        String body = message.notification!.body ?? "";

        //Show UI(Snackbar)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                Text(body)
              ],
            ),
            duration: Duration(seconds: 7),
            )
        );
      }
    });
   }
}