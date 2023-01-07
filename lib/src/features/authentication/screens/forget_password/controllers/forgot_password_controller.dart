import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:software_engg_project/src/repository/authentication_repository/authentication_repository.dart';

import '';

class ForgotPasswordController extends GetxController{
  static ForgotPasswordController get instance => Get.find();

  final email = TextEditingController();

  void sendPasswordResetEmail(String email) {
    AuthenticationRepository.instance.sendPasswordResetEmail(email);
    Get.snackbar(
      "Success!",
      "Password reset request was sent succesfully. Please check your email to reset your password",
    );
  }
  }