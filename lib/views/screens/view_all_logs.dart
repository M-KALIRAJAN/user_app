import 'package:flutter/material.dart';
import 'package:nadi_user_app/core/constants/app_consts.dart';
import 'package:nadi_user_app/widgets/app_back.dart';

class ViewAllLogs extends StatefulWidget {
  const ViewAllLogs({super.key});

  @override
  State<ViewAllLogs> createState() => _ViewAllLogsState();
}

class _ViewAllLogsState extends State<ViewAllLogs> {
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
          ],
        ),
      ),
    );
  }
}
