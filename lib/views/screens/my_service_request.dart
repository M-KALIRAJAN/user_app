import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nadi_user_app/core/constants/app_consts.dart';

import 'package:nadi_user_app/core/utils/logger.dart';
import 'package:nadi_user_app/routing/app_router.dart';
import 'package:nadi_user_app/services/my_service.dart';
import 'package:nadi_user_app/widgets/ServiceRequestCardShimmer.dart';
import 'package:nadi_user_app/widgets/app_back.dart';
import 'package:nadi_user_app/widgets/my_service_card.dart';

class MyServiceRequest extends StatefulWidget {
  const MyServiceRequest({super.key});

  @override
  State<MyServiceRequest> createState() => _MyServiceRequestState();
}

class _MyServiceRequestState extends State<MyServiceRequest> {
  MyService _myService = MyService();
  List<dynamic> MyServices = [];
  bool isLoading = true;
  Timer? timer;
  @override
  void initState() {
    super.initState();
    myserviceslist();
    timer = Timer.periodic(const Duration(seconds: 10), (_) {
      myserviceslist();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> myserviceslist() async {
    AppLogger.warn("************************************");
    try {
      final response = await _myService.myallservices();
      if (!mounted) return;
      AppLogger.warn("myserviceslist ${jsonEncode(response)}");
      setState(() {
        MyServices = response ?? [];
        isLoading = false;
      });

      // ✅ optional optimization
      if (response != null &&
          response.every((e) => e["serviceStatus"] == "completed")) {
        timer?.cancel();
      }
    } catch (e) {
      isLoading = false;
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
              child: isLoading
                  ? ListView.builder(
                      itemCount: 6,
                      itemBuilder: (context, index) =>
                          const ServiceRequestCardShimmer(),
                    )
                  : MyServices.isEmpty
                  ? const Center(child: Text("No Service Requests Found"))
                  : ListView.builder(
                      itemCount: MyServices.length,
                      itemBuilder: (context, index) {
                        final service = MyServices[index];
                        return ServiceRequestCard(
                          title: service["serviceRequestID"] ?? "",
                          date: service["createdAt"] ?? "",
                          description: service["feedback"] ?? "",
                          serviceStatus: service['serviceStatus'] ?? "",
                          serviceLogo:
                              service["serviceId"]['serviceLogo'] ?? "",
                          onViewDetails: () {
                            context.push(
                              RouteNames.serviceRequestDetails,
                              extra: service,
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
