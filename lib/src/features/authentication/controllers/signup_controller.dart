import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:software_engg_project/src/repository/authentication_repository/authentication_repository.dart';

import '';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final fullName = TextEditingController();
  final phoneNo = TextEditingController();

  void registerUser(String email, String password) {
    AuthenticationRepository.instance.createUserWithEmailAndPassword(email, password);

  }

  void phoneAuthentication(String phoneNo) {
    AuthenticationRepository.instance.phoneAuthentication(phoneNo);
  }

  Future adduserDetails(String email, String password, String phoneNo, String fullName) async {

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user != null) {
      final userid = user.uid;

      await FirebaseFirestore.instance.collection(userid).doc("userDetails").set ({
        'fullName' : fullName,
        'email' : email,
        'phoneNo' : phoneNo,
      });

      }
    });




  }

}