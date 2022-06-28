class Player {
  final String name;
  final List<int> pointsHistory = [];

  bool hasWin = false;
  int currentScore = 0;
  int failedAttemps = 0;

  Player(
    this.name,
  );
}
