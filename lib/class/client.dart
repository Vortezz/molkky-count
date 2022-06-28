import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:molkkycount/class/event_emitter.dart';
import 'package:molkkycount/class/game.dart';
import 'package:molkkycount/class/game_settings.dart';
import 'package:molkkycount/class/games_history.dart';
import 'package:molkkycount/colors/colors_name.dart';
import 'package:molkkycount/colors/dark.dart';
import 'package:molkkycount/colors/light.dart';
import 'package:molkkycount/colors/theme.dart';
import 'package:molkkycount/translations/en.dart';
import 'package:molkkycount/translations/fr.dart';
import 'package:molkkycount/translations/language.dart';
import 'package:molkkycount/translations/translations_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Client with EventEmitter {
  Client() {
    init();
  }

  AppTheme _appTheme = AppTheme.dark;
  bool systemTheme = false;

  Language _language = Language.en;
  String systemLanguage = "en";

  late GamesHistory _gamesHistory;

  Game game = Game(
    GameSettings(),
  );

  late SharedPreferences preferences;

  final DarkColors darkColors = DarkColors();
  final LightColors lightColors = LightColors();

  final EnglishTranslation englishTranslation = EnglishTranslation();
  final FrenchTranslation frenchTranslation = FrenchTranslation();

  Future<void> init() async {
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
        preferences.setString("molkky.language", "system");
        break;
    }

    _gamesHistory =
        GamesHistory(preferences.getString("molkky.history") ?? "{}", this);
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

  String getTranslation(TranslationKey translationKey) {
    switch (_language) {
      case Language.en:
        return englishTranslation.getTranslationFromName(translationKey) ?? "";
      case Language.fr:
        return frenchTranslation.getTranslationFromName(translationKey) ?? "";
      default:
        if (_language == Language.system) {
          if (systemLanguage == "en") {
            return englishTranslation.getTranslationFromName(translationKey) ??
                "";
          } else if (systemLanguage == "fr") {
            return frenchTranslation.getTranslationFromName(translationKey) ??
                "";
          }
        }
        return englishTranslation.getTranslationFromName(translationKey) ?? "";
    }
  }

  void writeHistory(String json) {
    preferences.setString("molkky.history", json);
  }

  void reloadState() {
    emit("reloadState");
  }
}
