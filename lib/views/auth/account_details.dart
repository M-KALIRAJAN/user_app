import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/core/utils/logger.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'package:mannai_user_app/services/auth_service.dart';
import 'package:mannai_user_app/widgets/app_back.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final AuthService _authService = AuthService();
  @override
  void initState() {
    super.initState();
    _loadAccoundtype();
  }

  Future<void> _loadAccoundtype() async {
    await _authService.acountype();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.55, // control height
            child: Image.asset(
              "assets/images/accounttype.png",
              fit: BoxFit.cover,
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppCircleIconButton(
                icon: Icons.arrow_back,
                onPressed: () => context.pop(),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.50,
              width: double.infinity,
              padding: const EdgeInsets.all(30),

              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Account Type",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),

                  const SizedBox(height: 25),
                  // In your AccountDetails widget
                  AppButton(
                    text: "Individual Account",
                    icon: Image.asset(
                      "assets/icons/person.png",
                      height: 26,
                      width: 26,
                    ),
                    color: AppColors.btn_primery,
                    width: double.infinity,
                    onPressed: () async {
                      final res = await _authService.selectIndividualAccount();
                      if (res) {
                        // userId is stored, navigate to next screen
                        context.pushNamed(
                          RouteNames.stepper,
                          extra: "Individual",
                        );
                      } else {
                        // API failed or userId not found
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Failed to select account"),
                          ),
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Manage your services and profile independently.",
                    style: TextStyle(
                      fontSize: AppFontSizes.small,
                      color: AppColors.borderGrey,
                    ),
                  ),

                  const SizedBox(height: 27),

                  AppButton(
                    text: "Family Account",
                    icon: Image.asset("assets/icons/persons.png", height: 40),
                    color: AppColors.btn_primery,
                    width: double.infinity,
                    onPressed: () async{
                      // context.push(RouteNames.bottomnav);
                      // context.pushNamed(RouteNames.stepper, extra: "Family");
                       final res = await _authService.selectIndividualAccount();
                      if (res) {
                        // userId is stored, navigate to next screen
                        context.pushNamed(
                          RouteNames.stepper,
                          extra: "Family",
                        );
                      }
                    },
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Register and manage services for multiple family members.",
                    style: TextStyle(
                      fontSize: AppFontSizes.small,
                      color: AppColors.borderGrey,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
