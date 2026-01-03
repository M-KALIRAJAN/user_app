import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nadi_user_app/core/constants/app_consts.dart';
import 'package:nadi_user_app/core/network/dio_client.dart';
import 'package:nadi_user_app/models/technician_model.dart';
import 'package:nadi_user_app/widgets/app_back.dart';
import 'package:nadi_user_app/widgets/inputs/app_text_field.dart';
import 'package:shimmer/shimmer.dart';

class ServiceRequestDetails extends StatelessWidget {
  final Map<String, dynamic> serviceData;
  const ServiceRequestDetails({super.key, required this.serviceData});

  @override
  Widget build(BuildContext context) {
    /// TIMELINE DATA (MAP BASED)
    final timestamps = serviceData["statusTimestamps"];
    final bool technicianAccepted = serviceData["technicianAccepted"] == true;
    final String serviceStatus = serviceData["serviceStatus"];
    // final technician = serviceData["technicianId"];
    final List acceptedTechnicians = serviceData["acceptedTechnicians"] ?? [];
    String _getStatus({required bool completed, required bool current}) {
      if (completed) return "completed";
      if (current) return "current";
      return "pending";
    }

    String formatBackendDate(String dateStr) {
      final inputFormat = DateFormat('yyy-MM-dd, HH:mm');
      final outputFormat = DateFormat('dd/MM/yy hh:mm a');
      final dataTime = inputFormat.parse(dateStr);
      return outputFormat.format(dataTime);
    }

    final List<Map<String, dynamic>> steps = [
      {
        "title": "Request Submitted",
        "description": "Your service request has been successfully submitted.",
        "time": timestamps["submitted"],
        "status": _getStatus(
          completed: timestamps["submitted"] != null,
          current: false,
        ),
      },
      {
        "title": "Processing Request",
        "description": "Our team is reviewing the details of your request.",
        "time": timestamps["accepted"],
        "status": _getStatus(
          // completed: technicianAccepted,
          // current: !technicianAccepted,
          completed: timestamps["accepted"] != null,
          current: false,
        ),
      },
      // {
      //   "title": "Technician Assigned",
      //   "description": "A technician has been assigned to your request.",
      //   "time": timestamps["technicianAssigned"],
      //   "status": _getStatus(
      //     completed: timestamps["technicianAssigned"] != null,
      //     current:
      //         technicianAccepted && timestamps["technicianAssigned"] == null,
      //   ),
      //   "technician": technicianAccepted ? technician : null,
      // },
      {
        "title": "Technician Assigned",
        "description": "A technician has been assigned to your request.",
        "time": timestamps["technicianAssigned"],
        "status": _getStatus(
          completed: timestamps["technicianAssigned"] != null,
          current: timestamps["technicianAssigned"] == null,
        ),
        "acceptedTechnicians": acceptedTechnicians,
      },
      {
        "title": "Service In Progress",
        "description": "Technician is on the way to your location.",
        "time": timestamps["inProgress"],
        "status": _getStatus(
          completed: serviceStatus == "inProgress",
          current: serviceStatus != "completed",
        ),
         
      },
      {
        "title": "payment In Progress",
        "description": "Waiting for payment confirmation.",
        "time": timestamps["paymentInProgress"],
        "status": _getStatus(
          completed: serviceStatus == "paymentInProgress",
          current: serviceStatus != "completed",
        ),
         "payment": serviceData["payment"]
      },
      {
        "title": "Service Completed",
        "description": "Service has been successfully completed.",
        "time": timestamps["completed"],
        "status": _getStatus(
          completed: timestamps["completed"] != null,
          current: false,
        ),
        
      },
    ];

    Widget ImageShimmer() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background_clr,
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// HEADER IMAGE
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: serviceData["serviceId"]["serviceImage"] != null
                      ? "${ImageBaseUrl.baseUrl}/${serviceData["serviceId"]["serviceImage"]}"
                      : "",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => ImageShimmer(),
                  height: 220,
                ),
                Positioned(
                  top: 50,
                  left: 20,
                  child: AppCircleIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                    color: Colors.white,
                    iconcolor: AppColors.button_secondary,
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  /// TITLE
                  const Text(
                    "Service Request Details",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),

                  const SizedBox(height: 16),

                  /// SERVICE OVERVIEW
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 30,
                          height: 130,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(13, 95, 72, 0.2),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/icons/tag.png",
                                height: 24,
                                width: 24,
                              ),
                              Image.asset(
                                "assets/icons/repair.png",
                                height: 24,
                                width: 24,
                              ),
                              Image.asset(
                                "assets/icons/tag.png",
                                height: 24,
                                width: 24,
                              ),
                              Image.asset(
                                "assets/icons/repair.png",
                                height: 24,
                                width: 24,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Service Overview",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  serviceData["serviceRequestID"],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  serviceData["serviceId"]["name"],
                                  style: const TextStyle(fontSize: 13),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  formatBackendDate(
                                    serviceData["statusTimestamps"]["submitted"],
                                  ),
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.btn_primery,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            serviceData["serviceStatus"],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // PROGRESS TRACKER (IMAGE LIKE)
                  ServiceProgressTimeline(steps: steps),

                  const SizedBox(height: 20),

                  // COMPLAINT DETAILS
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Complaint Details",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          "Issue description provided by the user goes here.",
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.asset(
                            "assets/images/service.png",
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// FEEDBACK
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Feedback",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        AppTextField(maxLines: 4),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceProgressTimeline extends StatelessWidget {
  final List<Map<String, dynamic>> steps;
  const ServiceProgressTimeline({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: List.generate(
          steps.length,
          (index) => _TimelineTile(
            data: steps[index],
            isLast: index == steps.length - 1,
          ),
        ),
      ),
    );
  }
}

class _TimelineTile extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isLast;

