import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/class/player.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/button.dart';
import 'package:molkkycount/components/icon_picker.dart';
import 'package:molkkycount/components/text.dart';
import 'package:molkkycount/enums/team_status.dart';

class AddPlayerPage extends StatefulWidget {
  const AddPlayerPage(
      {super.key, required this.client, required this.onAddPlayer});

  final Client client;
  final Function(Player) onAddPlayer;

  @override
  State<AddPlayerPage> createState() => _AddPlayerPageState();
}

class _AddPlayerPageState extends State<AddPlayerPage> {
  late Client client;
  late TextEditingController _controller;

  String name = "";
  TeamStatus teamStatus = TeamStatus.solo;

  @override
  void initState() {
    client = widget.client;
    _controller = TextEditingController();
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
              CustomText(
                text: client.translate("add_player.title"),
                client: client,
                textType: TextType.title,
                color: ColorName.text1,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: client.translate("add_player.name"),
                          client: client,
                          textType: TextType.emphasis,
                          color: ColorName.text1,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: client.translate("add_player.hint"),
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.only(
                            left: 15, right: 15, top: 10, bottom: 10),
                      ),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 30,
                        bottom: 10,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomText(
                          text: client.translate("add_player.gender"),
                          client: client,
                          textType: TextType.emphasis,
                          color: ColorName.text1,
                        ),
                      ),
                    ),
                    IconPicker(
                      client: client,
                      data: [
                        IconPickerData(
                            icon: TeamStatus.solo.icon,
                            text: client.translate("team_status.solo")),
                        IconPickerData(
                            icon: TeamStatus.team.icon,
                            text: client.translate("team_status.team")),
                      ],
                      onPressed: (index) {
                        setState(() {
                          teamStatus = TeamStatus.values[index];
                        });
                      },
                      value: teamStatus.index,
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
                  text: client.translate("add_player.button"),
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();

                    widget.onAddPlayer(
                      Player(
                        name: _controller.text,
                        teamStatus: teamStatus,
                      ),
                    );

                    Navigator.pop(context);
                  },
                  isDisabled: _controller.text.isEmpty,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
