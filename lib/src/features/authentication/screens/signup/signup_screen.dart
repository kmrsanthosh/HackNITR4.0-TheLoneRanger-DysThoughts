import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engg_project/src/common_widgets/form/form_header_widget.dart';
import 'package:software_engg_project/src/constants/colors.dart';
import 'package:software_engg_project/src/constants/image_strings.dart';
import 'package:software_engg_project/src/constants/text_strings.dart';
import 'package:software_engg_project/src/features/authentication/screens/login/login_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:software_engg_project/src/features/authentication/screens/signup/widgets/auth_repo.dart';

import '../../../../constants/sizes.dart';
import '../welcome/welcome_login_choice.dart';
import 'widgets/signup_form-widget.dart';

class SignUpScreen extends StatelessWidget{
  const SignUpScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(tDefaultSize),
            child: Column(
              children: [
                FormHeaderWidget(image: tWelcomebackImage, title: tSignUpTitle, subTitle: tSignUpSubTitle,),
                SignUpFormWidget(),

                Column(
                  children: [
                    const Text("OR"),
                    SizedBox(height: 25,),
                    SizedBox(
                      width: double.infinity,
                      child:
                      OutlinedButton.icon(onPressed:() async{
                        try {
                          await AuthRepo.signInWithGoogle().then((value) async {

                            if(value != null) {
                              final uid = value.user?.email;
                              await FirebaseFirestore.instance.collection(uid!).doc("userDetails").set ({
                              'fullName' : value.user?.displayName,
                              'email' : value.user?.email,
                              'phoneNo' : value.user?.phoneNumber,
                              'profilePicture' : value.user?.photoURL,
                               'uid' : value.user?.uid,
                            });
                            }


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

                      }, icon: Image(image: AssetImage(tGoogleLogoImage), width: 20,),
                          label: Text(tSignInWithGoogle.toUpperCase())),
                    ),
                    TextButton(
                      onPressed: null,
                      child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(text: tAlreadyHaveAnAccount, style: Theme.of(context).textTheme.bodyText1),
                              TextSpan(text: tLogin.toUpperCase(), style: TextStyle(color: Colors.blue),
                                recognizer: new TapGestureRecognizer()..onTap = () {
                                  WelcomeLoginChoice.buildShowModalButtonSheet(context);
                                },
                              )
                            ]
                          )
                      ),
                    )
                  ],
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
}


