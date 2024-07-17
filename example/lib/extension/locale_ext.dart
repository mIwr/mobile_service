
import 'dart:ui';

extension LocaleExt on Locale {

  String get languageName {
    switch(languageCode.toLowerCase()) {
      case "en": return "English";
      case "ru": return "Русский";
    }

    return toLanguageTag();
  }
}