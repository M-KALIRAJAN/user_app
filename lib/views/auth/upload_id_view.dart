import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mannai_user_app/core/utils/logger.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'package:mannai_user_app/widgets/app_back.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';
import 'package:mannai_user_app/widgets/id_card.dart';

class UploadIdView extends StatefulWidget {
  const UploadIdView({super.key});

  @override
  State<UploadIdView> createState() => _UploadIdViewState();
}

class _UploadIdViewState extends State<UploadIdView> {
   File? frontImage;
   File? backImage;

   final ImagePicker picker = ImagePicker();

   Future<void> pickImage(bool isFront , ImageSource source) async{
    final XFile? image = await picker.pickImage(source: source);
    if(image == null) return;

    setState(() {
      if(isFront){
        frontImage = File(image.path);
      }else{
        backImage = File(image.path);
      }
    });
   }
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
                left: 17,
                right: 17,
                top: 10,
                bottom: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppCircleIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () {},
                  ),
        
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: AppFontSizes.medium,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),
            SizedBox(height: 8),
            Divider(),
            SizedBox(height: 5),
       
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 17),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Upload ID Card",
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 20),
                      IdCardSection(
                        title: "Front Side of ID Card",
                        subtitle:
                            "Ensure your name, photo, and expiry date are clearly visible.",
                            previewImage:frontImage,
                        onTakePhoto: () {
                          print("Take photo clicked");
                          pickImage(true, ImageSource.camera);
                        },
                        onUploadGallery: () {
                          print("Upload gallery clicked");
                          pickImage(true, ImageSource.gallery);
                        },
                      ),
                      const SizedBox(height: 20),
                      IdCardSection(
                        title: "Front Side of ID Card",
                        subtitle:
                            "Ensure your name, photo, and expiry date are clearly visible.",
                        previewImage:backImage,
                        onTakePhoto: () {
                          print("Take photo clicked");
                         pickImage(false, ImageSource.camera);
                        },
                        onUploadGallery: () {
                        pickImage(false, ImageSource.gallery);

                          print("Upload gallery clicked");
                        },
                      ),
                      SizedBox(height: 20),
                      AppButton(
                        text: "Continue",
                        onPressed: () {
                          if(frontImage != null){
                            AppLogger.debug("Front Image Path: ${frontImage!.path}");
                          }
                          if(backImage != null){
                            AppLogger.debug("Back Image Path: ${backImage!.path}");
                          }
                          context.push(RouteNames.Terms);
                        },
                        color: AppColors.btn_primery,
                        width: double.infinity,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
