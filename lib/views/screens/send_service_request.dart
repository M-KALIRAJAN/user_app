import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/routing/app_router.dart';
import 'package:mannai_user_app/widgets/app_back.dart';
import 'package:mannai_user_app/widgets/buttons/primary_button.dart';
import 'package:mannai_user_app/widgets/inputs/app_text_field.dart';

class SendServiceRequest extends StatefulWidget {
  final String title;
  final String? imagePath;

  const SendServiceRequest({super.key, required this.title, this.imagePath});

  @override
  State<SendServiceRequest> createState() => _SendServiceRequestState();
}

class _SendServiceRequestState extends State<SendServiceRequest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP HEADER
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 17,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppCircleIconButton(
                      icon: Icons.arrow_back,
                      onPressed: () {
                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>))
                        Navigator.pop(context);
                      },
                    ),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              const Divider(),

              const SizedBox(height: 15),

              // MAIN CONTENT
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SERVICE IMAGE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: widget.imagePath != null
                              ?CachedNetworkImage(
                                imageUrl:widget.imagePath!,
                                       width: double.infinity,
                                  height: 200,
                                  fit: BoxFit.cover,
                                )
                          
                              : Container(
                                  width: double.infinity,
                                  height: 200,
                                  color: Colors.grey[300],
                                  child: const Icon(
                                    Icons.miscellaneous_services,
                                    size: 50,
                                    color: Colors.white,
                                  ),
                                ),
                        ),

                        const SizedBox(height: 25),

                        const Text(
                          "Issue  Details",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        AppTextField(
                          controller: TextEditingController(
                            text: "Select an Issuse",
                          ),
                        ),
                        const SizedBox(height: 15),

                        // DESCRIPTION FIELD
                        TextField(
                          minLines: 5,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                            labelText: "Describe your issue…",
                            labelStyle: const TextStyle(
                              color: AppColors.borderGrey,
                            ),
                            alignLabelWithHint: true,
                            contentPadding: const EdgeInsets.all(14),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(
                                color: AppColors.borderGrey,
                              ),
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 22),

                        const Text(
                          "Media Upload (optional)",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 14),

                        // UPLOAD BUTTON
                        SizedBox(
                          height: 48,
                          width: double.infinity,
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                color: Color.fromRGBO(135, 137, 147, 100),
                                width: 1.2,
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Upload Gallery",
                                  style: TextStyle(
                                    color: AppColors.borderGrey,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  height: 38,
                                  width: 38,
                                  decoration: const BoxDecoration(
                                    color: Color.fromRGBO(135, 137, 147, 100),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.file_upload_outlined,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 35),

                        // ACTION BUTTONS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppButton(
                              text: "Cancel",
                              onPressed: () => context.pop(),
                              color: AppColors.button_secondary,
                              width: 120,
                              height: 50,
                            ),
                            AppButton(
                              text: "Submit",
                              onPressed: () {
                                context.push(
                                  RouteNames.servicerequestsubmitted,
                                );
                              },
                              color: AppColors.btn_primery,
                              width: 170,
                              height: 50,
                            ),
                          ],
                        ),

                        const SizedBox(height: 30),
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
