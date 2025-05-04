import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vortezz_base/components/button.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/games_history.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/pages/home.dart';

import '../class/player.dart';

class EndPage extends StatefulWidget {
  const EndPage({Key? key, required this.client}) : super(key: key);

  final MolkkyClient client;

  @override
  State<EndPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EndPage> {
  late MolkkyClient client;

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                client.translate("end.title"),
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
                top: 20,
                bottom: 20,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: min(
                  (client.game.players.length +
                          client.game.eliminatedPlayers.length) *
                      45,
                  MediaQuery.of(context).size.height * 0.5),
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: client.game.players.length +
                    client.game.eliminatedPlayers.length,
                itemBuilder: (context, index) {
                  List<Player> players = client.game.players.toList();
                  players
                      .sort((a, b) => b.currentScore.compareTo(a.currentScore));
                  List<Player> eliminatedPlayers =
                      client.game.eliminatedPlayers.toList();
                  eliminatedPlayers
                      .sort((a, b) => b.currentScore.compareTo(a.currentScore));
                  players.addAll(eliminatedPlayers);

                  Player player = players[index];

                  return Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "${index + 1}.",
                              style: TextStyle(
                                color: index == 0
                                    ? Colors.yellow
                                    : index == 1
                                        ? Colors.grey
                                        : index == 2
                                            ? Colors.brown
                                            : client.getColor(
                                                ColorName.text1,
                                              ),
                                fontSize: 23,
                                fontWeight: index < 3
                                    ? FontWeight.w800
                                    : FontWeight.w300,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              player.name,
                              style: TextStyle(
                                color: client.getColor(
                                  ColorName.text1,
                                ),
                                decoration: client.game.eliminatedPlayers
                                        .contains(player)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                decorationColor: client.getColor(
                                  ColorName.text1,
                                ),
                                decorationThickness: 4.0,
                                fontSize: 23,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          player.currentScore.toString(),
                          style: TextStyle(
                            color: client.getColor(
                              ColorName.text1,
                            ),
                            decoration:
                                client.game.eliminatedPlayers.contains(player)
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                            decorationColor: client.getColor(
                              ColorName.text1,
                            ),
                            decorationThickness: 4.0,
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
            Container(
              margin: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Button(
                text: client.translate("end.home"),
                isBlack: !client.darkTheme,
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
                client: client,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
