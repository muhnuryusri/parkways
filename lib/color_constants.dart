import 'dart:ui';
import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color mainColor = hexToColor('#24617E');
  static Color primaryFontColor = hexToColor('#1F1F1F');
  static Color secondaryFontColor = hexToColor('#828282');
  static Color containerColor = hexToColor('#F6F6F6');
  static Color strokeColor = hexToColor('#D1D1D6');
}
