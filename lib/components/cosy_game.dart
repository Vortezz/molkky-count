import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/components/game_pin.dart';
import 'package:molkkycount/components/text.dart';

class CosyGameComponent extends StatelessWidget {
  const CosyGameComponent(
      {super.key, required this.client, required this.selectedPins});

  final Client client;
  final List<int> selectedPins;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          child: CustomText(
            client: client,
            text: client.translate("game.fallen_pins"),
            textType: TextType.text,
            color: ColorName.text1,
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 7,
                  ),
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 9,
                  ),
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 8,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 5,
                  ),
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 11,
                  ),
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 12,
                  ),
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 6,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 3,
                  ),
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 10,
                  ),
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 4,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 1,
                  ),
                  GamePin(
                    client: client,
                    selectedPins: selectedPins,
                    number: 2,
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
