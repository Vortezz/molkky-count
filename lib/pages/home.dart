import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/button.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/pages/games_history.dart';
import 'package:molkkycount/pages/player_selection.dart';
import 'package:molkkycount/pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  late Client client;

  @override
  void initState() {
    client = widget.client;
    super.initState();

    client.on("reloadSettings", (state) {
      setState(() {});
    });

    client.on("loaded", (state) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: client.getColor(
        ColorName.background,
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: client.getColor(
            ColorName.text1,
          ),
        ),
        title: client.getHistory().games.isEmpty
            ? null
            : Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.timer_outlined,
                      color: client.getColor(
                        ColorName.text1,
                      ),
                    ),
                    tooltip: client.translate("games_history.title"),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => GamesHistoryPage(
                            client: client,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: client.getColor(
                ColorName.text1,
              ),
            ),
            tooltip: client.translate("settings.title"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => SettingsPage(
                    client: client,
                  ),
                ),
              );
            },
          ),
        ],
        backgroundColor: client.getColor(
          ColorName.background,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 256,
                  width: 256,
                  child: Image.asset(
                    "assets/logo_1000.png",
                  ),
                  margin: const EdgeInsets.only(
                    bottom: 22,
                  ),
                ),
                CustomText(
                  text: client.translate("home.title"),
                  client: client,
                  textType: TextType.title,
                  color: ColorName.text1,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: CustomText(
                    text: client.translate("home.description"),
                    client: client,
                    textType: TextType.text,
                    color: ColorName.text1,
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Button(
                client: client,
                text: client.translate("home.start_game"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => PlayerSelectionPage(
                        client: client,
                      ),
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
}
