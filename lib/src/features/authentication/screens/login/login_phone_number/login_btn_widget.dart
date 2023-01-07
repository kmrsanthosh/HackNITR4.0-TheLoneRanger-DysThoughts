import 'package:flutter/material.dart';

class LoginBtnWidget extends StatelessWidget {
  const LoginBtnWidget({
    required this.btnIcon,
    required this.title,
    required this.subTitle,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final IconData btnIcon;
  final String title, subTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {

    var brightness = MediaQuery.of(context).platformBrightness;
    final isDarkMode = brightness == Brightness.dark;

    return GestureDetector(
        onTap: onTap,

          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: isDarkMode ? Colors.grey.shade600 : Colors.grey.shade200,
            ),
              child: Row(
                children: [
                  Icon(btnIcon, size: 60,),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: Theme.of(context).textTheme.headline6, softWrap: true,),
                      Text(subTitle, style: Theme.of(context).textTheme.bodyText2, softWrap: true),
                    ],
                  )
                ],
              ),
          ),
      );
  }
}
