import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/games_history.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/pages/home.dart';
import 'package:molkkycount/translations/translations_key.dart';

import '../class/player.dart';

class EndPage extends StatefulWidget {
  const EndPage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<EndPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EndPage> {
  late Client client;

  @override
  void initState() {
    client = widget.client;
    super.initState();

    client.cancelSubscribes();

    List<Player> players = client.game.players.toList();
    players.sort((a, b) => b.currentScore.compareTo(a.currentScore));

    Map<String, int> scores = {};

    for (var player in players) {
      scores[player.name] = player.currentScore;
    }

    List<Player> eliminatedPlayers = client.game.eliminatedPlayers;
    players.sort((a, b) => b.currentScore.compareTo(a.currentScore));

    Map<String, int> eliminatedScores = {};

    for (var player in eliminatedPlayers) {
      eliminatedScores[player.name] = player.currentScore;
    }

    client.getHistory().addGame(
          GameHistory(
            scores,
            eliminatedScores,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: client.getColor(
        ColorName.background,
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
                  TranslationKey.gameEnded,
                ),
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
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView.builder(
                itemExtent: 27,
                shrinkWrap: true,
                itemCount: client.game.players.length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  List<Player> players = client.game.players.toList();
                  players
                      .sort((a, b) => b.currentScore.compareTo(a.currentScore));

                  return Container(
                    margin: const EdgeInsets.only(
                      top: 2.5,
                      bottom: 2.5,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            index == 0
                                ? Container(
                                    margin: const EdgeInsets.only(
                                      right: 10,
                                    ),
                                    child: const Icon(
                                      Icons.workspace_premium,
                                      color: Colors.yellow,
                                    ),
                                  )
                                : index == 1
                                    ? Container(
                                        margin: const EdgeInsets.only(
                                          right: 10,
                                        ),
                                        child: const Icon(
                                          Icons.workspace_premium,
                                          color: Colors.grey,
                                        ),
                                      )
                                    : index == 2
                                        ? Container(
                                            margin: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: const Icon(
                                              Icons.workspace_premium,
                                              color: Color(0xFFcd7f32),
                                            ),
                                          )
                                        : Container(),
                            Text(
                              players[index].name,
                              style: TextStyle(
                                color: client.getColor(
                                  ColorName.text1,
                                ),
                                fontSize: 23,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          players[index].currentScore.toString(),
                          style: TextStyle(
                            color: client.getColor(
                              ColorName.text1,
                            ),
                            fontSize: 23,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            client.game.eliminatedPlayers.isNotEmpty
                ? Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.only(
                          top: 30,
                        ),
                        child: Text(
                          client
                              .getTranslation(TranslationKey.eliminatedPlayers),
                          style: TextStyle(
                            color: client.getColor(
                              ColorName.color2,
                            ),
                            fontSize: 23,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ListView.builder(
                          itemExtent: 27,
                          shrinkWrap: true,
                          itemCount: client.game.eliminatedPlayers.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            List<Player> players =
                                client.game.eliminatedPlayers;
                            players.sort((a, b) =>
                                b.currentScore.compareTo(a.currentScore));

                            return Container(
                              margin: const EdgeInsets.only(
                                top: 2.5,
                                bottom: 2.5,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    players[index].name,
                                    style: TextStyle(
                                      color: client.getColor(
                                        ColorName.color2,
                                      ),
                                      fontSize: 23,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  Text(
                                    players[index].currentScore.toString(),
                                    style: TextStyle(
                                      color: client.getColor(
                                        ColorName.color2,
                                      ),
                                      fontSize: 23,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Container(),
            Container(
              margin: const EdgeInsets.only(
                top: 40,
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
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => HomePage(
                          client: client,
                        ),
                      ),
                      (route) => false);
                },
                child: Text(
                  client.getTranslation(
                    TranslationKey.goToHome,
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
