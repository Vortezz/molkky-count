import 'dart:convert';

import 'package:molkkycount/class/client.dart';

class GameHistory {
  final Map<String, int> scores;
  final Map<String, int> eliminatedPlayers;

  GameHistory(
    this.scores,
    this.eliminatedPlayers,
  );


}

class GamesHistory {
  final Map<int, GameHistory> games = {};
  late final Client client;

  GamesHistory(String history, this.client) {
    jsonDecode(history).forEach((key, value) {
      Map<String, int> scores = {};
      Map<String, int> eliminatedPlayers = {};

      value["scores"].forEach((key, value) {
        scores[key] = value;
      });

      value["eliminatedPlayers"].forEach((key, value) {
        eliminatedPlayers[key] = value;
      });

      games[int.parse(key)] = GameHistory(
        scores,
        eliminatedPlayers,
      );
    });
  }

  void addGame(GameHistory gameHistory) {
    games.putIfAbsent(DateTime.now().millisecondsSinceEpoch, () => gameHistory);

    save();
  }

  void save() {
    String jsonString = "{";

    int size = 0;

    for (var int in games.keys) {
      GameHistory gameHistory = games[int]!;

      jsonString +=
          '${size != 0 ? ", " : ""}"$int": {"eliminatedPlayers": ${jsonEncode(gameHistory.eliminatedPlayers)}, "scores": ${jsonEncode(gameHistory.scores)}}';

      size++;
    }

    jsonString += "}";

    client.writeHistory(jsonString);
  }
}
