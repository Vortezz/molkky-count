import 'package:molkkycount/translations/translations_key.dart';

class FrenchTranslation {
  Map<TranslationKey, String> enTranslations = {
    TranslationKey.description:
        "Compter les points du molkky est maintenant un jeu d'enfant !",
    TranslationKey.startGame: "Démarrer une partie",
    TranslationKey.settings: "Paramètres",
    TranslationKey.gameHistory: "Historique des parties",
    TranslationKey.gameSettings: "Paramètres de la partie",
    TranslationKey.players: "Joueurs",
    TranslationKey.mode: "Mode de partie",
    TranslationKey.cosyMode: "Cosy",
    TranslationKey.compactMode: "Compact",
    TranslationKey.afterThreeFails: "Après 3 échecs",
    TranslationKey.afterThreeFailsEliminate: "Eliminer",
    TranslationKey.afterThreeFailsNone: "Ne rien faire",
    TranslationKey.afterThreeFailsResetPoints: "Retour à zéro",
    TranslationKey.next: "Suivant",
    TranslationKey.previous: "Précédent",
    TranslationKey.player: "Joueur",
    TranslationKey.team: "Equipe",
    TranslationKey.chooseTeamName: "Choisissez le nom de l'équipe",
    TranslationKey.enterScore: "Entrez le score du joueur",
    TranslationKey.selectPins: "Selectionnez les quilles tombées",
    TranslationKey.gameEnded: "La partie est terminée",
    TranslationKey.eliminatedPlayers: "Joueurs éliminés",
    TranslationKey.goToHome: "Retourner au menu",
    TranslationKey.language: "Langue",
    TranslationKey.theme: "Thème",
    TranslationKey.system: "Système",
    TranslationKey.darkTheme: "Thème sombre",
    TranslationKey.lightTheme: "Thème clair",
    TranslationKey.about: "A propos",
    TranslationKey.aboutDescription:
        "Cette application a été réalisée par Vortezz pour vous aider à compter les points d'une partie de molkky. Elle est open source et disponible sur GitHub.",
    TranslationKey.aboutTerms:
        "Les conditions d'utilisation sont disponibles à cette adresse :",
  };

  String? getTranslationFromName(TranslationKey translationKey) {
    return enTranslations[translationKey];
  }
}
