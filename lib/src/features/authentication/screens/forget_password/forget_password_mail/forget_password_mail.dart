import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:software_engg_project/src/common_widgets/form/form_header_widget.dart';
import 'package:software_engg_project/src/constants/image_strings.dart';
import 'package:software_engg_project/src/constants/text_strings.dart';
import 'package:software_engg_project/src/features/authentication/screens/forget_password/controllers/forgot_password_controller.dart';
import 'package:software_engg_project/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:software_engg_project/src/features/authentication/screens/login/login_footer_widget.dart';

import '../../../../../constants/sizes.dart';

class ForgetPasswordMailScreen extends StatelessWidget {
  const ForgetPasswordMailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ForgotPasswordController());

    return SafeArea(
      child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(tDefaultSize),
                  child: Column(
                    children: [
                      SizedBox(height: tDefaultSize * 4,),
                      FormHeaderWidget(
                          image: tForgetPasswordImage,
                          title: tForgetPassword,
                          subTitle: tForgetPasswordSubTitle,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          heightBetween: 30,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: tFormHeight,),
                      Form(
                          child: Column(
                            children: [
                              TextFormField(
                              controller: controller.email,
                              decoration: const InputDecoration(
                              label: Text(tEmail),
                              hintText: tEmail,
                              prefixIcon: Icon(Icons.mail_outline_rounded),
                          ),
                        ),
                              const SizedBox(height: 20,),
                              SizedBox(width: double.infinity, child:
                              ElevatedButton(
                                  onPressed: () {
                                    ForgotPasswordController.instance.sendPasswordResetEmail(controller.email.text.trim());
                                    Get.to(() => const OTPScreen());
                                  },
                                  child: Text(tNext))),
                      ],
                          ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
