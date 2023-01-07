import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:software_engg_project/global.dart';
import 'package:software_engg_project/src/constants/image_strings.dart';
import 'package:software_engg_project/src/features/authentication/screens/welcome/welcome_screen.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/sizes.dart';
import '../../../../constants/text_strings.dart';
import '../../../../repository/authentication_repository/authentication_repository.dart';
import '../../../authentication/controllers/signup_controller.dart';
import '../../../core/screens/dashboard/widgets/dashboard.dart';
import '../controller/ishihara_assessment_controller.dart';





class ishihara_assessment extends StatefulWidget {
  ishihara_assessment({Key? key}) : super(key: key);

  @override
  State<ishihara_assessment> createState() => _ishihara_assessmentState();
}

class _ishihara_assessmentState extends State<ishihara_assessment> {
  // padding constants
  final double horizontalPadding = 40;

  final double verticalPadding = 25;

  int numberOfPages = 2;

  int currentPage =0;

  List ishiharaImageList = [
    ishiharaAssessmentPic1,
    ishiharaAssessmentPic2,
  ];

  int i=0, j=0, k=0, l=0, m=0, n = 0;

  bool show_finish = false;

  bool textFormFieldStatus = true;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(IshiharaAssessmentController());

    if (fullName == null) {
      fullName = "User";
    }

    if (profilepic == null) {
      profilepic = "https://via.placeholder.com/150";
    }

    var height = MediaQuery
        .of(context)
        .size
        .height;
    var brightness = MediaQuery
        .of(context)
        .platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    var pages = List.generate(numberOfPages, (index) => Center(
      child: Text("Page Number: ${index+1}"),
    ));

    return Scaffold(
      backgroundColor: isDarkMode ? tDarkColor : tWhiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // app bar
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: horizontalPadding,
                      vertical: verticalPadding,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // menu icon
                        Image.asset(
                          'assets/images/dashboard/menu.png',
                          height: 40,
                          color: isDarkMode ? Colors.white : Colors.grey.shade800,
                        ),

                        // account icon
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 25.0,
                            backgroundImage:
                            NetworkImage(profilepic!),
                            backgroundColor: Colors.transparent,
                          ),
                          onTap: () async {
                            await AuthenticationRepository.instance.logout();
                            Get.to(() => WelcomeScreen());
                          },
                        )
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // welcome home
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Ishihara Assessment",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline2,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: horizontalPadding),
                            child: Image.network(ishiharaImageList[l],
                              height: 300,
                            )
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 45),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),





                  ),
                  const SizedBox(height: 0),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Center(
                      child: Text(
                        "Please enter the number you see in the image given above",
                        textAlign: TextAlign.center,
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),


                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                    child: Center(
                      child: Text(
                        "Answer",
                        style: Theme
                            .of(context)
                            .textTheme
                            .headline2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),



                  Container(
                    padding: const EdgeInsets.all(tDefaultSize),
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            enabled: textFormFieldStatus,
                            controller: controller.answer,
                            decoration: const InputDecoration(
                              label: Text(tAnswer),
                              hintText: tAnswer,
                              prefixIcon: Icon(Icons.question_answer_outlined),
                            ),
                          ),
                          const SizedBox(height: 20,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Visibility(
                visible: show_finish,

                child: SizedBox(
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      IshiharaAssessmentController.instance.verifyAnswer(controller.answer.text.trim());
                      IshiharaAssessmentController.instance.submitAnswers();
                      Get.to(Dashboard());
                    },
                    child: Text("Finish Assessment"),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7), // <-- Radius
                      ),
                    ),
                  ),
                ),
              ),

              Visibility(
                  visible: show_finish,
                  child: SizedBox(height: 20,)),

              NumberPaginator(numberPages: numberOfPages, onPageChange:(index) {
                setState(() {
                  currentPage = index;
                  i = index;
                  j = index;
                  l = currentPage;

                  if (currentPage == 1) {
                    show_finish = true ;
                  }
                  else {
                    show_finish = false;
                  }

                  if (j > k) {
                    IshiharaAssessmentController.instance.verifyAnswer(controller.answer.text.trim());
                  }
                  if (j >= k) {
                    textFormFieldStatus = true;
                    k = j;
                  } else {
                    j = k;
                    textFormFieldStatus = false;
                  }

                });
              },)


            ],
          ),
        ),
      ),
    );
  }
}