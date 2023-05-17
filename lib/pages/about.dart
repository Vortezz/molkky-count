import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/pages/home.dart';
import 'package:molkkycount/translations/translations_key.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key, required this.client}) : super(key: key);

  final Client client;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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
                TranslationKey.about,
              ),
              style: TextStyle(
                color: client.getColor(
                  ColorName.text1,
                ),
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                top: 20,
              ),
              width: 240,
              child: Text(
                client.getTranslation(
                  TranslationKey.aboutDescription,
                ),
                textAlign: TextAlign.justify,
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
              margin: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              width: 240,
              child: Column(
                children: [
                  Text(
                    client.getTranslation(
                      TranslationKey.aboutTerms,
                    ),
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: client.getColor(
                        ColorName.text1,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  InkWell(
                    child: Text(
                      'https://vortezz.dev/terms    ',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: client.getColor(
                          ColorName.text1,
                        ),
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    onTap: () => launchUrl(
                      Uri.parse("https://vortezz.dev/terms"),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                launchUrl(
                  Uri.parse("https://github.com/Vortezz/molkky-count"),
                );
              },
              icon: Icon(
                Icons.code,
                color: client.getColor(
                  ColorName.text1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
