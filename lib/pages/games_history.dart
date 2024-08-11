import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/games_history.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/enums/team_status.dart';

class GamesHistoryPage extends StatefulWidget {
  const GamesHistoryPage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<GamesHistoryPage> createState() => _GamesHistoryPageState();
}

class _GamesHistoryPageState extends State<GamesHistoryPage> {
  late Client client;
  late List<MapEntry<int, GameHistory>> games;

  int currentGameId = 0;
  GameHistory currentGame = GameHistory({}, {});

  @override
  void initState() {
    client = widget.client;
    super.initState();

    games = client.getHistory().games.entries.toList();
    games.sort((a, b) => a.key.compareTo(b.key));

    setState(() {
      if (games.isNotEmpty) {
        currentGameId = games.length - 1;
        currentGame = games[currentGameId].value;
      }
    });
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
            Column(
              children: [
                Text(
                  client.translate("games_history.title"),
                  style: TextStyle(
                    color: client.getColor(
                      ColorName.text1,
                    ),
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                games.isEmpty
                    ? Container()
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: currentGameId == 0
                                  ? null
                                  : () {
                                      setState(() {
                                        currentGameId--;
                                        currentGame =
                                            games[currentGameId].value;
                                      });
                                    },
                              splashRadius: 20,
                              icon: Icon(
                                Icons.arrow_back,
                                color: currentGameId != 0
                                    ? client.getColor(
                                        ColorName.text1,
                                      )
                                    : client.getColor(
                                        ColorName.background,
                                      ),
                              ),
                            ),
                            Text(
                              SchedulerBinding
                                      .instance.window.alwaysUse24HourFormat
                                  ? DateFormat().addPattern("d/M/y H:m").format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          games[currentGameId].key,
                                        ),
                                      )
                                  : DateFormat().add_yMd().add_jm().format(
                                        DateTime.fromMillisecondsSinceEpoch(
                                          games[currentGameId].key,
                                        ),
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
                              onPressed: currentGameId < games.length - 1
                                  ? () {
                                      setState(() {
                                        currentGameId++;
                                        currentGame =
                                            games[currentGameId].value;
                                      });
                                    }
                                  : null,
                              splashRadius: 20,
                              icon: Icon(
                                Icons.arrow_forward,
                                color: currentGameId < games.length - 1
                                    ? client.getColor(
                                        ColorName.text1,
                                      )
                                    : client.getColor(
                                        ColorName.background,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
            games.isEmpty
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: min(
                        (currentGame.scores.length +
                                currentGame.eliminatedPlayers.length) *
                            45,
                        MediaQuery.of(context).size.height * 0.5),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      itemCount: currentGame.scores.length +
                          currentGame.eliminatedPlayers.length,
                      itemBuilder: (context, index) {
                        List<Player> players = currentGame.scores.entries
                            .map(
                              (e) => Player(
                                name: e.key,
                                teamStatus: TeamStatus.solo,
                              ),
                            )
                            .toList();
                        players.sort(
                            (a, b) => b.currentScore.compareTo(a.currentScore));
                        List<Player> eliminatedPlayers =
                            currentGame.eliminatedPlayers.entries
                                .map(
                                  (e) => Player(
                                    name: e.key,
                                    teamStatus: TeamStatus.solo,
                                  ),
                                )
                                .toList();
                        eliminatedPlayers.sort(
                            (a, b) => b.currentScore.compareTo(a.currentScore));
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
                                      decoration:
                                          eliminatedPlayers.contains(player)
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
                                  decoration: eliminatedPlayers.contains(player)
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
            Container(),
          ],
        ),
      ),
    );
  }
}
