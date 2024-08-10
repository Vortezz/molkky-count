import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/button.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/translations/translations_key.dart';

class DefaultLayout extends StatelessWidget {
  const DefaultLayout({
    Key? key,
    this.titleKey,
    this.title,
    required this.client,
    required this.buttonKey,
    required this.onPressed,
    this.topWidget,
    this.middleWidget,
    this.bottomTextKey,
    this.arrowRight,
    this.onBottomTextPressed,
    this.isButtonDisabled,
    this.titleColor = ColorName.text1,
  }) : super(key: key);

  final Client client;
  final TranslationKey? titleKey;
  final String? title;
  final Widget? topWidget;
  final Widget? middleWidget;
  final TranslationKey buttonKey;
  final Function() onPressed;
  final TranslationKey? bottomTextKey;
  final bool? arrowRight;
  final Function()? onBottomTextPressed;
  final bool? isButtonDisabled;
  final ColorName titleColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 256,
                  width: 256,
                  child: topWidget ??
                      Image.asset(
                        "assets/logo_1000.png",
                      ),
                  margin: const EdgeInsets.only(
                    bottom: 22,
                  ),
                ),
                SizedBox(
                  height: 48,
                  width: 256,
                  child: CustomText(
                    client: client,
                    translationKey: titleKey,
                    color: titleColor,
                    text: title,
                    textType: TextType.title,
                  ),
                ),
                Container(
                  height: 200,
                  width: 300,
                  margin: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: middleWidget,
                ),
                Button(
                  client: client,
                  text: client.getTranslation(buttonKey),
                  onPressed: onPressed,
                  isDisabled: isButtonDisabled,
                ),
                SizedBox(
                  height: 38,
                  child: bottomTextKey != null
                      ? TextButton(
                          onPressed: onBottomTextPressed,
                          child: CustomText(
                            client: client,
                            text: (arrowRight ?? true ? "" : "← ") +
                                client
                                    .getTranslation(bottomTextKey!)
                                    .toUpperCase() +
                                (arrowRight ?? false ? " →" : ""),
                            textType: TextType.bottomText,
                            color: ColorName.text2,
                          ),
                        )
                      : Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
