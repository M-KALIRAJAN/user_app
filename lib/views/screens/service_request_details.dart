import 'package:flutter/material.dart';
import 'package:mannai_user_app/core/constants/app_consts.dart';
import 'package:mannai_user_app/widgets/app_back.dart';
import 'package:mannai_user_app/widgets/inputs/app_text_field.dart';

class ServiceRequestDetails extends StatelessWidget {
  const ServiceRequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background_clr,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset("assets/images/service.png", fit: BoxFit.fill),
        
                Positioned(
                  top: 50,
                  left: 20,
                  child: AppCircleIconButton(
                    icon: Icons.arrow_back,
                    onPressed: () => Navigator.pop(context),
                    color: Colors.white,
                    iconcolor: AppColors.button_secondary,
                  ),
                ),
              ],
            ),
        
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const Text(
                    "Service Request Details",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 50,
                          height: 130,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(13, 95, 72, 0.2),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset(
                                "assets/icons/repair.png",
                                height: 24,
                                width: 24,
                              ),
                              Image.asset(
                                "assets/icons/tag.png",
                                height: 24,
                                width: 24,
                              ),
                              Image.asset(
                                "assets/icons/repair.png",
                                height: 24,
                                width: 24,
                              ),
                              Image.asset(
                                "assets/icons/tag.png",
                                height: 24,
                                width: 24,
                              ),
                            ],
                          ),
                        ),
        
                        const SizedBox(width: 12),
        
                        // Text content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              SizedBox(height: 7),
                              Text(
                                "Service Overview",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Request SRM-001",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                "Plumbing Repair",
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "2023-10-26 10:30 AM",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
        
                        // Status badge
                        SizedBox(width: 30),
                        Container(
                          margin: EdgeInsets.only(top: 7, right: 15),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.btn_primery,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            "Completed",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Complaint Detals",
                              style: TextStyle(
                                fontSize: AppFontSizes.medium,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text(
                              """அச்சுத்துறையிலும் வரைகலைத் துறையிலும், lorem ipsum என்பது இடத்தை நிரப்பும் ஒரு வெற்று உரை ஆகும். பொதுவாக, ஒரு ஆவணம் அல்லது வடிவமைப்பின் எழுத்துரு, படிமங்கள், பக்க வடிவமைப்பு முதலிய தோற்றக்கூறுகளின் மேல் கவனத்தைக் குவிப்பதற்காக இவ்வுரை பயன்படுகிறது.
                        விக்கிப்பீடியா
                        மேலும்
                        தமிழ் மொழியில் தேடுக""",
                            ),
                            SizedBox(height: 10,),
                            Container(
                              height: 150,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30)
                              ),
                              child: Image.asset("assets/images/service.png",fit:BoxFit.cover ,),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 90,),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                       height: 180,
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(12),
                         color: Colors.white
                       ),
                       child: Padding(
                         padding: const EdgeInsets.all(10.0),
                         child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Feedback",style: TextStyle(fontSize: AppFontSizes.medium,fontWeight: FontWeight.w600),),
                            SizedBox(height: 10,),
                            AppTextField(
                               maxLines: 4,
                       
                            )
                         
                          ],
                         ),
                       ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
