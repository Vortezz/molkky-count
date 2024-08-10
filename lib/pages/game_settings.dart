import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/game.dart';
import 'package:molkkycount/class/game_settings.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/default_layout.dart';
import 'package:molkkycount/components/dropdown.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/enums/three_fail_action.dart';
import 'package:molkkycount/pages/game.dart';
import 'package:molkkycount/pages/home.dart';

import '../translations/translations_key.dart';

class GameSettingsPage extends StatefulWidget {
  const GameSettingsPage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<GameSettingsPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<GameSettingsPage> {
  late Client client;

  List<String> players = [];
  ThreeFailAction eliminateAfterThreeFails = ThreeFailAction.eliminate;
  bool cosyType = false;

  String playersValue = "";

  int currentState = 0;

  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController();

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
      resizeToAvoidBottomInset: false,
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
      body: /* Center(
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
                    TranslationKey.type,
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
                  onPressed: cosyType
                      ? () {
                          setState(() {
                            cosyType = false;
                          });
                        }
                      : null,
                  icon: Icon(
                    Icons.arrow_back,
                    color: cosyType
                        ? client.getColor(ColorName.text1)
                        : client.getColor(ColorName.text2),
                  ),
                ),
                Text(
                  cosyType
                      ? client.getTranslation(
                          TranslationKey.cosyType,
                        )
                      : client.getTranslation(
                          TranslationKey.compactType,
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
                  onPressed: !cosyType
                      ? () {
                          setState(() {
                            cosyType = true;
                          });
                        }
                      : null,
                  icon: Icon(
                    Icons.arrow_forward,
                    color: !cosyType
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
                  backgroundColor: client.getColor(ColorName.button),
                  elevation: 0,
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  GameSettings gameSettings = GameSettings();
                  gameSettings.whenThreeFailInRow = eliminateAfterThreeFails;
                  gameSettings.cosyType = cosyType;
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
      ), */
          DefaultLayout(
        client: client,
        titleKey: currentState == 0
            ? TranslationKey.players
            : currentState == 1
                ? TranslationKey.afterThreeFails
                : TranslationKey.type,
        buttonKey: TranslationKey.next,
        topWidget: currentState == 0
            ? null
            : currentState == 1
                ? null
                : null,
        middleWidget: currentState == 0
            ? ListView.builder(
                itemCount: players.length + 1,
                controller: _scrollController,
                itemBuilder: (context, index) {
                  print(index);
                  if (index == 0) {
                    // Add player
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            width: 200,
                            child: TextFormField(
                              onChanged: (value) {
                                playersValue = value;
                              },
                              style: TextStyle(
                                color: client.getColor(ColorName.text1),
                              ),
                              decoration: InputDecoration(
                                hintText: "Player name",
                                hintStyle: TextStyle(
                                  color: client.getColor(ColorName.text2),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        client.getColor(ColorName.background) ??
                                            Colors.white,
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: client.getColor(ColorName.text1) ??
                                        Colors.white,
                                  ),
                                ),
                              ),
                            )),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              if (playersValue.isEmpty) return;

                              players.add(playersValue);
                              playersValue = "";

                              print(players);
                              _scrollController.animateTo(
                                _scrollController.position.maxScrollExtent +
                                    36.0,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeOut,
                              );
                            });
                          },
                          icon: Icon(
                            Icons.add,
                            color: client.getColor(ColorName.text1),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Container(
                      height: 36,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                              client: client,
                              text: players[players.length - index],
                              textType: TextType.emphasis),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                players.removeAt(players.length - index);
                              });
                            },
                            icon: Icon(
                              Icons.remove,
                              color: client.getColor(ColorName.text1),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              )
            : currentState == 1
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        client: client,
                        translationKey:
                            TranslationKey.afterThreeFailsExplanation,
                      ),
                      Dropdown(
                        key: UniqueKey(),
                        client: client,
                        value: eliminateAfterThreeFails.value.toString(),
                        children: [
                          DropdownChildren(
                            id: "0",
                            component: Center(
                              child: CustomText(
                                client: client,
                                textType: TextType.button,
                                translationKey:
                                    TranslationKey.afterThreeFailsNone,
                              ),
                            ),
                          ),
                          DropdownChildren(
                            id: "1",
                            component: Center(
                              child: CustomText(
                                client: client,
                                textType: TextType.button,
                                translationKey:
                                    TranslationKey.afterThreeFailsEliminate,
                              ),
                            ),
                          ),
                          DropdownChildren(
                            id: "2",
                            component: Center(
                              child: CustomText(
                                client: client,
                                textType: TextType.button,
                                translationKey:
                                    TranslationKey.afterThreeFailsResetPoints,
                              ),
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          setState(() {
                            eliminateAfterThreeFails =
                                ThreeFailAction.values[int.parse(value!)];
                          });
                        },
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        client: client,
                        translationKey: TranslationKey.typeExplanation,
                      ),
                      Dropdown(
                        key: UniqueKey(),
                        client: client,
                        value: cosyType ? "0" : "1",
                        children: [
                          DropdownChildren(
                            id: "0",
                            component: Center(
                              child: CustomText(
                                client: client,
                                textType: TextType.button,
                                translationKey: TranslationKey.cosyType,
                              ),
                            ),
                          ),
                          DropdownChildren(
                            id: "1",
                            component: Center(
                              child: CustomText(
                                client: client,
                                textType: TextType.button,
                                translationKey: TranslationKey.compactType,
                              ),
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          setState(() {
                            cosyType = value == "0";
                          });
                        },
                      )
                    ],
                  ),
        onPressed: () {
          if (currentState == 2) {
            client.game = Game(
              gameSettings: GameSettings(
                whenThreeFailInRow: eliminateAfterThreeFails,
                cosyType: cosyType,
              ),
            );

            client.game.players =
                Queue.of(players.map((e) => Player(name: e)).toList());

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => GamePage(
                  client: client,
                ),
              ),
              (route) => false,
            );
          } else {
            setState(() {
              currentState++;
            });
          }
        },
        bottomTextKey:
            currentState == 0 ? TranslationKey.skip : TranslationKey.back,
        isButtonDisabled: currentState == 0 ? players.length < 2 : false,
        onBottomTextPressed: () {
          if (currentState == 0) {
            client.game = Game(
              gameSettings: GameSettings(),
            );

            client.game.players =
                Queue.of(players.map((e) => Player(name: e)).toList());

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => GamePage(
                  client: client,
                ),
              ),
              (route) => false,
            );
          } else {
            setState(() {
              currentState--;
            });
          }
        },
      ),
    );
  }
}
