import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/game_pin.dart';
import 'package:molkkycount/enums/three_fail_action.dart';
import 'package:molkkycount/pages/end.dart';
import 'package:molkkycount/translations/translations_key.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            client.game.gameSettings.cosyMode
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                          currentPlayer.name,
                          style: TextStyle(
                            color: currentPlayer.failedAttemps == 1 &&
                                    client.game.gameSettings
                                            .whenThreeFailInRow !=
                                        ThreeFailAction.nothing
                                ? client.getColor(
                                    ColorName.color3,
                                  )
                                : currentPlayer.failedAttemps == 2 &&
                                        client.game.gameSettings
                                                .whenThreeFailInRow !=
                                            ThreeFailAction.nothing
                                    ? client.getColor(
                                        ColorName.color2,
                                      )
                                    : client.getColor(
                                        ColorName.text1,
                                      ),
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: Text(
                          client.getTranslation(
                            TranslationKey.selectPins,
                          ),
                          style: TextStyle(
                            color: client.getColor(
                              ColorName.text1,
                            ),
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 7,
                                ),
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 9,
                                ),
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 8,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 5,
                                ),
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 11,
                                ),
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 12,
                                ),
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 6,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 3,
                                ),
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 10,
                                ),
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 4,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 1,
                                ),
                                GamePin(
                                  client: client,
                                  selectedPins: selectedPins,
                                  number: 2,
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Text(
                          currentPlayer.name,
                          style: TextStyle(
                            color: currentPlayer.failedAttemps == 1 &&
                                    client.game.gameSettings
                                            .whenThreeFailInRow !=
                                        ThreeFailAction.nothing
                                ? client.getColor(
                                    ColorName.color3,
                                  )
                                : currentPlayer.failedAttemps == 2 &&
                                        client.game.gameSettings
                                                .whenThreeFailInRow !=
                                            ThreeFailAction.nothing
                                    ? client.getColor(
                                        ColorName.color2,
                                      )
                                    : client.getColor(
                                        ColorName.text1,
                                      ),
                            fontSize: 32,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        client.getTranslation(
                          TranslationKey.enterScore,
                        ),
                        style: TextStyle(
                          color: client.getColor(
                            ColorName.text1,
                          ),
                          fontSize: 20,
                          fontWeight: FontWeight.w300,
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
                                      setState(() {
                                        playerPoints--;
                                        controller.text =
                                            playerPoints.toString();
                                      });
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
                              child: TextField(
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
                                onSubmitted: (value) {
                                  setState(() {
                                    if (value != "") {
                                      var points = int.parse(value);
                                      if (points > 12) {
                                        points = 12;
                                        controller.text = points.toString();
                                      } else if (points < 0) {
                                        points = 0;
                                        controller.text = points.toString();
                                      }
                                      playerPoints = points;
                                    } else {
                                      controller.text = "0";
                                      playerPoints = 0;
                                    }
                                  });
                                },
                                onChanged: (value) {
                                  setState(() {
                                    if (value != "") {
                                      var points = int.parse(value);
                                      if (points > 12) {
                                        points = 12;
                                        controller.text = points.toString();
                                      } else if (points < 0) {
                                        points = 0;
                                        controller.text = points.toString();
                                      }
                                      playerPoints = points;
                                    } else {
                                      controller.text = "0";
                                      playerPoints = 0;
                                    }
                                  });
                                },
                                controller: controller,
                              ),
                            ),
                            IconButton(
                              onPressed: playerPoints < 12
                                  ? () {
                                      setState(() {
                                        playerPoints++;
                                        controller.text =
                                            playerPoints.toString();
                                      });
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
                  ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: client.getColor(ColorName.color1),
                  elevation: 0,
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  setState(() {
                    resolvePlayerPoints(currentPlayer);
                  });
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
            firstPlayOfTheGame
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: client.getColor(ColorName.color1),
                        elevation: 0,
                        shape: StadiumBorder(),
                      ),
                      onPressed: () {
                        setState(() {
                          backToPreviousPlayer();
                        });
                      },
                      child: Text(
                        client.getTranslation(
                          TranslationKey.previous,
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
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: client.game.players.length * 50 + 50,
              child: ListView.builder(
                itemCount: client.game.players.length + 1,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  List<Player> players = client.game.players.toList();
                  players.add(currentPlayer);
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
          ],
        ),
      ),
    );
  }

  void resolvePlayerPoints(Player player) {
    if (client.game.gameSettings.cosyMode) {
      resolveCosyMode(player);
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
        } else {
          player.pointsHistory.add(currentScore);
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

  void resolveCosyMode(Player player) {
    int sum = 0;
    for (int element in selectedPins) {
      sum += element;
    }

    if (sum == 1) {
      playerPoints = selectedPins.indexOf(1) + 1;
    } else if (sum > 1) {
      playerPoints = sum;
    }

    selectedPins = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  }

  void backToPreviousPlayer() {
    if (client.game.players.isEmpty) {
      return;
    }

    client.game.players.addFirst(currentPlayer);

    Player player = client.game.players.removeLast();

    int lastScore;

    if (player.pointsHistory.isEmpty) {
      lastScore = 0;
      player.currentScore = 0;
    } else {
      lastScore = player.pointsHistory.last;
      player.currentScore -= lastScore;
      player.pointsHistory.removeLast();
    }

    currentPlayer = player;
    controller.text = lastScore.toString();
    playerPoints = lastScore;

    firstPlayOfTheGame = player.pointsHistory.isEmpty;

    if (!firstPlayOfTheGame) {
      return;
    }

    for (Player player in client.game.players) {
      if (player.pointsHistory.isNotEmpty) {
        firstPlayOfTheGame = false;
        break;
      }
    }
  }
}
