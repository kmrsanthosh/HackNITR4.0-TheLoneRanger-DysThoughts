import 'package:flutter/material.dart';
import 'package:software_engg_project/src/common_widgets/form/form_header_widget.dart';
import 'package:software_engg_project/src/constants/image_strings.dart';
import 'package:software_engg_project/src/constants/sizes.dart';
import 'package:software_engg_project/src/constants/text_strings.dart';

import '../login_footer_widget.dart';
import '../login_form_widget.dart';
import 'login_form_phone_widget.dart';

class LoginScreenPhone extends StatelessWidget {
  const LoginScreenPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(tDefaultSize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const[
                FormHeaderWidget(image: tWelcomebackImage, title: tLoginTitle, subTitle: tLoginSubTitle),
                LoginFormPhone(),
                LoginFooterWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

