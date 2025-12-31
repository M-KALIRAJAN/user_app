import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nadi_user_app/core/constants/app_consts.dart';
import 'package:nadi_user_app/core/network/dio_client.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nadi_user_app/core/utils/app_image.dart';

class ServiceRequestCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;
  final String serviceStatus;
  final String serviceLogo;
  final VoidCallback onViewDetails;

  const ServiceRequestCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
    required this.serviceStatus,
    required this.serviceLogo,
    required this.onViewDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
      child: Container(
        height: 177,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    height: 55,
                    width: 55,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: serviceStatus == "submitted"
                          ? AppColors.button_secondary
                          : serviceStatus == "paymentInProgress"
                          ? const Color.fromARGB(255, 112, 214, 11)
                          : serviceStatus == "accepted"
                          ? AppColors.button_secondary
                          : serviceStatus == "inProgress"
                          ? Colors.grey
                          : serviceStatus == "technicianAssigned"
                          ? AppColors.btn_primery
                          : null,
                    ),
                    child: buildServiceIcon(serviceLogo: serviceLogo, size: 39, isAsset: false),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title),
                      const SizedBox(height: 5),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: AppFontSizes.small,
                          color: AppColors.borderGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                description,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: AppFontSizes.small,
                  color: AppColors.borderGrey,
                ),
              ),
              const SizedBox(height: 10),
              Container(height: 1, color: AppColors.borderGrey),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 32,
                    width: 135,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: serviceStatus == "submitted"
                          ? AppColors.btn_primery
                          : serviceStatus == "paymentInProgress"
                          ? const Color.fromARGB(255, 112, 214, 11)
                          : serviceStatus == "accepted"
                          ? AppColors.btn_primery
                          : serviceStatus == "inProgress"
                          ? Colors.grey
                          : serviceStatus == "technicianAssigned"
                          ? AppColors.btn_primery
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        serviceStatus,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 31,
                    width: 135,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: AppColors.btn_primery,
                          width: 1,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: onViewDetails,
                      child: const Text(
                        "View Details",
                        style: TextStyle(color: AppColors.btn_primery),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
