import 'package:flutter/material.dart';
import 'package:parkways/color_constants.dart';

class CustomTextField extends StatelessWidget {
  final String titleText;
  final String hintText;
  final IconData icon;
  final bool isPassword;
  final Function(String) onChanged;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.isPassword,
    required this.titleText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titleText,
          style: TextStyle(
              fontSize: 12,
              color: ColorConstants.primaryFontColor,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 7),
        TextField(
          style:
              TextStyle(fontSize: 13, color: ColorConstants.primaryFontColor),
          obscureText: isPassword,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(fontSize: 12, color: Colors.grey),
            prefixIcon: Icon(
              icon,
            ),
            prefixIconColor: ColorConstants.strokeColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstants.strokeColor, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: ColorConstants.mainColor, width: 2.0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
          onChanged: onChanged,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
