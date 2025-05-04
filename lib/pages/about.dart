import 'package:flutter/material.dart';
import 'package:flutter_vortezz_base/components/text.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key, required this.client}) : super(key: key);

  final MolkkyClient client;

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late MolkkyClient client;

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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              client.translate("about.title"),
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
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomText(
                client: client,
                text: client.translate("about.description"),
                color: client.getColor(ColorName.text1),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                          "https://vortezz.dev/privacy",
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.note_alt_rounded,
                      color: client.getColor(
                        ColorName.text1,
                      ),
                      size: 32,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      launchUrl(
                        Uri.parse(
                          "https://github.com/Vortezz/molkky-count",
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.code,
                      color: client.getColor(
                        ColorName.text1,
                      ),
                      size: 32,
                    ),
                  ),
                ],
              ),
            ),
            Container(),
          ],
        ),
      ),
    );
  }
}
