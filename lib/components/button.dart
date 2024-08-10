import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/text.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.client,
    this.isColored = true,
    this.isDisabled = false,
  }) : super(key: key);

  final Client client;
  final String text;
  final Function() onPressed;
  final bool isDisabled;
  final bool isColored;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      margin: const EdgeInsets.only(
        top: 10,
      ),
      height: 80,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isColored
              ? client.getColor(ColorName.button)
              : client.getColor(ColorName.text1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              10,
            ),
          ),
          disabledBackgroundColor: client.getColor(ColorName.text2),
        ),
        child: CustomText(
          client: client,
          text: text,
          textType: TextType.button,
          color: isColored ? ColorName.text1 : ColorName.background,
        ),
      ),
    );
  }
}
