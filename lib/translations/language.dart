enum Language {
  en(0),
  fr(1),
  system(2);

  final int value;

  const Language(int i) : value = i;

  static Language getLanguageFromString(String language) {
    switch (language) {
      case "en":
        return Language.en;
      case "fr":
        return Language.fr;
      default:
        return Language.system;
    }
  }

  static Language getNext(Language language) {
    switch (language) {
      case en:
        return fr;
      case fr:
        return system;
      default:
        return en;
    }
  }

  static Language getPrevious(Language language) {
    switch (language) {
      case system:
        return fr;
      case fr:
        return en;
      default:
        return system;
    }
  }
}
