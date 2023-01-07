import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engg_project/src/features/authentication/screens/signup/signup_screen.dart';

import '../../../../constants/image_strings.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../signup/widgets/auth_repo.dart';
import 'login_screen.dart';

class LoginFooterWidget extends StatelessWidget {
  const LoginFooterWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          ("OR"),
        ),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
              icon: Image(
                image: AssetImage(tGoogleLogoImage),
                width: 20,
              ),
              onPressed: () async {
                try {
                  await AuthRepo.signInWithGoogle().then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text('Welcome: ${value.user?.displayName ?? ""}'),
                    ));
                  });
                } catch (e) {
                  //snackbar
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Error: $e'),
                  ));
                }
              },
              label: Text(tSignInWithGoogle)),
        ),
        const SizedBox(
          height: tFormHeight - 20,
        ),
        TextButton(
            onPressed: null,
            child: Text.rich(
                TextSpan(
                    text: tDontHaveAnAccount,
                    style: Theme.of(context).textTheme.bodyText1,
                    children: [
                      TextSpan(
                          text: tSignup,
                          style: TextStyle(color: Colors.blue),
                        recognizer: new TapGestureRecognizer()..onTap = () {
                          Get.to(() => SignUpScreen());
                        },
                      )])))
      ],
    );
  }
}
