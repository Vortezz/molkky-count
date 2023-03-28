import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/colors/theme.dart';
import 'package:molkkycount/pages/home.dart';
import 'package:molkkycount/translations/language.dart';
import 'package:molkkycount/translations/translations_key.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Client client;

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
                TranslationKey.settings,
              ),
              style: TextStyle(
                color: client.getColor(
                  ColorName.text1,
                ),
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  client.getTranslation(
                    TranslationKey.language,
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
                  onPressed: client.getLanguage().value != 0
                      ? () {
                          setState(() {
                            client.setLanguage(Language.getPrevious(
                              client.getLanguage(),
                            ));
                          });
                        }
                      : () {
                          setState(() {
                            client.setLanguage(Language.system);
                          });
                        },
                  icon: Icon(
                    Icons.arrow_back,
                    color: client.getColor(ColorName.text1),
                  ),
                ),
                Text(
                  client.getLanguage().value == 0
                      ? "English"
                      : client.getLanguage().value == 1
                          ? "Français"
                          : client.getTranslation(
                              TranslationKey.system,
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
                  onPressed: client.getLanguage().value != 2
                      ? () {
                          setState(() {
                            client.setLanguage(Language.getNext(
                              client.getLanguage(),
                            ));
                          });
                        }
                      : () {
                          setState(() {
                            client.setLanguage(Language.en);
                          });
                        },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: client.getColor(ColorName.text1),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  client.getTranslation(
                    TranslationKey.theme,
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
                  onPressed: client.getTheme().value != 0
                      ? () {
                          setState(() {
                            client.setAppTheme(AppTheme.getPrevious(
                              client.getTheme(),
                            ));
                          });
                        }
                      : () {
                          setState(() {
                            client.setAppTheme(AppTheme.system);
                          });
                        },
                  icon: Icon(
                    Icons.arrow_back,
                    color: client.getColor(ColorName.text1),
                  ),
                ),
                Text(
                  client.getTheme().value == 0
                      ? client.getTranslation(TranslationKey.darkTheme)
                      : client.getTheme().value == 1
                          ? client.getTranslation(TranslationKey.lightTheme)
                          : client.getTranslation(
                              TranslationKey.system,
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
                  onPressed: client.getLanguage().value != 2
                      ? () {
                          setState(() {
                            client.setAppTheme(AppTheme.getNext(
                              client.getTheme(),
                            ));
                          });
                        }
                      : () {
                          setState(() {
                            client.setAppTheme(AppTheme.dark);
                          });
                        },
                  icon: Icon(
                    Icons.arrow_forward,
                    color: client.getColor(ColorName.text1),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
