import 'package:flutter/material.dart';
import 'package:mannai_user_app/core/utils/validators.dart';
import 'package:mannai_user_app/models/family_member_model.dart';

class FamilyMemberController {
   final familyCount = TextEditingController();
   final fullName = TextEditingController();
   final mobile = TextEditingController();
   final email = TextEditingController();
   String?relation;
   String?gender;

   //Validation

   String? validatefamilycount(String? value) =>
         value == null || value.isEmpty ? "Enter Family Count" :  null ;
    String? validatefullname(String? value) =>
           value == null || value.isEmpty ? "Enter Fulname" : null ;
    String? validatemobilenumber(String? value) {
      return Validators.phonenumber(value);
    }
    String? validateemail(String? value){
        return Validators.email(value);
    }
       
       FamilyMemberModel getfamilymemberdata(){
        return FamilyMemberModel(
          relation: relation!,
          
            fullName: fullName.text,
             mobileNumber: mobile.text,
              email: email.text,
               gender: gender!, 
               familyCount: familyCount.text);
       }
}