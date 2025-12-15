import 'package:flutter/material.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';
import 'package:mannai_user_app/views/screens/service_request_details.dart';

class ServiceRequestCard extends StatelessWidget {
  final String title;
  final String date;
  final String description;

  const ServiceRequestCard({
    super.key,
    required this.title,
    required this.date,
    required this.description,
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
            children: [
              Row(
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.btn_primery,
                    ),
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
                  AppButton(
                    text: "Resolved",
                    onPressed: () {},
                    color: AppColors.btn_primery,
                    width: 125,
                    height: 31,
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
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const ServiceRequestDetails(),
                          ),
                        );
                      },
                      child: Text(
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
