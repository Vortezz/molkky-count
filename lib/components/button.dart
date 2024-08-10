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
    this.isDisabled,
  }) : super(key: key);

  final Client client;
  final String text;
  final Function() onPressed;
  final bool? isDisabled;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 256,
      height: 56,
      child: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(256, 56),
            backgroundColor: isDisabled == null || !isDisabled!
                ? client.getColor(ColorName.button)
                : client.getColor(ColorName.text2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          onPressed: () {
            if (isDisabled == null || !isDisabled!) {
              onPressed();
            }
          },
          child: CustomText(
            client: client,
            text: text,
            textType: TextType.button,
          ),
        ),
      ),
    );
  }
}
