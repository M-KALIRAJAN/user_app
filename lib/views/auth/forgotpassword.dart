import 'package:flutter/material.dart';

import 'package:nadi_user_app/core/constants/app_consts.dart';
import 'package:nadi_user_app/core/utils/logger.dart';
import 'package:nadi_user_app/services/auth_service.dart';
import 'package:nadi_user_app/widgets/buttons/primary_button.dart';
import 'package:nadi_user_app/widgets/inputs/app_text_field.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {

  final _formKey = GlobalKey<FormState>();
 final _emailCtrl = TextEditingController();
 AuthService _authService = AuthService();
Future<void> Emailverify() async {
  try {
    final email = _emailCtrl.text.trim();
    AppLogger.warn("************* $email");
    final response =
    await _authService.Forgetpassword(email:email );
    // SUCCESS snackbar
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(response['message'] ?? "Email sent"),
        backgroundColor: Colors.green,
      ),
    );
  } catch (e) {
    // ERROR snackbar
    AppLogger.error("$e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      ),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/back.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.03),

                        /// LOGO (Responsive)
                        Image.asset(
                          "assets/images/logo.png",
                          height: size.height * 0.45,
                        ),

                        

                        /// WHITE CONTAINER
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30),
                              ),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 20),
                                  const Text(
                                    " Change your Password",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  const SizedBox(height: 15),

                                  AppTextField(
                                    label: "Enter Email",
                                    keyboardType:
                                        TextInputType.emailAddress,
                                        controller: _emailCtrl,
                                  ),

                                  const SizedBox(height: 30),

                                  AppButton(
                                    height: 48,
                                    width: double.infinity,
                                    color: AppColors.btn_primery,
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                         Emailverify();
                                      }
                                    },
                                    text: "Login",
                                  ),

                                  const Spacer(),
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
            },
          ),
        ),
      ),
    );
  }
}
