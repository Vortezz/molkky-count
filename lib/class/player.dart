import 'package:molkkycount/enums/team_status.dart';

class Player {
  Player({
    required this.name,
    required this.teamStatus,
  });

  final String name;
  final TeamStatus teamStatus;
  List<int> pointsHistory = [];

  bool hasWon = false;
  bool eliminated = false;
  int currentScore = 0;
  int failedAttemps = 0;
}
