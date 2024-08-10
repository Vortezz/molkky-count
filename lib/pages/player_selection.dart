import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/button.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/pages/add_player.dart';
import 'package:molkkycount/pages/game_settings.dart';

class PlayerSelectionPage extends StatefulWidget {
  const PlayerSelectionPage({
    super.key,
    required this.client,
  });

  final Client client;

  @override
  State<PlayerSelectionPage> createState() => _PlayerSelectionPageState();
}

class _PlayerSelectionPageState extends State<PlayerSelectionPage> {
  late Client client;
  late String category;

  ScrollController _scrollController = ScrollController();
  List<Player> players = [];

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
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomText(
                    text: client.translate("player_selection.title"),
                    client: client,
                    textType: TextType.title,
                    color: ColorName.text1,
                  ),
                  players.isEmpty
                      ? Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 16,
                                ),
                                child: Icon(
                                  Icons.error_outline,
                                  color: client.getColor(
                                    ColorName.text1,
                                  ),
                                ),
                              ),
                              CustomText(
                                text: client
                                    .translate("player_selection.no_player"),
                                client: client,
                                textType: TextType.text,
                                color: ColorName.text1,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                          ),
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.5,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0),
                            itemCount: players.length,
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              Player player = players[index];

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        player.teamStatus.icon,
                                        style: const TextStyle(
                                          fontSize: 24,
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                          left: 16,
                                        ),
                                        child: CustomText(
                                          text: player.name,
                                          client: client,
                                          textType: TextType.subtitle,
                                          color: ColorName.text1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        players.removeAt(index);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close_rounded,
                                      color: Colors.white,
                                      size: 32,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                ),
                child: Column(
                  children: [
                    Button(
                      text: client.translate("player_selection.add_player"),
                      onPressed: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPlayerPage(
                                client: client,
                                onAddPlayer: (Player player) {
                                  setState(() {
                                    players.add(player);
                                  });

                                  if (_scrollController.hasClients) {
                                    _scrollController.animateTo(
                                      _scrollController
                                              .position.maxScrollExtent +
                                          50,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.ease,
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        });
                      },
                      client: client,
                      isColored: false,
                    ),
                    Button(
                      text: client.translate("player_selection.continue"),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GameSettingsPage(
                              client: client,
                              players: players,
                            ),
                          ),
                        );
                      },
                      client: client,
                      isDisabled: players.length < 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
