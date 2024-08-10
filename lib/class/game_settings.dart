import 'package:molkkycount/enums/three_fail_action.dart';

class GameSettings {
  GameSettings({
    this.whenThreeFailInRow = ThreeFailAction.nothing,
    this.cosyType = false,
  });

  ThreeFailAction whenThreeFailInRow = ThreeFailAction.nothing;
  bool cosyType = false;
}
