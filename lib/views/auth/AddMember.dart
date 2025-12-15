import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/controllers/family_member_controller.dart';

import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/core/utils/logger.dart';
import 'package:mannai_user_app/routing/app_router.dart';

import 'package:mannai_user_app/widgets/buttons/primary_button.dart';
import 'package:mannai_user_app/widgets/inputs/app_dropdown.dart';
import 'package:mannai_user_app/widgets/inputs/app_text_field.dart';

class Addmember extends StatefulWidget {
  final String accountType;
  final VoidCallback onNext;
  final GlobalKey<FormState> formKey;

  const Addmember({
    super.key,
    required this.accountType,
    required this.onNext,
    required this.formKey,
  });

  @override
  State<Addmember> createState() => _AddmemberState();
}

class _AddmemberState extends State<Addmember> {
   bool _isAddress = false;
  final controller =  FamilyMemberController();
   
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  "Add ${widget.accountType} Member",
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  
                  ),
                ),
                const SizedBox(height: 15),
                AppTextField(
                  controller: controller.familyCount,
                  label: "Enter Family Count*",
                  validator:(value)=> controller.validatefamilycount(value),
                ),
                const SizedBox(height: 15),

                AppTextField(
                  controller: controller.fullName,
                  label: "Member Full Name*",
                  validator: (value) => controller.validatefullname(value),
                ),

                const SizedBox(height: 15),
                AppDropdown(
                  label: "Relationship*",
                  items: ["Father", "Mother", "Son", "Daughter", "Spouse"],
                  value: controller.relation,
                  onChanged: (val) {
                      setState(() {
                          controller.relation = val;
                      });
                  },
                  validator: (val) =>
                      val == null ? "Please select relationship" : null,
                ),

                const SizedBox(height: 15),

                AppTextField(
                  controller: controller.mobile,
                  label: "Mobile Number*",
                  validator: (value) => controller.validatemobilenumber(value),
                ),

                const SizedBox(height: 15),

                AppTextField(
                  controller: controller.email,
                  label: "Email Adress*",
                  validator: (value) => controller.validateemail(value),
                ),
                const SizedBox(height: 20),
                AppDropdown(
                  label: "Gender*",
                  items: ["Male", "Female", "Oter"],
                  value: controller.gender,
                  onChanged: (val) {
                        setState(() {
                          controller.gender = val ;
                        });
                  },
                  validator: (val) =>
                      val == null ? "Please select relationship" : null,
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 47,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                       _isAddress = !_isAddress; 
                      });
                    },
                       child: Text(
                      _isAddress ? "Hide Address" : "Add Address",
                      style: TextStyle(color: AppColors.btn_primery),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                  if (_isAddress)
                  // Address(accountType: "Family" ,family: true, formKey: ,),
                    const SizedBox(height: 20),
                AppButton(
                  text: "Add Member",
                  onPressed: () {},
                  color: AppColors.button_secondary,
                  width: double.infinity,
                  height: 47,
                ),
                   
              ],
            ),
          ),
          const SizedBox(height: 20),
          AppButton(
            text: "Sign Up",
            onPressed: () {
                final isValied = widget.formKey.currentState?.validate() ?? false;
                if(!isValied) return null ;
                final addmember = controller.getfamilymemberdata();
                AppLogger.debug(jsonEncode(addmember));
                context.push(RouteNames.accountverfy);
            },
            color: AppColors.btn_primery,
            width: double.infinity,
            height: 47,
          ),
        ],
      ),
    );
  }
}
