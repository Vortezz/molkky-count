import 'dart:math';

import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/pages/game.dart';
import 'package:molkkycount/pages/home.dart';
import 'package:molkkycount/translations/translations_key.dart';

class SetupPlayersPage extends StatefulWidget {
  const SetupPlayersPage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<SetupPlayersPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<SetupPlayersPage> {
  late Client client;

  int players = 0;

  TextEditingController controller = TextEditingController();

  String playerName = "";

  @override
  void initState() {
    client = widget.client;
    players = client.game.players.length;
    client.game.players.clear();
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
                      TranslationKey.player,
                    ) +
                    " " +
                    min(client.game.players.length + 1, players).toString(),
                style: TextStyle(
                  color: client.getColor(
                    ColorName.text1,
                  ),
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              child: Text(
                client.getTranslation(
                  TranslationKey.chooseTeamName,
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: client.getColor(
                    ColorName.text1,
                  ),
                  fontSize: 19,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: TextField(
                style: TextStyle(
                  color: client.getColor(
                    ColorName.text1,
                  ),
                  fontSize: 16,
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
                      ColorName.text1,
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                onSubmitted: (value) {
                  setState(() {
                    playerName = value;
                  });
                },
                onChanged: (value) {
                  setState(() {
                    playerName = value;
                  });
                },
                controller: controller,
              ),
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
                  if (players > client.game.players.length) {
                    if (playerName == "") {
                      playerName = client.getTranslation(
                            TranslationKey.player,
                          ) +
                          " " +
                          min(client.game.players.length + 1, players)
                              .toString();
                    }
                    client.game.players.add(
                      Player(
                        playerName,
                      ),
                    );

                    if (players == client.game.players.length) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => GamePage(
                              client: client,
                            ),
                          ),
                          (route) => false);
                      return;
                    } else {
                      setState(() {
                        playerName = "";
                      });
                      controller.clear();
                    }
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => GamePage(
                            client: client,
                          ),
                        ),
                        (route) => false);
                  }
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
