import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';

enum TextType { button, title, subtitle, text, emphasis, bottomText }

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    this.text,
    this.color,
    this.textType,
    required this.client,
    this.textAlign = TextAlign.center,
  }) : super(key: key);

  final Client client;

  final String? text;
  final ColorName? color;
  final TextType? textType;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? "",
      textAlign: textAlign,
      style: TextStyle(
        fontWeight: getFontWeight(),
        fontSize: getFontSize(),
        color: client.getColor(color ?? ColorName.text1),
        fontFamily: "OpenSans",
      ),
    );
  }

  double getFontSize() {
    switch (textType ?? TextType.text) {
      case TextType.button:
        return 20;
      case TextType.title:
        return 36;
      case TextType.subtitle:
        return 24;
      case TextType.text:
        return 18;
      case TextType.emphasis:
        return 20;
      case TextType.bottomText:
        return 16;
    }
  }

  FontWeight getFontWeight() {
    switch (textType ?? TextType.text) {
      case TextType.button:
        return FontWeight.w800;
      case TextType.title:
        return FontWeight.w800;
      case TextType.subtitle:
        return FontWeight.w800;
      case TextType.text:
        return FontWeight.w300;
      case TextType.emphasis:
        return FontWeight.w800;
      case TextType.bottomText:
        return FontWeight.w600;
    }
  }
}
