import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/pages/game_settings.dart';
import 'package:molkkycount/pages/games_history.dart';
import 'package:molkkycount/pages/settings.dart';
import 'package:molkkycount/translations/translations_key.dart';

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
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => GamesHistoryPage(
                      client: client,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(
                Icons.watch_later,
              ),
              splashRadius: 20,
              tooltip: client.getTranslation(
                TranslationKey.gameHistory,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => SettingsPage(
                      client: client,
                    ),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              icon: const Icon(
                Icons.settings,
              ),
              splashRadius: 20,
              tooltip: client.getTranslation(
                TranslationKey.settings,
              ),
            ),
          ],
        ),
        backgroundColor: client.getColor(
          ColorName.background,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                "lib/assets/logo_1000.png",
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 10,
              ),
              child: Text(
                "Molkky Count",
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
                  TranslationKey.description,
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: client.getColor(ColorName.color1),
                  elevation: 0,
                  shape: StadiumBorder(),
                ),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => GameSettingsPage(
                          client: client,
                        ),
                      ),
                      (route) => false);
                },
                child: Text(
                  client.getTranslation(
                    TranslationKey.startGame,
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
