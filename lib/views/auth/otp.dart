import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';
import 'package:pinput/pinput.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  final otpController = TextEditingController();
  @override
  final defaultPinTheme = PinTheme(
    width: 50,
    height: 50,
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey),
    ),
  );
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_clr,
      body: SafeArea(
        child: Center(
        
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             
              Text(
                "Enter Verification code",
                style: TextStyle(
                  fontSize: AppFontSizes.large,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "We have sent you a 4 digit verification code on",
                style: TextStyle(
                  fontSize: AppFontSizes.small,
                  color: AppColors.borderGrey,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "+91 7502130089",
                style: TextStyle(
                  fontSize: AppFontSizes.medium,
                  color: AppColors.borderGrey,
                  fontWeight: FontWeight.w600,
                ),
              ),
SizedBox(
  height: 20,
),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Pinput(
                    controller: otpController,
                    length: 4,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: defaultPinTheme.copyDecorationWith(
                      border: Border.all(color: AppColors.button_secondary),
                    ),
                    submittedPinTheme: defaultPinTheme.copyDecorationWith(
                      border: BoxBorder.all(color: Colors.green),
                    ),
                    keyboardType: TextInputType.number,
                    onCompleted: (value) {
                      print("OTP: $value");
                    },
                  ),
                ],
              ),
        
              Padding(
                padding: const EdgeInsets.only(top: 90,left: 25,right: 25),
                child: AppButton(
                  text: "Sign In",
                  onPressed: (){
                      context.push(RouteNames.accountcreated);
                  },
                  color: AppColors.btn_primery,
                  width: double.infinity,
                ),
              ),

              Row(
                children: [
                   Container(
                    width: 30,
                    height: 1,
                   )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
