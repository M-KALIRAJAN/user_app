import 'package:flutter/material.dart';
import 'package:mannai_user_app/controllers/signup_controller.dart';
import 'package:mannai_user_app/core/utils/logger.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/services/auth_service.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';
import 'package:mannai_user_app/widgets/inputs/app_dropdown.dart';
import 'package:mannai_user_app/widgets/inputs/app_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountFormView extends StatefulWidget {
  final String accountType;
  final VoidCallback onNext;
  final GlobalKey<FormState> formKey;

  const AccountFormView({
    super.key,
    required this.accountType,
    required this.onNext,
    required this.formKey,
  });

  @override
  State<AccountFormView> createState() => _AccountFormViewState();
}

class _AccountFormViewState extends State<AccountFormView> {
  final controller = SignupController();
  final AuthService _basicInfo = AuthService();

  Future<void> submitBasicInfo(BuildContext context) async {
    if (!widget.formKey.currentState!.validate()) return;
    controller.saveToModel();
    final data = controller.signupData!;
    AppLogger.debug("User Basic Info : ${data.toJson().toString()}");
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString("userId");
    try {
      final response = await _basicInfo.basicInfo(
        userId: userId!,
        fullName: data.fullName,
        mobileNumber: data.mobileNumber,
        email: data.email,
        password: data.password,
        gender: data.gender,
      );
      if (response["message"] == "Basic info saved") {
        widget.onNext();
      }
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.accountType} ",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20),

          // Name
          AppTextField(
            controller: controller.name,
            label: "Enter Full Name*",
            validator: (value) => controller.validateName(value),
          ),
          const SizedBox(height: 17),

          // Mobile
          AppTextField(
            controller: controller.mobile,
            keyboardType: TextInputType.phone,
            label: "Mobile Number*",
            validator: (value) => controller.validateMobile(value),
          ),
          const SizedBox(height: 17),

          // Email
          AppTextField(
            controller: controller.email,
            label: "Email Address*",
            validator: (_) => controller.validateEmail(),
          ),
          const SizedBox(height: 17),

          // Gender
          AppDropdown(
            label: "Gender*",
            items: ["Male", "Female", "Oter"],
            value: controller.gender,
            onChanged: (val) {
              setState(() => controller.gender = val);
            },
            validator: (val) =>
                val == null ? "Please select relationship" : null,
          ),
          const SizedBox(height: 17),

          // Password
          AppTextField(
            controller: controller.password,
            label: "Create Password*",
            isPassword: true,
            validator: (value) => controller.validatePassword(),
          ),
          const SizedBox(height: 17),

          AppTextField(
            controller: controller.confirmPassword,
            label: "Confirm Password*",
            isPassword: true,
            validator: (value) => controller.validateConfirmPassword(value),
          ),
          const SizedBox(height: 40),

          AppButton(
            text: "Continue",
            color: AppColors.btn_primery,
            width: double.infinity,

            onPressed: () {
              submitBasicInfo(context);
            },
          ),
        ],
      ),
    );
  }
}
