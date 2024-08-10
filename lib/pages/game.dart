import 'dart:math';

import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/button.dart';
import 'package:molkkycount/components/compact_game.dart';
import 'package:molkkycount/components/cosy_game.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/enums/three_fail_action.dart';
import 'package:molkkycount/pages/end.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late Client client;

  late Player currentPlayer;
  int playerPoints = 0;

  late bool firstPlayOfTheGame;

  List<int> selectedPins = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    client = widget.client;
    currentPlayer = client.game.players.removeFirst();
    controller.text = "0";
    client.on("reloadState", (state) {
      setState(() {});
    });
    firstPlayOfTheGame = true;
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              client: client,
              color: currentPlayer.failedAttemps == 1 &&
                      client.game.gameSettings.whenThreeFailInRow !=
                          ThreeFailAction.nothing
                  ? ColorName.color3
                  : currentPlayer.failedAttemps == 2 &&
                          client.game.gameSettings.whenThreeFailInRow !=
                              ThreeFailAction.nothing
                      ? ColorName.color2
                      : ColorName.text1,
              text: currentPlayer.name,
              textType: TextType.title,
            ),
            client.game.gameSettings.cosyType
                ? CosyGameComponent(
                    client: client,
                    selectedPins: selectedPins,
                  )
                : CompactGameComponent(
                    client: client,
                    setPlayerPoints: (points) {
                      print("Points: $points");

                      setState(() {
                        playerPoints = points;

                        print("Player points: $playerPoints");
                      });
                    },
                    playerPoints: playerPoints,
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
                          45 +
                      50,
                  MediaQuery.of(context).size.height * 0.4),
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: client.game.players.length +
                    1 +
                    client.game.eliminatedPlayers.length,
                itemBuilder: (context, index) {
                  List<Player> players = client.game.players.toList();
                  players.add(currentPlayer);
                  players
                      .sort((a, b) => b.currentScore.compareTo(a.currentScore));
                  List<Player> eliminatedPlayers =
                      client.game.eliminatedPlayers.toList();
                  eliminatedPlayers
                      .sort((a, b) => b.currentScore.compareTo(a.currentScore));
                  players.addAll(eliminatedPlayers);

                  Player player = players[index];

                  return Container(
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
                            // Failed attempts icon(s)
                            Container(
                              margin: const EdgeInsets.only(
                                left: 10,
                              ),
                              child: Row(
                                children: player.eliminated
                                    ? []
                                    : List.generate(
                                        player.failedAttemps,
                                        (index) => const Icon(
                                          Icons.dangerous,
                                          color: Colors.red,
                                          size: 20,
                                        ),
                                      ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              player.currentScore.toString(),
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
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              onPressed: player.eliminated
                                  ? null
                                  : () {
                                      // TODO: Implement edit player score
                                    },
                              icon: Icon(
                                Icons.edit,
                                color: player.eliminated
                                    ? client.getColor(
                                        ColorName.text2,
                                      )
                                    : client.getColor(
                                        ColorName.text1,
                                      ),
                              ),
                            ),
                          ],
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
                text: client.translate("game.next"),
                onPressed: () {
                  setState(() {
                    resolvePlayerPoints(currentPlayer);
                  });
                },
                client: client,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void resolvePlayerPoints(Player player) {
    if (client.game.gameSettings.cosyType) {
      resolveCosyType(player);
      resolvePlay(player);
    } else {
      resolvePlay(player);
    }

    firstPlayOfTheGame = false;
  }

  void resolvePlay(Player player) {
    int currentScore = player.currentScore;

    if (currentScore + playerPoints == 50) {
      currentScore = 50;
      player.hasWin = true;
      player.failedAttemps = 0;
      player.currentScore = currentScore;
      player.pointsHistory.add(currentScore);
      client.game.players.add(player);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => EndPage(
              client: client,
            ),
          ),
          (route) => false);
      return;
    } else if (currentScore + playerPoints > 50) {
      currentScore = 25;
      player.failedAttemps = 0;
    } else if (playerPoints != 0) {
      currentScore += playerPoints;
      player.failedAttemps = 0;
    } else {
      player.failedAttemps++;
      if (player.failedAttemps == 3 &&
          client.game.gameSettings.whenThreeFailInRow !=
              ThreeFailAction.nothing) {
        if (client.game.gameSettings.whenThreeFailInRow ==
            ThreeFailAction.resetPoints) {
          player.failedAttemps = 0;

          currentScore = 0;
          playerPoints = 0;
        } else {
          player.pointsHistory.add(currentScore);
          player.eliminated = true;
          client.game.eliminatedPlayers.add(player);

          currentPlayer = client.game.players.removeFirst();
          controller.text = "0";
          playerPoints = 0;

          if (client.game.players.isEmpty) {
            client.game.players.add(currentPlayer);
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => EndPage(
                    client: client,
                  ),
                ),
                (route) => false);
            return;
          }

          return;
        }
      }
    }

    player.currentScore = currentScore;
    player.pointsHistory.add(currentScore);
    client.game.players.add(player);

    currentPlayer = client.game.players.removeFirst();
    controller.text = "0";
    playerPoints = 0;
  }

  void resolveCosyType(Player player) {
    int sum = 0;
    for (int element in selectedPins) {
      sum += element;
    }

    if (sum == 1) {
      playerPoints = selectedPins.indexOf(1) + 1;
    } else if (sum > 1) {
      playerPoints = sum;
    }

    print(selectedPins);

    setState(() {
      selectedPins = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    });
  }
}
