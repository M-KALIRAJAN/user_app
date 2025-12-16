import 'package:flutter/material.dart';
import 'package:mannai_user_app/core/utils/validators.dart';
import 'package:mannai_user_app/models/family_member_model.dart';

class FamilyMemberController {
   final familyCount = TextEditingController();
   final fullName = TextEditingController();
   final mobile = TextEditingController();
   final email = TextEditingController();
   final password = TextEditingController();
   String?relation;
   String?gender;

   //Validation

   String? validatefamilycount(String? value) =>
         value == null || value.isEmpty ? "Enter Family Count" :  null ;
         String? validatepassword(String? value) => 
            value == null || value.isEmpty ? "Enter Password" : null ;
    String? validatefullname(String? value) =>
           value == null || value.isEmpty ? "Enter Fulname" : null ;
    String? validatemobilenumber(String? value) {
      return Validators.phonenumber(value);
    }
    String? validateemail(String? value){
        return Validators.email(value);
    }
       

      Map<String, dynamic> getApiFamilyMemberBody({
    required String userId,
    required Map<String, dynamic>? address,
  }) {
    return {
      "userId": userId,
      "familyCount": familyCount.text,
      "fullName": fullName.text,
      "relation": relation?.toLowerCase(),
      "mobile": mobile.text,
      "email": email.text,
      "password": password.text,
      "gender": gender?.toLowerCase(),
      "address": address,
    };
  }
}
