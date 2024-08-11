import 'dart:collection';

import 'package:molkkycount/class/game_settings.dart';
import 'package:molkkycount/class/player.dart';

class Game {
  Game({
    required this.gameSettings,
  });

  Queue<Player> players = Queue();
  List<Player> eliminatedPlayers = [];

  final GameSettings gameSettings;
}
