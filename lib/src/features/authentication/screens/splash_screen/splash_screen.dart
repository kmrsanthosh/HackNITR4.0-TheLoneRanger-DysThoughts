import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:software_engg_project/src/common_widgets/fade_in_animation/fade_in_animation_model.dart';
import 'package:software_engg_project/src/constants/colors.dart';
import 'package:software_engg_project/src/constants/image_strings.dart';
import 'package:software_engg_project/src/constants/sizes.dart';
import 'package:software_engg_project/src/constants/text_strings.dart';
import 'package:software_engg_project/src/common_widgets/fade_in_animation/fade_in_animation_controller.dart';

import '';
import '../../../../common_widgets/fade_in_animation/animation_design.dart';

class SplashScreen extends StatelessWidget{
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FadeInAnimationController());
    controller.startSplashAnimation();

    return Scaffold(
      body: Stack(
        children: [
          TFadeInAnimation(
            durationInMs: 1600,
            animate: TAnimatePosition(
              topAfter: 0, topBefore: -30, leftBefore: -30, leftAfter: 0,
            ),
            child: const Image(image: AssetImage(tSplashTopIcon), height: 88, ),
          ),

        TFadeInAnimation(
          durationInMs: 2000,
            animate: TAnimatePosition(topBefore: 0, topAfter: 220, rightAfter: -22, rightBefore: 0),
              child: Image(image: AssetImage(tSplashImage), height: 450,),
              ),

          TFadeInAnimation(
        durationInMs: 2400,
        animate: TAnimatePosition(topBefore: 0, topAfter: 80, leftBefore: 0, leftAfter: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(tAppName, style: Theme.of(context).textTheme.headline3),
                Text(tAppTagLine, style: Theme.of(context).textTheme.headline2),
              ],
            ),
          ),

      TFadeInAnimation(
        durationInMs: 2400,
        animate: TAnimatePosition(bottomBefore: 0, bottomAfter: 40, rightAfter: tDefaultSize, rightBefore: tDefaultSize),
        child: Container(
              width: tSplashContainerSize,
              height: tSplashContainerSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: tPrimaryColor,
                  ),
                ),
          ),
    ],
    ),
            );
  }


}

