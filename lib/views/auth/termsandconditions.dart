import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';

class Termsandconditions extends StatefulWidget {
  const Termsandconditions({super.key});

  @override
  State<Termsandconditions> createState() => _TermsandconditionsState();
}

class _TermsandconditionsState extends State<Termsandconditions> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_clr,
      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),

              /// Title
              Text(
                "Terms & Conditions",
                style: TextStyle(
                  fontSize: AppFontSizes.xLarge,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 8),
              Divider()
,   const SizedBox(height: 20),
              Container(
                height: 276,
                width: 299,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderGrey),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 17,
                    vertical: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Header
                      Text(
                        "Our Commitments To You",
                        style: TextStyle(
                          color: AppColors.btn_primery,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 10),

                      SizedBox(
                        height: 150,
                        child: Text(
                          """
There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet.
""",
                          style: TextStyle(fontSize: AppFontSizes.small),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 10,
                        ),
                      ),

                      const Spacer(),

                      Text(
                        "Read the full Terms & Conditions",
                        style: TextStyle(
                          color: AppColors.btn_primery,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Checkbox(
                      value: isChecked,
                      activeColor: AppColors.btn_primery,
                      checkColor: Colors.white,
                      onChanged: (bool? newValue) {
                        setState(() {
                          isChecked = newValue!;
                        });
                      },
                    ),

                    Expanded(
                      child: Text(
                        "I have read and agree to the Service Connect Terms & Conditions and Privacy Policy",
                        style: TextStyle(fontSize: AppFontSizes.small),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: AppButton(
                  text: "Complete Registration",
                  onPressed: () {
                    if(isChecked)
                    context.push(RouteNames.opt);
                  },
                  color: isChecked
                      ? AppColors.btn_primery
                      : AppColors.button_secondary.withOpacity(0.5),
                  width: double.infinity,
                ),
              ),
              SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
