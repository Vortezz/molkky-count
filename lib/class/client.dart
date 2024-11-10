import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vortezz_base/enum/app_theme.dart';
import 'package:flutter_vortezz_base/struct/client.dart';
import 'package:molkkycount/class/game.dart';
import 'package:molkkycount/class/game_settings.dart';
import 'package:molkkycount/class/games_history.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/colors/dark.dart';
import 'package:molkkycount/colors/light.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MolkkyClient extends Client {
  MolkkyClient() : super(appName: "molkky") {
    _gamesHistory = GamesHistory(
      "{}",
      this,
    );
  }

  late GamesHistory _gamesHistory;

  Game game = Game(
    gameSettings: GameSettings(),
  );

  final DarkColors darkColors = DarkColors();
  final LightColors lightColors = LightColors();

  @override
  Future<void> load() async {
    super.load();

    preferences = await SharedPreferences.getInstance();

    _gamesHistory =
        GamesHistory(preferences.getString("molkky.history") ?? "{}", this);

    emit("loaded");
  }

  GamesHistory getHistory() {
    return _gamesHistory;
  }

  Color getColor(ColorName colorName) {
    if (appTheme == AppTheme.system) {
      if (systemTheme) {
        return darkColors.getColorFromName(colorName);
      } else {
        return lightColors.getColorFromName(colorName);
      }
    }
    if (appTheme == AppTheme.dark) {
      return darkColors.getColorFromName(colorName);
    } else if (appTheme == AppTheme.light) {
      return lightColors.getColorFromName(colorName);
    } else {
      return darkColors.getColorFromName(colorName);
    }
  }

  void writeHistory(String json) {
    preferences.setString("molkky.history", json);
  }

  void reloadState() {
    emit("reloadState");
  }

  void reloadSettings() {
    emit("reloadSettings");
  }
}
