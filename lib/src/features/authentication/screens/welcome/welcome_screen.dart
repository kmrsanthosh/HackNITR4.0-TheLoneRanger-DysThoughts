import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engg_project/src/constants/colors.dart';
import 'package:software_engg_project/src/constants/image_strings.dart';
import 'package:software_engg_project/src/constants/sizes.dart';
import 'package:software_engg_project/src/constants/text_strings.dart';
import 'package:software_engg_project/src/features/authentication/screens/signup/signup_screen.dart';

import '';
import '../login/login_phone_number/login_screen_phone_number.dart';
import '../login/login_screen.dart';
import 'welcome_login_choice.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode ? tSecondaryColor : tPrimaryColor_welcomeScreen,
      body: Container(
        padding: EdgeInsets.all(tDefaultSize),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AssetImage(tWelcomeScreenImage),
              height: height * 0.6,
            ),
            Column(
              children: [
                Text(
                  tWelcomeTitle,
                  style: Theme.of(context).textTheme.headline3,
                ),
                Text(
                  tWelcomeSubTitle,
                  style: Theme.of(context).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                  onPressed: () {
                    WelcomeLoginChoice.buildShowModalButtonSheet(context);
                  },
                  child: Text(tLogin.toUpperCase()),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7), // <-- Radius
                    ),
                  ),
                )),
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: ElevatedButton(
                  onPressed: () => Get.to(() => const SignUpScreen()),
                  child: Text(tSignup.toUpperCase()),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7), // <-- Radius
                    ),
                  ),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
