import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/games_history.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/pages/home.dart';
import 'package:molkkycount/translations/translations_key.dart';

class GamesHistoryPage extends StatefulWidget {
  const GamesHistoryPage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<GamesHistoryPage> createState() => _GamesHistoryPageState();
}

class _GamesHistoryPageState extends State<GamesHistoryPage> {
  late Client client;
  late List<MapEntry<int, GameHistory>> games;

  int currentGame = 0;

  @override
  void initState() {
    client = widget.client;
    super.initState();

    games = client.getHistory().games.entries.toList();
    games.sort((a, b) => a.key.compareTo(b.key));

    setState(() {
      if (games.isNotEmpty) {
        currentGame = games.length - 1;
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
            Text(
              client.getTranslation(
                TranslationKey.gameHistory,
              ),
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
                          onPressed: currentGame == 0
                              ? null
                              : () {
                                  setState(() {
                                    currentGame--;
                                  });
                                },
                          splashRadius: 20,
                          icon: Icon(
                            Icons.arrow_back,
                            color: currentGame != 0
                                ? client.getColor(
                                    ColorName.text1,
                                  )
                                : client.getColor(
                                    ColorName.background,
                                  ),
                          ),
                        ),
                        Text(
                          SchedulerBinding.instance.window.alwaysUse24HourFormat
                              ? DateFormat().add_yMd().add_Hm().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      games[currentGame].key,
                                    ),
                                  )
                              : DateFormat().add_yMd().add_jm().format(
                                    DateTime.fromMillisecondsSinceEpoch(
                                      games[currentGame].key,
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
                          onPressed: currentGame < games.length - 1
                              ? () {
                                  setState(() {
                                    currentGame++;
                                  });
                                }
                              : null,
                          splashRadius: 20,
                          icon: Icon(
                            Icons.arrow_forward,
                            color: currentGame < games.length - 1
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
            games.isEmpty
                ? Container()
                : Container(
                    margin: const EdgeInsets.only(
                      top: 20,
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ListView.builder(
                      itemExtent: 27,
                      shrinkWrap: true,
                      itemCount: games[currentGame].value.scores.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        List<MapEntry<String, int>> players =
                            games[currentGame].value.scores.entries.toList();

                        players.sort((a, b) => b.value.compareTo(a.value));

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
                                    players[index].key,
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
                                players[index].value.toString(),
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
            games.isEmpty
                ? Container()
                : games[currentGame].value.eliminatedPlayers.isNotEmpty
                    ? Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            margin: EdgeInsets.only(
                              top: 24,
                              bottom: 20,
                            ),
                            child: Text(
                              client.getTranslation(
                                  TranslationKey.eliminatedPlayers),
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
                              itemCount: games[currentGame]
                                  .value
                                  .eliminatedPlayers
                                  .length,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                List<MapEntry<String, int>> players =
                                    games[currentGame]
                                        .value
                                        .eliminatedPlayers
                                        .entries
                                        .toList();

                                players
                                    .sort((a, b) => b.value.compareTo(a.value));

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
                                        players[index].key,
                                        style: TextStyle(
                                          color: client.getColor(
                                            ColorName.color2,
                                          ),
                                          fontSize: 23,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                      Text(
                                        players[index].value.toString(),
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
          ],
        ),
      ),
    );
  }
}
