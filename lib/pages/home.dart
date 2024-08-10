import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/default_layout.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/pages/game_settings.dart';
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
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: [
        //       IconButton(
        //         onPressed: () {
        //           Navigator.pushAndRemoveUntil(
        //             context,
        //             MaterialPageRoute(
        //               builder: (BuildContext context) => GamesHistoryPage(
        //                 client: client,
        //               ),
        //             ),
        //             (Route<dynamic> route) => false,
        //           );
        //         },
        //         icon: const Icon(
        //           Icons.watch_later,
        //         ),
        //         splashRadius: 20,
        //         tooltip: client.getTranslation(
        //           TranslationKey.gameHistory,
        //         ),
        //       ),
        //       PopupMenuButton<PopupMenuType>(
        //         onSelected: (PopupMenuType item) {
        //           if (item == PopupMenuType.settings) {
        //             Navigator.pushAndRemoveUntil(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (BuildContext context) => SettingsPage(
        //                   client: client,
        //                 ),
        //               ),
        //               (Route<dynamic> route) => false,
        //             );
        //           } else if (item == PopupMenuType.about) {
        //             Navigator.pushAndRemoveUntil(
        //               context,
        //               MaterialPageRoute(
        //                 builder: (BuildContext context) => AboutPage(
        //                   client: client,
        //                 ),
        //               ),
        //               (Route<dynamic> route) => false,
        //             );
        //           }
        //         },
        //         itemBuilder: (BuildContext context) =>
        //             <PopupMenuEntry<PopupMenuType>>[
        //           PopupMenuItem<PopupMenuType>(
        //             value: PopupMenuType.settings,
        //             child: Text(
        //               client.getTranslation(
        //                 TranslationKey.settings,
        //               ),
        //             ),
        //           ),
        //           PopupMenuItem<PopupMenuType>(
        //             value: PopupMenuType.about,
        //             child: Text(
        //               client.getTranslation(
        //                 TranslationKey.about,
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        backgroundColor: client.getColor(
          ColorName.background,
        ),
        elevation: 0,
        centerTitle: true,
      ),
      body: Center(
        child: DefaultLayout(
          client: client,
          titleKey: TranslationKey.hi,
          buttonKey: TranslationKey.startGame,
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => GameSettingsPage(
                  client: client,
                ),
              ),
              (Route<dynamic> route) => false,
            );
          },
          middleWidget: Align(
            alignment: Alignment.center,
            child: CustomText(
              client: client,
              translationKey: TranslationKey.description,
            ),
          ),
        ),
      ),
    );
  }
}
