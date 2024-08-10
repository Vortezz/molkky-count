import 'package:flutter/material.dart';
import 'package:molkkycount/colors/colors_name.dart';

class LightColors {
  Map<ColorName, Color> lightColors = {
    ColorName.background: Colors.white,
    ColorName.text1: const Color(0xff292727),
    ColorName.text2: const Color(0xffDED1D1),
    ColorName.button: const Color(0xFF517dff),
    ColorName.color2: const Color(0xffEC2C44),
    ColorName.color3: const Color(0xffFFB82B),
  };

  Color? getColorFromName(ColorName colorName) {
    return lightColors[colorName];
  }
}
