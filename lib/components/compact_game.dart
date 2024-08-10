import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/translations/translations_key.dart';

class CompactGameComponent extends StatelessWidget {
  CompactGameComponent(
      {super.key,
      required this.client,
      required this.setPlayerPoints,
      required this.playerPoints});

  final Client client;
  final Function(int) setPlayerPoints;
  final int playerPoints;

  @override
  Widget build(BuildContext context) {
    TextEditingController controller =
        TextEditingController(text: playerPoints.toString());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: CustomText(
            client: client,
            translationKey: TranslationKey.enterScore,
            textType: TextType.text,
            color: ColorName.text1,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 10,
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: playerPoints > 0
                    ? () {
                        controller.text = (playerPoints - 1).toString();

                        setPlayerPoints(playerPoints - 1);
                      }
                    : null,
                icon: Icon(
                  Icons.remove,
                  color: playerPoints > 0
                      ? client.getColor(ColorName.text1)
                      : client.getColor(ColorName.text2),
                ),
              ),
              Container(
                width: 50,
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: client.getColor(
                      ColorName.text1,
                    ),
                    fontSize: 22,
                    fontWeight: FontWeight.w300,
                  ),
                  cursorColor: client.getColor(
                    ColorName.text1,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: client.getTranslation(
                      TranslationKey.chooseTeamName,
                    ),
                    hintStyle: TextStyle(
                      color: client.getColor(
                        ColorName.text2,
                      ),
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  onChanged: (value) {
                    // setState(() {
                    //   if (value != "") {
                    //     var points = int.parse(value);
                    //     if (points > 12) {
                    //       points = 12;
                    //       controller.text = points.toString();
                    //     } else if (points < 0) {
                    //       points = 0;
                    //       controller.text = points.toString();
                    //     }
                    //     playerPoints = points;
                    //   } else {
                    //     controller.text = "0";
                    //     playerPoints = 0;
                    //   }
                    // });
                  },
                  controller: controller,
                ),
              ),
              IconButton(
                onPressed: playerPoints < 12
                    ? () {
                        controller.text = (playerPoints + 1).toString();

                        setPlayerPoints(playerPoints + 1);
                      }
                    : null,
                icon: Icon(
                  Icons.add,
                  color: playerPoints < 12
                      ? client.getColor(ColorName.text1)
                      : client.getColor(ColorName.text2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
