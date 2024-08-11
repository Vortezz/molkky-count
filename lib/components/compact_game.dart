import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';

class CompactGameComponent extends StatefulWidget {
  const CompactGameComponent({
    super.key,
    required this.client,
    required this.setPlayerPoints,
    required this.playerPoints,
    this.isSmall = false,
  });

  final Client client;
  final Function(int, bool) setPlayerPoints;
  final int playerPoints;
  final bool isSmall;

  @override
  State<CompactGameComponent> createState() {
    return _CompactGameComponentState();
  }
}

class _CompactGameComponentState extends State<CompactGameComponent> {
  late Client client;
  late TextEditingController controller;
  late bool isSmall;
  late FocusNode focusNode;
  late int playerPoints;
  late Function(int, bool) setPlayerPoints;

  @override
  void initState() {
    client = widget.client;
    setPlayerPoints = widget.setPlayerPoints;
    playerPoints = widget.playerPoints;
    focusNode = FocusNode();
    controller = TextEditingController(text: playerPoints.toString());
    isSmall = widget.isSmall;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant CompactGameComponent oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.playerPoints != widget.playerPoints) {
      setState(() {
        playerPoints = widget.playerPoints;
        controller.text = playerPoints.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
      ),
      width: isSmall ? null : MediaQuery.of(context).size.width * 0.8,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: playerPoints > 0
                ? () {
                    controller.text = (playerPoints - 1).toString();

                    setPlayerPoints(playerPoints - 1, false);
                  }
                : null,
            icon: Icon(
              Icons.remove,
              color: playerPoints > 0
                  ? client.getColor(ColorName.text1)
                  : client.getColor(ColorName.text2),
            ),
          ),
          Container(
            width: 50,
            child: TextField(
              focusNode: focusNode,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: client.getColor(
                  ColorName.text1,
                ),
                fontSize: 22,
                fontWeight: FontWeight.w300,
              ),
              cursorColor: client.getColor(
                ColorName.text1,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "0",
                hintStyle: TextStyle(
                  color: client.getColor(
                    ColorName.text2,
                  ),
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onSubmitted: (value) {
                if (value != "") {
                  var points = int.parse(value);
                  if (points > 12) {
                    points = 12;
                    controller.text = points.toString();
                  } else if (points < 0) {
                    points = 0;
                    controller.text = points.toString();
                  }

                  setPlayerPoints(points, true);
                } else {
                  controller.text = "0";
                  setPlayerPoints(0, true);
                }
              },
              onChanged: (value) {
                if (value != "") {
                  var points = int.parse(value);
                  if (points > 12) {
                    points = 12;
                    controller.text = points.toString();
                  } else if (points < 0) {
                    points = 0;
                    controller.text = points.toString();
                  }

                  setPlayerPoints(points, false);
                } else {
                  controller.text = "0";
                  setPlayerPoints(0, false);
                }

                FocusScope.of(context).requestFocus(focusNode);
              },
              controller: controller,
            ),
          ),
          IconButton(
            onPressed: playerPoints < 12
                ? () {
                    controller.text = (playerPoints + 1).toString();

                    setPlayerPoints(playerPoints + 1, false);
                  }
                : null,
            icon: Icon(
              Icons.add,
              color: playerPoints < 12
                  ? client.getColor(ColorName.text1)
                  : client.getColor(ColorName.text2),
            ),
          ),
        ],
      ),
    );
  }
}
