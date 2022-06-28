enum ThreeFailAction {
  nothing(0),
  eliminate(1),
  resetPoints(2);

  final int value;

  const ThreeFailAction(int i) : value = i;

  static ThreeFailAction? getNext(ThreeFailAction action) {
    switch (action) {
      case nothing:
        return eliminate;
      case eliminate:
        return resetPoints;
      default:
        return null;
    }
  }

  static ThreeFailAction? getPrevious(ThreeFailAction action) {
    switch (action) {
      case resetPoints:
        return eliminate;
      case eliminate:
        return nothing;
      default:
        return null;
    }
  }
}
