import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';

class GamePin extends StatelessWidget {
  const GamePin(
      {Key? key,
      required this.client,
      required this.selectedPins,
      required this.number})
      : super(key: key);

  final Client client;

  final List<int> selectedPins;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        right: 3,
        left: 3,
        top: 3,
      ),
      child: ClipOval(
        child: Container(
          color: selectedPins[number - 1] == 0
              ? client.getColor(ColorName.background)
              : client.getColor(ColorName.button),
          child: IconButton(
            splashRadius: 0.001,
            onPressed: () {
              selectedPins[number - 1] =
                  (selectedPins[number - 1] == 0 ? 1 : 0);
              client.reloadState();
              },
            icon: Text(
              number.toString(),
              style: TextStyle(
                fontSize: 21,
                color: client.getColor(
                  ColorName.text1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
