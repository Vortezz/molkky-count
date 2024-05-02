import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/game.dart';
import 'package:molkkycount/class/game_settings.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/enums/three_fail_action.dart';
import 'package:molkkycount/pages/home.dart';
import 'package:molkkycount/pages/setup_players.dart';

import '../translations/translations_key.dart';

class GameSettingsPage extends StatefulWidget {
  const GameSettingsPage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<GameSettingsPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GameSettingsPage> {
  late Client client;

  int players = 2;
  ThreeFailAction eliminateAfterThreeFails = ThreeFailAction.eliminate;
  bool cosyMode = false;

  @override
  void initState() {
    client = widget.client;
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
        elevation: 0,
        iconTheme: IconThemeData(
          color: client.getColor(
            ColorName.text1,
          ),
        ),
        title: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => HomePage(
                  client: client,
                ),
              ),
              (route) => false,
            );
          },
          icon: const Icon(
            Icons.arrow_back,
          ),
          splashRadius: 20,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                client.getTranslation(
                  TranslationKey.gameSettings,
                ),
                style: TextStyle(
                  color: client.getColor(
                    ColorName.text1,
                  ),
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  client.getTranslation(
                    TranslationKey.players,
                  ),
                  style: TextStyle(
                    color: client.getColor(
                      ColorName.text1,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                IconButton(
                  onPressed: players > 2
                      ? () {
                          setState(() {
                            players--;
                          });
                        }
                      : null,
                  icon: Icon(
                    Icons.remove,
                    color: players > 2
                        ? client.getColor(ColorName.text1)
                        : client.getColor(ColorName.text2),
                  ),
                ),
                Text(
                  players.toString(),
                  style: TextStyle(
                    color: client.getColor(
                      ColorName.text1,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                IconButton(
                  onPressed: players < 12
                      ? () {
                          setState(() {
                            players++;
                          });
                        }
                      : null,
                  icon: Icon(
                    Icons.add,
                    color: players < 12
                        ? client.getColor(ColorName.text1)
                        : client.getColor(ColorName.text2),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  client.getTranslation(
                    TranslationKey.afterThreeFails,
                  ),
                  style: TextStyle(
                    color: client.getColor(
                      ColorName.text1,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                IconButton(
                  onPressed: eliminateAfterThreeFails.value != 0
                      ? () {
                          setState(() {
                            eliminateAfterThreeFails =
                                ThreeFailAction.getPrevious(
                                      eliminateAfterThreeFails,
                                    ) ??
                                    ThreeFailAction.nothing;
                          });
                        }
                      : null,
                  icon: Icon(
                    Icons.arrow_back,
                    color: eliminateAfterThreeFails.value != 0
                        ? client.getColor(ColorName.text1)
                        : client.getColor(ColorName.text2),
                  ),
                ),
                Text(
                  eliminateAfterThreeFails.value == 0
                      ? client.getTranslation(
                          TranslationKey.afterThreeFailsNone,
                        )
                      : eliminateAfterThreeFails.value == 1
                          ? client.getTranslation(
                              TranslationKey.afterThreeFailsEliminate,
                            )
                          : client.getTranslation(
                              TranslationKey.afterThreeFailsResetPoints,
                            ),
                  style: TextStyle(
                    color: client.getColor(
                      ColorName.text1,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                IconButton(
                  onPressed: eliminateAfterThreeFails.value != 2
                      ? () {
                          setState(() {
                            eliminateAfterThreeFails = ThreeFailAction.getNext(
                                  eliminateAfterThreeFails,
                                ) ??
                                ThreeFailAction.nothing;
                          });
                        }
                      : null,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: eliminateAfterThreeFails.value != 2
                        ? client.getColor(ColorName.text1)
                        : client.getColor(ColorName.text2),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  client.getTranslation(
                    TranslationKey.mode,
                  ),
                  style: TextStyle(
                    color: client.getColor(
                      ColorName.text1,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                IconButton(
                  onPressed: cosyMode
                      ? () {
                          setState(() {
                            cosyMode = false;
                          });
                        }
                      : null,
                  icon: Icon(
                    Icons.arrow_back,
                    color: cosyMode
                        ? client.getColor(ColorName.text1)
                        : client.getColor(ColorName.text2),
                  ),
                ),
                Text(
                  cosyMode
                      ? client.getTranslation(
                          TranslationKey.cosyMode,
                        )
                      : client.getTranslation(
                          TranslationKey.compactMode,
                        ),
                  style: TextStyle(
                    color: client.getColor(
                      ColorName.text1,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                IconButton(
                  onPressed: !cosyMode
                      ? () {
                          setState(() {
                            cosyMode = true;
                          });
                        }
                      : null,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: !cosyMode
                        ? client.getColor(ColorName.text1)
                        : client.getColor(ColorName.text2),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: client.getColor(ColorName.color1),
                  elevation: 0,
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  GameSettings gameSettings = GameSettings();
                  gameSettings.whenThreeFailInRow = eliminateAfterThreeFails;
                  gameSettings.cosyMode = cosyMode;
                  client.game = Game(
                    gameSettings,
                  );
                  client.game.players.addAll(List.filled(players, Player("")));
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => SetupPlayersPage(
                        client: client,
                      ),
                    ),
                    (route) => false,
                  );
                },
                child: Text(
                  client.getTranslation(
                    TranslationKey.next,
                  ),
                  style: TextStyle(
                    color: client.getColor(
                      ColorName.text1,
                    ),
                    fontSize: 23,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
