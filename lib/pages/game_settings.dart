import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/game.dart';
import 'package:molkkycount/class/game_settings.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/button.dart';
import 'package:molkkycount/components/icon_picker.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/enums/three_fail_action.dart';
import 'package:molkkycount/pages/game.dart';

class GameSettingsPage extends StatefulWidget {
  const GameSettingsPage(
      {super.key, required this.client, required this.players});

  final Client client;
  final List<Player> players;

  @override
  State<GameSettingsPage> createState() => _GameSettingsPageState();
}

class _GameSettingsPageState extends State<GameSettingsPage> {
  late Client client;
  late List<Player> players;

  ThreeFailAction threeFailAction = ThreeFailAction.nothing;
  bool isCosy = false;

  @override
  void initState() {
    client = widget.client;
    players = widget.players;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: client.getColor(
        ColorName.background,
      ),
      appBar: AppBar(
        backgroundColor: client.getColor(
          ColorName.background,
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                text: client.translate("game_settings.title"),
                client: client,
                textType: TextType.title,
                color: ColorName.text1,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Container(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: client.translate("game_settings.three_fails"),
                          client: client,
                          textType: TextType.emphasis,
                          color: ColorName.text1,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: client.translate(
                              "game_settings.three_fails.description"),
                          client: client,
                          textType: TextType.text,
                          color: ColorName.text1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    IconPicker(
                      client: client,
                      data: [
                        IconPickerData(
                            icon: ThreeFailAction.nothing.icon,
                            text: client.translate("three_fails.nothing")),
                        IconPickerData(
                            icon: ThreeFailAction.eliminate.icon,
                            text: client.translate("three_fails.eliminate")),
                        IconPickerData(
                            icon: ThreeFailAction.resetPoints.icon,
                            text: client.translate("three_fails.reset_points")),
                      ],
                      onPressed: (index) {
                        setState(() {
                          threeFailAction = ThreeFailAction.values[index];
                        });
                      },
                      value: threeFailAction.index,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: client.translate("game_settings.game_mode"),
                          client: client,
                          textType: TextType.emphasis,
                          color: ColorName.text1,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: client
                              .translate("game_settings.game_mode.description"),
                          client: client,
                          textType: TextType.text,
                          color: ColorName.text1,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    IconPicker(
                      client: client,
                      data: [
                        IconPickerData(
                            icon: "🛋️",
                            text: client.translate("game_mode.cosy")),
                        IconPickerData(
                            icon: "📝",
                            text: client.translate("game_mode.compact")),
                      ],
                      onPressed: (index) {
                        setState(() {
                          isCosy = index == 0;
                        });
                      },
                      value: isCosy ? 0 : 1,
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Button(
                  client: client,
                  text: client.translate("game_settings.start_game"),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    client.game = Game(
                      gameSettings: GameSettings(
                        whenThreeFailInRow: threeFailAction,
                        cosyType: isCosy,
                      ),
                    );

                    client.game.players = Queue<Player>.from(players);

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GamePage(
                          client: client,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
