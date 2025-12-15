import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/widgets/app_back.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';
import 'package:mannai_user_app/widgets/inputs/app_text_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_clr,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 20,
                bottom: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCircleIconButton(icon: Icons.arrow_back, onPressed: () {context.pop(context);}),
                  Text(
                    "Edit Profile",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  ),
                  Text(""),
                ],
              ),
            ),
            Divider(),
           Expanded(
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          
          Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.shade200,
                  child: ClipOval(
                    child: Image.asset(
                      "assets/images/service.png",
                      fit: BoxFit.cover,
                      width: 120,
                      height: 120,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        color: Color(0xFF4C9581),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),

          // Full Name
          const Text(
            "Full Name",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AppTextField(
            controller: TextEditingController(text: "Muhamad Musin"),
          ),
          const SizedBox(height: 15),

          // Email Address
          const Text(
            "Email Address",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AppTextField(
            controller: TextEditingController(text: "Muhamad Musin"),
          ),
          const SizedBox(height: 15),

          // Phone Number
          const Text(
            "Phone Number",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AppTextField(
            controller: TextEditingController(text: "Muhamad Musin"),
          ),
          const SizedBox(height: 15),

          // Building (Single field)
          const Text(
            "Building",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AppTextField(
            controller: TextEditingController(text: "Muhamad Musin"),
          ),
          const SizedBox(height: 15),

    
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Block",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    AppTextField(
                      controller: TextEditingController(text: "A"),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Floor",
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 5),
                    AppTextField(
                      controller: TextEditingController(text: "1"),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),

          // More fields
          const Text(
            "Apartment",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AppTextField(
            controller: TextEditingController(text: "101"),
          ),
          const SizedBox(height: 15),

          const Text(
            "Additional Info",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 5),
          AppTextField(
            controller: TextEditingController(text: "N/A"),
          ),
          const SizedBox(height: 30),

          // Buttons
          Row(
            children: [
              Expanded(
                child: AppButton(
                  text: "Cancel",
                  onPressed: () {},
                  color: Color.fromRGBO(76, 149, 129, 1),
                  width: double.infinity,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: AppButton(
                  text: "Save",
                  onPressed: () {},
                  color: Color.fromRGBO(13, 95, 72, 1),
                  width: double.infinity,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
        ],
      ),
    ),
  ),
)

              ]

            ),
         
        ),
    );

  }
}
