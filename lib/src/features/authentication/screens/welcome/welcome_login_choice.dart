import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../forget_password/forget_password_mail/forget_password_mail.dart';
import '../forget_password/forget_password_options/forget_password_btn_widget.dart';
import '../login/login_phone_number/login_btn_widget.dart';
import '../login/login_phone_number/login_screen_phone_number.dart';
import '../login/login_screen.dart';

class WelcomeLoginChoice{
  static void buildShowModalButtonSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
        isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      builder: (context) => FractionallySizedBox(
        heightFactor: 0.45,
        child: Container(
          padding: EdgeInsets.all(tDefaultSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Please choice the method to login", style: Theme.of(context).textTheme.headline2),
              const SizedBox(height: 30,),
              LoginBtnWidget(
                btnIcon: Icons.mail_outline_rounded,
                title: tEmail,
                subTitle: "Login with your \nregistered email",

                onTap: () {
                  Navigator.pop(context);
                  Get.to (() => LoginScreen());},
              ),

              const SizedBox(height: 20.0),

              LoginBtnWidget(
                btnIcon: Icons.phone_iphone_rounded,
                title: tPhoneNo,
                subTitle: "Login with your \nregistered phone number",
                onTap: () {
                  Navigator.pop(context);
                  Get.to (() => LoginScreenPhone());
                },
              ),
            ],
          ),
        ),
      ),);
  }
}

