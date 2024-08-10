class Player {
  Player({
    required this.name,
  });

  final String name;
  final List<int> pointsHistory = [];

  bool hasWin = false;
  int currentScore = 0;
  int failedAttemps = 0;
}
