enum AppTheme {
  dark(0),
  light(1),
  system(2);

  final int value;

  const AppTheme(int i) : value = i;

  static AppTheme getThemeFromString(String theme) {
    switch (theme) {
      case "dark":
        return AppTheme.dark;
      case "light":
        return AppTheme.light;
      default:
        return AppTheme.system;
    }
  }

  static AppTheme getNext(AppTheme theme) {
    switch (theme) {
      case dark:
        return light;
      case light:
        return system;
      default:
        return dark;
    }
  }

  static AppTheme getPrevious(AppTheme theme) {
    switch (theme) {
      case system:
        return light;
      case light:
        return dark;
      default:
        return system;
    }
  }
}
