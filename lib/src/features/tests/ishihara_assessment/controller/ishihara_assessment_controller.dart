import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../repository/assessment_repository.dart';

class IshiharaAssessmentController extends GetxController{
  static IshiharaAssessmentController get instance => Get.find();

  final answer = TextEditingController();
  int result = 0;

  List listOfAnswers = [
    "6",
    "42"
  ];

  int j = 1;
  int k=1;




  void verifyAnswer(String answer) {

    for (int i=0; i<2; i++) {
      if (answer == listOfAnswers[i]) {
        result++;
        i++;
      }
    }

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user != null) {
        final userid = user.uid;

        await FirebaseFirestore.instance.collection(userid).doc("Ishihara Assessment").collection("Test ${j}").doc("User Answers").set ({
          "Qn ${k}" : answer,
          "Answered Timestamp" : Timestamp.now(),
        },SetOptions(merge:true));

        k++;

      }
    });

    Get.snackbar(
      "Result",result.toString(),
    );

  }

  Future submitAnswers() async {

    int i = 1;

    double final_result_temp = ((result/2)*100);

    String final_result = final_result_temp.toString();



    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user != null) {
        final userid = user.uid;

        await FirebaseFirestore.instance.collection(userid).doc("Ishihara Assessment").collection("Test ${i}").doc("Result").set ({
          "Test Score" : final_result+"%",
          "Test attempt TimeStamp" : Timestamp.now(),
        });
        i++;
        j++;

      }
    });


    j = k = 1;

  }

}