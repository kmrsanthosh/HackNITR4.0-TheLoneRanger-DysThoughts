import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:get/get.dart';
import 'package:software_engg_project/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';

import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../../../repository/authentication_repository/authentication_repository.dart';
import '../../../../authentication/controllers/signup_controller.dart';

class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    return Container(
      padding: EdgeInsets.symmetric(vertical: tFormHeight-13),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
            controller: controller.fullName,
              decoration: const InputDecoration(
                  label: Text(tFullName),
                  prefixIcon: Icon(Icons.person_outline_rounded)
              ),
            ),

            SizedBox(height: tFormHeight-20,),

            TextFormField(
              controller: controller.email,
              decoration: const InputDecoration(
                  label: Text(tEmail),
                  prefixIcon: Icon(Icons.person_outline_rounded)
              ),
            ),

            SizedBox(height: tFormHeight-20,),

            TextFormField(
              controller: controller.phoneNo,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                  label: Text(tPhoneNo),
                  prefixIcon: Icon(Icons.person_outline_rounded)
              ),
            ),

            SizedBox(height: tFormHeight-20,),

            TextFormField(
              controller: controller.password,
              obscureText: true,

              decoration: const InputDecoration(
                  label: Text(tPassword),
                  prefixIcon: Icon(Icons.person_outline_rounded)
              ),
            ),
            SizedBox(height: 10,),
            new FlutterPwValidator(
              controller: controller.password,
              minLength: 6,
              uppercaseCharCount: 1,
              numericCharCount: 1,
              specialCharCount: 1,
              width: 400,
              height: 150,
              onSuccess: () {

              },
            ),

            SizedBox(height: tFormHeight,),

            Row(
              children: [
                Expanded(
                  child: SizedBox(
                      width: double.infinity,
                      child:
                      OutlinedButton(onPressed: () {
                        if(_formKey.currentState!.validate()){
                          SignUpController.instance.registerUser(controller.email.text.trim(), controller.password.text.trim());
                          SignUpController.instance.adduserDetails(controller.email.text.trim(), controller.password.text.trim(), controller.phoneNo.text.trim(), controller.fullName.text.trim());
                        }
                      }, child: Text("Signup with Email".toUpperCase()))),
                ),

                const SizedBox(
                  width: 10.0,
                ),

                Expanded(
                  child: SizedBox(
                      width: double.infinity,
                      child:
                      ElevatedButton(onPressed: () {
                        if(_formKey.currentState!.validate()){
                          SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                          SignUpController.instance.adduserDetails(controller.email.text.trim(), controller.password.text.trim(), controller.phoneNo.text.trim(), controller.fullName.text.trim());
                          Get.to(() => const OTPScreen());
                        }
                      }, child: Text("Signup with Phone".toUpperCase()))),
                ),
              ],

            ),
          ],
        ),
      ),
    );

  }


}