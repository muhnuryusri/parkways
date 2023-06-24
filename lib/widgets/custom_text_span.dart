import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../color_constants.dart';

class CustomTextSpan extends StatelessWidget {
  final String firstText;
  final String secondText;
  final VoidCallback onTap;

  const CustomTextSpan(
      {super.key,
      required this.firstText,
      required this.secondText,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
              text: firstText,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Poppins',
                  color: ColorConstants.primaryFontColor)),
          TextSpan(
              text: secondText,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  color: ColorConstants.primaryFontColor),
              recognizer: TapGestureRecognizer()..onTap = onTap),
        ],
      ),
    );
  }
}
