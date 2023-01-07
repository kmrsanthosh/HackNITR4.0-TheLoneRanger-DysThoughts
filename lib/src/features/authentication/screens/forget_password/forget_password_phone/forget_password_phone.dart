import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:software_engg_project/src/common_widgets/form/form_header_widget.dart';
import 'package:software_engg_project/src/constants/image_strings.dart';
import 'package:software_engg_project/src/constants/text_strings.dart';
import 'package:software_engg_project/src/features/authentication/screens/forget_password/controllers/forgot_password_controller.dart';
import 'package:software_engg_project/src/features/authentication/screens/forget_password/forget_password_otp/otp_screen.dart';
import 'package:software_engg_project/src/features/authentication/screens/login/login_footer_widget.dart';

import '../../../../../constants/sizes.dart';
import '../../../controllers/signup_controller.dart';

class ForgetPasswordPhoneScreen extends StatelessWidget {
  const ForgetPasswordPhoneScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(SignUpController());

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
                        controller: controller.phoneNo,
                        decoration: const InputDecoration(
                          label: Text(tPhoneNo),
                          hintText: tPhoneNo,
                          prefixIcon: Icon(Icons.phone_iphone_outlined),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      SizedBox(width: double.infinity, child:
                      ElevatedButton(
                          onPressed: () {
                            SignUpController.instance.phoneAuthentication(controller.phoneNo.text.trim());
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
