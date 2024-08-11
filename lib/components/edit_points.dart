import 'dart:math';

import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/compact_game.dart';
import 'package:molkkycount/components/text.dart';

class EditPoints extends StatefulWidget {
  const EditPoints({
    Key? key,
    required this.client,
    required this.currentPlayer,
    required this.validatePoints,
  }) : super(key: key);

  final Client client;
  final Player currentPlayer;
  final Function(List<int>, int) validatePoints;

  @override
  State<EditPoints> createState() {
    return _EditPointsState();
  }
}

class _EditPointsState extends State<EditPoints> {
  late Client client;
  late List<TextEditingController> controllers;
  late List<FocusNode> focusNodes;
  late Player currentPlayer;
  late int toDisplay;
  late List<int> pointsHistory;
  late Function(List<int>, int) validatePoints;

  @override
  void initState() {
    client = widget.client;
    currentPlayer = widget.currentPlayer;
    toDisplay = min(3, currentPlayer.pointsHistory.length);
    controllers = List.generate(
      toDisplay,
      (index) => TextEditingController(
        text: currentPlayer
            .pointsHistory[currentPlayer.pointsHistory.length - 1 - index]
            .toString(),
      ),
    );
    pointsHistory = List.from(currentPlayer.pointsHistory);
    focusNodes = List.generate(
      toDisplay,
      (index) => FocusNode(),
    );
    validatePoints = widget.validatePoints;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CustomText(
        client: client,
        text: client.translate(
          "game.edit.title",
        ),
        textType: TextType.subtitle,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            client: client,
            text: client.translate(
              "game.edit.content",
              Map.fromEntries(
                [
                  MapEntry(
                    "player",
                    currentPlayer.name,
                  ),
                ],
              ),
            ),
          ),
          if (toDisplay == 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    right: 16,
                  ),
                  child: Icon(
                    Icons.error_outline,
                    color: client.getColor(
                      ColorName.text1,
                    ),
                  ),
                ),
                CustomText(
                  text: client.translate("game.edit.nothing_to_display"),
                  client: client,
                  textType: TextType.text,
                  color: ColorName.text1,
                ),
              ],
            ),
          for (int i = 0; i < toDisplay; i++)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomText(
                  client: client,
                  text: client.translate(
                    "game.edit.round",
                    Map.fromEntries(
                      [
                        MapEntry(
                          "round",
                          (toDisplay - i).toString(),
                        ),
                      ],
                    ),
                  ),
                  textType: TextType.emphasis,
                ),
                CompactGameComponent(
                  client: client,
                  setPlayerPoints: (points, _bool) {
                    setState(() {
                      pointsHistory[
                          currentPlayer.pointsHistory.length - 1 - i] = points;
                    });
                  },
                  playerPoints:
                      pointsHistory[currentPlayer.pointsHistory.length - 1 - i],
                  isSmall: true,
                )
              ],
            ),
          if (currentPlayer.pointsHistory.length > 3)
            CustomText(
              text: client.translate("game.edit.rows_not_displayed"),
              client: client,
              textType: TextType.text,
              color: ColorName.text1,
            ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: CustomText(
            client: client,
            text: client.translate(
              "game.edit.cancel",
            ),
            textType: TextType.emphasis,
          ),
        ),
        TextButton(
          onPressed: () {
            validatePoints(pointsHistory, toDisplay);
            Navigator.pop(context, 'Save');
          },
          child: CustomText(
            client: client,
            text: client.translate(
              "game.edit.save",
            ),
            color: ColorName.color2,
            textType: TextType.emphasis,
          ),
        ),
      ],
    );
  }
}