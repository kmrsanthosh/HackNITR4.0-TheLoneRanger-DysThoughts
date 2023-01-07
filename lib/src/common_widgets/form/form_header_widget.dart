import 'package:flutter/material.dart';
import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../../constants/text_strings.dart';

class FormHeaderWidget extends StatelessWidget {
  const FormHeaderWidget({
    Key? key,
    this.imageColor,
    this.heightBetween,
    required this.image,
    required this.title,
    required this.subTitle,
    this.imageHeight = 0.2,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.textAlign,
  }) : super(key: key);

  final Color? imageColor;
  final double? imageHeight;
  final double? heightBetween;
  final String image, title, subTitle;
  final CrossAxisAlignment crossAxisAlignment;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image(
            image: AssetImage(
              image,
            ),
            color: imageColor,
            height: size.height * 0.21,
          ),
        ),
        SizedBox(height: heightBetween),
        Text(
          title,
          style: Theme.of(context).textTheme.headline1,
        ),
        Text(
          subTitle,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
