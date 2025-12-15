import 'package:flutter/material.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';

class RecentActivity extends StatefulWidget {
  const RecentActivity({super.key});

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      shrinkWrap: true,
 physics: PageScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 10),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.btn_primery,
                      ),
                      child: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 180,
                          child: Text(
                            "Service request #SC-00${index + 1} completed",
                            style: const TextStyle(
                              fontSize: 14,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          "2 hours ago",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),

                    const Spacer(),

                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 22,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.btn_primery,
                        ),
                        child: const Center(
                          child: Text(
                            "Completed",
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Divider
                Container(
                  height: 1,
                  width: double.infinity,
                  color: AppColors.borderGrey,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