  const _TimelineTile({required this.data, required this.isLast});
  String formatBackendDate(String dateStr) {
    final inputFormat = DateFormat('yyy-MM-dd, HH:mm');
    final outputFormat = DateFormat('dd/MM/yy hh:mm a');
    final dataTime = inputFormat.parse(dateStr);
    return outputFormat.format(dataTime);
  }

  Color get dotColor {
    if (data["status"] == "completed") return Colors.green;
    if (data["status"] == "current") return Colors.orange;
    return Colors.grey.shade400;
  }

  Color get chipBg {
    if (data["status"] == "completed") return Colors.green.shade100;
    if (data["status"] == "current") return Colors.orange.shade100;
    return Colors.grey.shade300;
  }

  String get label {
    if (data["status"] == "completed") return "Completed";
    if (data["status"] == "current") return "Current";
    return "Pending";
  }

  @override
  Widget build(BuildContext context) {
    final bool showTechnicians =
    data["title"] == "Technician Assigned" &&
    data["acceptedTechnicians"] != null &&
    (data["acceptedTechnicians"] as List).isNotEmpty;
final bool showPayment =
    data["title"] == "payment In Progress" &&
    data["payment"] != null;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: dotColor,
                shape: BoxShape.circle,
              ),
              child: data["status"] == "completed"
                  ? const Icon(Icons.check, size: 14, color: Colors.white)
                  : null,
            ),
           if (!isLast)
  Container(
    width: 2,
    height: showTechnicians ? 145.0 : 70.0,
    color: Colors.grey.shade300,
  ),

          ],
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      data["title"],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: chipBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 11,
                        color: dotColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                data["description"],
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              if (showPayment) ...[
  const SizedBox(height: 10),

  Container(
    padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 6),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Row(
      children: [
        const Icon(Icons.currency_rupee, size: 18, color: Colors.green),
        const SizedBox(width: 7),
        Text(
          "Amount to Pay:   ₹ ${data["payment"]}",
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
      ],
    ),
  ),
],
  const SizedBox(height: 10),


              // if (data["acceptedTechnicians"] != null) ...[
              //   const SizedBox(height: 10),
              //   Row(
              //     children: [
              //       CircleAvatar(
              //         radius: 16,
              //         backgroundImage: CachedNetworkImageProvider(
              //           "${ImageBaseUrl.baseUrl}/${data["acceptedTechnicians"]["technicianId"]['image']}",
              //         ),
              //       ),
              //       const SizedBox(width: 10),
              //       Text(
              //         "${data["acceptedTechnicians"]["technicianId"]['firstName']} ${data["acceptedTechnicians"]["technicianId"]['lastName']}",
              //         style: const TextStyle(
              //           fontSize: 13,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ],
              //   ),
              // ],
             if (showTechnicians) ...[ ...[
                const SizedBox(height: 10),

                SizedBox(
                  height: 36,
                  child: Stack(
                    children: List.generate(data["acceptedTechnicians"].length, (
                      index,
                    ) {
                      final techJson =
                          data["acceptedTechnicians"][index]["technicianId"];

                      final techModel = TechnicianModel.fromJson(techJson);

                      return Positioned(
                        left: index * 22.0,
                        child: InkWell(
                          onTap: () {
                            _showTechnicianDetails(context, techModel);
                          },
                          child: CircleAvatar(
                            radius: 16,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: techModel.image.isNotEmpty
                                ? CachedNetworkImageProvider(
                                    "${ImageBaseUrl.baseUrl}/${techModel.image}",
                                  )
                                : null,
                            child: techModel.image.isEmpty
                                ? const Icon(Icons.person, size: 16)
                                : null,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  "${data["acceptedTechnicians"].length} Technicians Assigned",
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],

              if (data["time"] != null) ...[
                const SizedBox(height: 6),
                Text(
                  formatBackendDate(data["time"]),
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
              ],
              const SizedBox(height: 16),
            ],
            ],
            
          )
        
        ),
      ],
    );
  }

  void _showTechnicianDetails(BuildContext context, TechnicianModel tech) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: tech.image.isNotEmpty
                    ? CachedNetworkImageProvider(
                        "${ImageBaseUrl.baseUrl}/${tech.image}",
                      )
                    : null,
                child: tech.image.isEmpty
                    ? const Icon(Icons.person, size: 40)
                    : null,
              ),
              const SizedBox(height: 12),

              Text(
                "${tech.firstName} ${tech.lastName}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.phone, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(tech.mobile, style: const TextStyle(fontSize: 14)),
                ],
              ),

              const SizedBox(height: 6),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.email, size: 16, color: Colors.grey),
                  const SizedBox(width: 6),
                  Text(tech.email, style: const TextStyle(fontSize: 14)),
                ],
              ),

              const SizedBox(height: 16),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.btn_primery,
                  minimumSize: const Size(double.infinity, 44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Close",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
