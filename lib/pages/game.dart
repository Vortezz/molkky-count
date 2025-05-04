import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_vortezz_base/components/button.dart';
import 'package:flutter_vortezz_base/components/text.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/compact_game.dart';
import 'package:molkkycount/components/cosy_game.dart';
import 'package:molkkycount/components/edit_points.dart';
import 'package:molkkycount/enums/three_fail_action.dart';
import 'package:molkkycount/pages/end.dart';
import 'package:molkkycount/pages/home.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key, required this.client}) : super(key: key);

  final MolkkyClient client;

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late MolkkyClient client;

  late Player currentPlayer;
  int playerPoints = 0;

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
        leading: IconButton(
          color: client.getColor(
            ColorName.text1,
          ),
          onPressed: () {
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: CustomText(
                  client: client,
                  text: client.translate(
                    "game.quit.title",
                  ),
                  textType: TextType.subtitle,
                  color: client.getColor(ColorName.black),
                ),
                content: CustomText(
                  client: client,
                  text: client.translate(
                    "game.quit.content",
                  ),
                  color: client.getColor(ColorName.black),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.pop(context, 'Cancel'),
                    child: CustomText(
                      client: client,
                      text: client.translate(
                        "game.quit.cancel",
                      ),
                      color: client.getColor(ColorName.black),
                      textType: TextType.emphasis,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => HomePage(
                            client: client,
                          ),
                        ),
                        (Route<dynamic> route) => false,
                      );
                    },
                    child: CustomText(
                      client: client,
                      text: client.translate(
                        "game.quit.leave",
                      ),
                      color: client.getColor(ColorName.color2),
                      textType: TextType.emphasis,
                    ),
                  ),
                ],
              ),
            );
          },
          icon: const Icon(
            Icons.close,
          ),
        ),
        iconTheme: IconThemeData(
          color: client.getColor(
            ColorName.text1,
          ),
        ),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              client: client,
              color: client.getColor(currentPlayer.failedAttemps == 1 &&
                      client.game.gameSettings.whenThreeFailInRow !=
                          ThreeFailAction.nothing
                  ? ColorName.color3
                  : currentPlayer.failedAttemps == 2 &&
                          client.game.gameSettings.whenThreeFailInRow !=
                              ThreeFailAction.nothing
                      ? ColorName.color2
                      : ColorName.text1),
              text: currentPlayer.teamStatus.icon + " " + currentPlayer.name,
              textType: TextType.title,
            ),
            client.game.gameSettings.cosyType
                ? CosyGameComponent(
                    client: client,
                    selectedPins: selectedPins,
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: CustomText(
                          client: client,
                          text: client.translate("game.enter_score"),
                          textType: TextType.text,
                          color: client.getColor(ColorName.text1),
                        ),
                      ),
                      CompactGameComponent(
                        client: client,
                        setPlayerPoints: (points, next) {
                          setState(() {
                            playerPoints = points;

                            if (next) {
                              resolvePlayerPoints(currentPlayer);
                            }
                          });
                        },
                        playerPoints: playerPoints,
                      ),
                    ],
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
                                      showDialog<String>(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            EditPoints(
                                          client: client,
                                          currentPlayer: player,
                                          validatePoints:
                                              (pointsHistory, changedRows) {
                                            for (int i = changedRows;
                                                i > 0;
                                                i--) {
                                              player.currentScore -= player
                                                      .pointsHistory[
                                                  player.pointsHistory.length -
                                                      i];

                                              if (player.currentScore < 0) {
                                                player.currentScore = 0;
                                              }
                                            }

                                            player.pointsHistory.removeRange(
                                                player.pointsHistory.length -
                                                    changedRows,
                                                player.pointsHistory.length);

                                            for (int i = changedRows;
                                                i > 0;
                                                i--) {
                                              bool isGameFinished =
                                                  resolvePoints(
                                                      player,
                                                      pointsHistory[
                                                          pointsHistory.length -
                                                              i]);

                                              if (isGameFinished) {
                                                client.game.players
                                                    .add(currentPlayer);
                                                Navigator.pushAndRemoveUntil(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (BuildContext
                                                              context) =>
                                                          EndPage(
                                                        client: client,
                                                      ),
                                                    ),
                                                    (route) => false);
                                              }
                                            }
                                          },
                                        ),
                                      );
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
                isBlack: !client.darkTheme,
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
    }

    bool gameFinished = resolvePoints(player, playerPoints);

    if (gameFinished) {
      if (!player.eliminated) {
        client.game.players.add(player);
      }

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => EndPage(
              client: client,
            ),
          ),
          (route) => false);
    } else {
      if (!player.eliminated) {
        client.game.players.add(player);
      }

      currentPlayer = client.game.players.removeFirst();
      controller.text = "0";
      playerPoints = 0;
    }
  }

  /// Resolve the player points (return true if the game is finished)
  bool resolvePoints(Player player, int scoreToAdd) {
    if (scoreToAdd != 0) {
      player.failedAttemps = 0;
    }

    bool gameFinished = false;
    player.pointsHistory.add(scoreToAdd);

    if (scoreToAdd + player.currentScore == 50) {
      player.hasWon = true;
      player.currentScore = 50;

      gameFinished = true;
    } else if (scoreToAdd + player.currentScore > 50) {
      player.currentScore = 25;
    } else if (scoreToAdd == 0 &&
        client.game.gameSettings.whenThreeFailInRow !=
            ThreeFailAction.nothing) {
      player.failedAttemps++;

      if (player.failedAttemps == 3) {
        player.failedAttemps = 0;

        if (client.game.gameSettings.whenThreeFailInRow ==
            ThreeFailAction.resetPoints) {
          player.currentScore = 0;
        } else {
          player.eliminated = true;
          client.game.eliminatedPlayers.add(player);

          if (client.game.players.length <= 1) {
            gameFinished = true;
          }
        }
      }
    } else {
      player.currentScore += scoreToAdd;
    }

    setState(() {});

    return gameFinished;
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

    setState(() {
      selectedPins = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
    });
  }
}
