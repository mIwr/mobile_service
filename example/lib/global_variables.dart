
import 'package:example/controller/locale_controller.dart';
import 'package:example/controller/theme_controller.dart';
import 'package:flutter/cupertino.dart';

///Push action handler navigation context
final mainNavKey = GlobalKey<NavigatorState>();

final tabBarController = CupertinoTabController();

///Read from native app version code
var appVersionCode = "";
///Read from native app version number
var appVersionNumber = 0;
///Formatted app version
String get appVersion {
  return '$appVersionCode($appVersionNumber)';
}
String get appVersionWithInstallInfo {
  return "$appVersion - $appInstallSource";
}
///Read from native app install source
var appInstallSource = "";

///Read from native app name
var currAppName = "";
///Read from native app bundle ID
var appBundleId = "";

///App theme mode controller
final themeController = ThemeController();
///App locale controller
final localeController = LocaleController();