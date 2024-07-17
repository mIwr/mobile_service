
///Regular expression utils
abstract class RegExpUtil {

  ///Checks email format
  static bool emailValid({required String email}) {
    return RegExp(r"^(?:[\da-zA-Z]+[.\-+_#]?[\da-zA-Z]*)+[\da-zA-Z]+@[\da-zA-Zа-яА-Я\-]+\.[a-zA-Zа-яА-Я]+$").hasMatch(email);
  }
  ///Checks HTTP(-S) URL format
  static bool httpValid({required String httpUrl}) {
    return RegExp(r"^(https?)(:\/\/|(\%3A%2F%2F))").hasMatch(httpUrl);
  }
  ///Checks digit(-s) existence on password
  static bool passwordContainsDigit(String password) {
    return RegExp(r"[\d]+").hasMatch(password);
  }
  ///Checks lower-cased letter(-s) existence on password
  static bool passwordContainsLowercaseLetter(String password) {
    return RegExp(r"[a-z]+").hasMatch(password);
  }
  ///Checks upper-cased letter(-s) existence on password
  static bool passwordContainsUppercaseLetter(String password) {
    return RegExp(r"[A-Z]+").hasMatch(password);
  }
  ///Checks invalid chars existence on password
  static bool passwordContainsInvalidChars(String password) {
    return RegExp(r"[^\da-zA-Z!@#№.,;%^:&?*()_=+\-\[\]\/]+").hasMatch(password);
  }
  ///Checks on password digit(-s), lower- and upper-cased letters and no special characters
  static bool isGoodPassword(String password) {
    final containsRequiredBasis = passwordContainsDigit(password) && passwordContainsLowercaseLetter(password) && passwordContainsUppercaseLetter(password);
    final containsInvalidChars = passwordContainsInvalidChars(password);
    return containsRequiredBasis && !containsInvalidChars;
  }
}