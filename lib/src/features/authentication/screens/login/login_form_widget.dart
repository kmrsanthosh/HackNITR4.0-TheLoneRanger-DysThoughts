import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:software_engg_project/src/features/authentication/screens/forget_password/forget_password_options/forget_password_model_bottom_sheet.dart';

import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../controllers/login_controller.dart';
import '../forget_password/forget_password_options/forget_password_btn_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LoginController());
    final _formKey = GlobalKey<FormState>();

    return Form(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: tEmail,
                hintText: tEmail,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: tFormHeight - 20),
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  labelText: tPassword,
                  hintText: tPassword,
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                      onPressed: null,
                      icon: Icon(Icons.remove_red_eye_sharp))),
            ),
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
                    if(_formKey.currentState!.validate()){
                      LoginController.instance.loginWithEmailAndPassword(controller.email.text.trim(), controller.password.text.trim());
                    }
                  }
                  , child: Text(tLogin.toUpperCase())),
            )
          ],
        ),
      ),
    );
  }

}