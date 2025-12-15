import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'package:mannai_user_app/views/onboarding/welcome_view.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';

class LanguangeView extends StatefulWidget {
  const LanguangeView({super.key});

  @override
  State<LanguangeView> createState() => _LanguangeViewState();
}

class _LanguangeViewState extends State<LanguangeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 350,
                child: Center(
                  child: Image.asset(
                    "assets/icons/language.png",
                    height: 180,
                    width: 213,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Choose The Language",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: AppFontSizes.xLarge,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 30),

                        AppButton(
                          text: "English",
                          onPressed: () {
                            context.go(RouteNames.accountverfy);
                          },
                          color: AppColors.btn_primery,
                          width: double.infinity,
                        ),

                        const SizedBox(height: 25),
                        AppButton(
                          text: "عربي",
                          onPressed: () {
                            context.go(RouteNames.welcome);
                          },
                          color: AppColors.button_secondary,
                          width: double.infinity,
                        ),

                        const SizedBox(height: 10),

                        Text(
                          "Your language preference can be changed any time in Settings",

                          style: TextStyle(
                            fontSize: AppFontSizes.small,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Poppins',
                            color: Color(0xFF79747E),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
