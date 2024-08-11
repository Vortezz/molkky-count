import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/colors/theme.dart';
import 'package:molkkycount/components/button.dart';
import 'package:molkkycount/components/icon_picker.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/enums/language.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key, required this.client});

  final Client client;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Client client;

  AppTheme theme = AppTheme.system;
  Language language = Language.system;

  @override
  void initState() {
    client = widget.client;
    setState(() {
      language = client.getLanguage();
      theme = client.getTheme();
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
          children: [
            CustomText(
              text: client.translate("settings.title"),
              client: client,
              textType: TextType.title,
              color: ColorName.text1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Column(
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: client.translate("settings.theme"),
                        client: client,
                        textType: TextType.emphasis,
                        color: ColorName.text1,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: client.translate("settings.theme.description"),
                        client: client,
                        textType: TextType.text,
                        color: ColorName.text1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  IconPicker(
                    client: client,
                    data: [
                      IconPickerData(
                        icon: "🌙",
                        text: client.translate("theme.dark"),
                      ),
                      IconPickerData(
                          icon: "☀️", text: client.translate("theme.light")),
                      IconPickerData(
                          icon: "⚙️",
                          text: client.translate("settings.system")),
                    ],
                    onPressed: (index) {
                      setState(() {
                        theme = AppTheme.values[index];
                      });
                    },
                    value: theme.index,
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      top: 30,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: client.translate("settings.language"),
                        client: client,
                        textType: TextType.emphasis,
                        color: ColorName.text1,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      bottom: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: client.translate("settings.language.description"),
                        client: client,
                        textType: TextType.text,
                        color: ColorName.text1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  IconPicker(
                    client: client,
                    data: [
                      IconPickerData(
                        icon: "🇬🇧",
                        text: client.translate("language.english"),
                      ),
                      IconPickerData(
                        icon: "🇫🇷",
                        text: client.translate("language.french"),
                      ),
                      IconPickerData(
                        icon: "⚙️",
                        text: client.translate("settings.system"),
                      ),
                    ],
                    onPressed: (index) {
                      setState(() {
                        language = Language.values[index];
                      });
                    },
                    value: language.index,
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                bottom: 20,
              ),
              child: Button(
                  client: client,
                  text: client.translate("settings.save"),
                  onPressed: () {
                    client.setAppTheme(theme);
                    client.setLanguage(language);

                    Navigator.pop(context);

                    client.reloadSettings();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
