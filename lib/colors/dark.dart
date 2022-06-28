import 'package:flutter/material.dart';
import 'package:molkkycount/colors/colors_name.dart';

class DarkColors {
  Map<ColorName, Color> darkColors = {
    ColorName.background: const Color(0xff292727),
    ColorName.text1: Colors.white,
    ColorName.text2: const Color(0xff464545),
    ColorName.color1: const Color(0xff8B5CF6),
    ColorName.color2: const Color(0xffEC2C44),
    ColorName.color3: const Color(0xffFFB82B),
  };

  Color? getColorFromName(ColorName colorName) {
    return darkColors[colorName];
  }
}
