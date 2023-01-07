import 'package:flutter/material.dart';
import 'package:software_engg_project/src/constants/sizes.dart';

import '../../models/model_on_boarding.dart';

class OnBoardingPageWidget extends StatelessWidget {
  const OnBoardingPageWidget({
    Key? key,
    required this.model,
  }) : super(key: key);

  final OnBoardingModel model;

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(tDefaultSize),
      color: model.bgColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(model.image), height: size.height * 0.40,),
          Column(
            children: [
              Text(model.title, style: Theme.of(context).textTheme.headline5),
              Text(model.subTitle, textAlign: TextAlign.center,),
            ],
          ),
          Text(model.counterText, style: Theme.of(context).textTheme.subtitle1, ),
          SizedBox(height: 40.0,)
        ],
      ),
    );
  }
}