
import 'dart:async';
import 'dart:ui';

class LocaleController {

  var _locale = const Locale("en");
  Locale get locale => _locale;
  set locale(Locale newVal) {
    if (_locale == newVal) {
      return;
    }
    _locale = newVal;
    _localeEventsController.add(_locale);
  }

  final StreamController<Locale> _localeEventsController = StreamController.broadcast();
  Stream<Locale> get onLocaleChange => _localeEventsController.stream;

  LocaleController({Locale initLocale = const Locale("en")}) {
    _locale = initLocale;
  }
}