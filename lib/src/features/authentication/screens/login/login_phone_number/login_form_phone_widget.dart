import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:software_engg_project/src/features/authentication/controllers/signup_controller.dart';
import 'package:software_engg_project/src/features/authentication/screens/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';

import '../../../../../constants/sizes.dart';
import '../../../../../constants/text_strings.dart';
import '../../../controllers/login_controller.dart';
import '../../forget_password/forget_password_otp/otp_screen.dart';


class LoginFormPhone extends StatelessWidget {
  const LoginFormPhone({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();

    bool _isHidden = true;

    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: controller.phoneNo,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tPhoneNo,
                hintText: tPhoneNo,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: tFormHeight - 20),
            SizedBox(height: tFormHeight - 25),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {
                      ForgetPasswordScreen.buildShowModalButtonSheet(context);
                    }, child: Text(tForgetPassword))
            ),

            SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                      SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
                      Get.to(() => const OTPScreen());
                  }
                  , child: Text(tLogin.toUpperCase())),
            )
          ],
        ),
      ),
    );
  }

}