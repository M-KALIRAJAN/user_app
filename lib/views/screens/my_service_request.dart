import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/core/utils/logger.dart';
import 'package:mannai_user_app/services/my_service.dart';
import 'package:mannai_user_app/widgets/app_back.dart';
import 'package:mannai_user_app/widgets/my_service_card.dart';

class MyServiceRequest extends StatefulWidget {
  const MyServiceRequest({super.key});

  @override
  State<MyServiceRequest> createState() => _MyServiceRequestState();
}

class _MyServiceRequestState extends State<MyServiceRequest> {
     MyService _myService = MyService();
        @override
   void initState() {
     super.initState();
     myserviceslist();
     
   }

     Future<void> myserviceslist()async{
      AppLogger.warn("************************************");
      try{
     final response = await _myService.myallservices();
     AppLogger.info("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
             AppLogger.warn("myserviceslist ${jsonEncode(response)}");
      }catch(e){
        AppLogger.error("MyServiceerr $e");
      }
        
     }
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_clr,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 17,
                right: 17,
                top: 10,
                bottom: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCircleIconButton(icon: Icons.arrow_back, onPressed: () {}),
                  Text(
                    "MY Service Request",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: AppFontSizes.large,
                    ),
                  ),
                  Text(""),
                ],
              ),
            ),
            SizedBox(height: 10),
            Divider(),
        
            Expanded(
              child: ListView.builder(
                itemCount: 5, 
                itemBuilder: (context, index) {
                  return const ServiceRequestCard(
                    title: "Request SRM",
                    date: "2023-10-26 , 14:30",
                    description:
                        "Leaking facet in the main office restroom. Requires urgent repair.",
                  );
                },
              ),

            )
          ],
        ),
      ),
    );
  }
}
