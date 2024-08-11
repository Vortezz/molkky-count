import 'package:flutter/material.dart';
import 'package:molkkycount/colors/colors_name.dart';

class DarkColors {
  Map<ColorName, Color> darkColors = {
    ColorName.background: const Color(0xff181818),
    ColorName.text1: Colors.white,
    ColorName.text2: const Color(0xff464545),
    ColorName.button: const Color(0xFF517dff),
    ColorName.color2: const Color(0xffEC2C44),
    ColorName.color3: const Color(0xffFFB82B),
    ColorName.white: Colors.white,
    ColorName.black: Colors.black,
  };

  Color? getColorFromName(ColorName colorName) {
    return darkColors[colorName];
  }
}
