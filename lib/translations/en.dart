import 'package:molkkycount/translations/translations_key.dart';

class EnglishTranslation {
  Map<TranslationKey, String> enTranslations = {
    TranslationKey.description:
        "Count points in a molkky game will now be a child work !",
    TranslationKey.startGame: "Start a game",
    TranslationKey.settings: "Settings",
    TranslationKey.gameHistory: "Game history",
    TranslationKey.gameSettings: "Game Settings",
    TranslationKey.players: "Players",
    TranslationKey.mode: "Game mode",
    TranslationKey.cosyMode: "Cosy",
    TranslationKey.compactMode: "Compact",
    TranslationKey.afterThreeFails: "After three fails",
    TranslationKey.afterThreeFailsEliminate: "Eliminate",
    TranslationKey.afterThreeFailsNone: "Do Nothing",
    TranslationKey.afterThreeFailsResetPoints: "Reset Points",
    TranslationKey.next: "Next",
    TranslationKey.previous: "Previous",
    TranslationKey.player: "Player",
    TranslationKey.team: "Team",
    TranslationKey.chooseTeamName: "Choose team name",
    TranslationKey.enterScore: "Enter player score",
    TranslationKey.selectPins: "Select the pins that have fallen",
    TranslationKey.gameEnded: "Game ended",
    TranslationKey.eliminatedPlayers: "Eliminated players",
    TranslationKey.goToHome: "Go to home",
    TranslationKey.language: "Language",
    TranslationKey.system: "System",
    TranslationKey.theme: "Theme",
    TranslationKey.darkTheme: "Dark theme",
    TranslationKey.lightTheme: "Light theme",
    TranslationKey.about: "About",
    TranslationKey.aboutDescription:
        "This application was made by Vortezz to help you count points in a molkky game. It is open source and available on GitHub.",
    TranslationKey.aboutTerms:
        "The terms of use are available at this address:",
  };

  String? getTranslationFromName(TranslationKey translationKey) {
    return enTranslations[translationKey];
  }
}
