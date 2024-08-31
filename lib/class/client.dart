import 'dart:convert';

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:molkkycount/class/event_emitter.dart';
import 'package:molkkycount/class/game.dart';
import 'package:molkkycount/class/game_settings.dart';
import 'package:molkkycount/class/games_history.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/colors/dark.dart';
import 'package:molkkycount/colors/light.dart';
import 'package:molkkycount/colors/theme.dart';
import 'package:molkkycount/enums/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Client with EventEmitter {
  Client() {
    _gamesHistory = GamesHistory(
      "{}",
      this,
    );

    init();
  }

  Map<String, Map<String, String>> translations = {};

  AppTheme _appTheme = AppTheme.dark;
  bool systemTheme = false;

  Language _language = Language.en;
  String systemLanguage = "en";

  late GamesHistory _gamesHistory;

  Game game = Game(
    gameSettings: GameSettings(),
  );

  late SharedPreferences preferences;

  final DarkColors darkColors = DarkColors();
  final LightColors lightColors = LightColors();

  Future<void> init() async {
    for (String lang in ["en", "fr"]) {
      String translationJson =
          await rootBundle.loadString("assets/lang/$lang.json");

      Map<String, dynamic> json = jsonDecode(translationJson);

      Map<String, String> translation = {};

      for (MapEntry entry in json.entries) {
        translation[entry.key] = entry.value as String;
      }

      translations[lang] = translation;
    }

    preferences = await SharedPreferences.getInstance();

    if (!preferences.containsKey("molkky.theme")) {
      preferences.setString("molkky.theme", "system");
    }

    if (!preferences.containsKey("molkky.language")) {
      preferences.setString("molkky.language", "system");
    }

    if (!preferences.containsKey("molkky.history")) {
      preferences.setString("molkky.history", "{}");
    }

    switch (preferences.getString("molkky.theme")) {
      case "system":
        _appTheme = AppTheme.system;
        systemTheme = SchedulerBinding.instance.window.platformBrightness ==
            Brightness.dark;
        break;
      case "dark":
        _appTheme = AppTheme.dark;
        break;
      case "light":
        _appTheme = AppTheme.light;
        break;
      default:
        _appTheme = AppTheme.system;
        systemTheme = SchedulerBinding.instance.window.platformBrightness ==
            Brightness.dark;
        preferences.setString("molkky.theme", "system");
        break;
    }

    switch (preferences.getString("molkky.language")) {
      case "system":
        _language = Language.system;
        systemLanguage = SchedulerBinding.instance.window.locale.languageCode;

        if (!translations.containsKey(systemLanguage)) {
          systemLanguage = "en";
        }
        break;
      case "en":
        _language = Language.en;
        break;
      case "fr":
        _language = Language.fr;
        break;
      default:
        _language = Language.system;
        systemLanguage = SchedulerBinding.instance.window.locale.languageCode;

        if (!translations.containsKey(systemLanguage)) {
          systemLanguage = "en";
        }

        preferences.setString("molkky.language", "system");
        break;
    }

    _gamesHistory =
        GamesHistory(preferences.getString("molkky.history") ?? "{}", this);

    emit("loaded");
  }

  void setAppTheme(AppTheme appTheme) {
    _appTheme = appTheme;

    if (_appTheme == AppTheme.system) {
      _appTheme = AppTheme.system;
      systemTheme = SchedulerBinding.instance.window.platformBrightness ==
          Brightness.dark;
    }

    preferences.setString("molkky.theme", _appTheme.name);
  }

  void setLanguage(Language language) {
    _language = language;

    if (_language == Language.system) {
      _language = Language.system;
      systemLanguage = SchedulerBinding.instance.window.locale.languageCode;
    }

    preferences.setString("molkky.language", _language.name);
  }

  Language getLanguage() {
    return _language;
  }

  AppTheme getTheme() {
    return _appTheme;
  }

  GamesHistory getHistory() {
    return _gamesHistory;
  }

  Color? getColor(ColorName colorName) {
    if (_appTheme == AppTheme.system) {
      if (systemTheme) {
        return darkColors.getColorFromName(colorName);
      } else {
        return lightColors.getColorFromName(colorName);
      }
    }
    if (_appTheme == AppTheme.dark) {
      return darkColors.getColorFromName(colorName);
    } else if (_appTheme == AppTheme.light) {
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

  String _getLanguage() {
    switch (_language) {
      case Language.en:
        return "en";
      case Language.fr:
        return "fr";
      default:
        return systemLanguage;
    }
  }

  String translate(String key, [Map<String, String>? replacements]) {
    replacements ??= Map.identity();

    String text = key;
    if (translations[_getLanguage()] != null &&
        translations[_getLanguage()]!.containsKey(key)) {
      text = translations[_getLanguage()]![key] ?? key;
    }

    for (MapEntry entry in replacements.entries) {
      text = text.replaceAll("{${entry.key}}", entry.value);
    }

    return text;
  }
}
