

import '../global_variables.dart';
import '../util/status_bar_util.dart';
import '../util/theme_util.dart';
import 'screens_enum.dart';
import 'status_bar_state.dart';
import 'theme/app_day_theme.dart';
import 'theme/app_night_theme.dart';

import 'package:flutter/material.dart';

///System status bar refresh observer
class StatusBarObserver extends RouteObserver<ModalRoute<dynamic>> with WidgetsBindingObserver {

  Route? _lastRoute;
  ///Status bar states map for screens in navigator
  final Map<String, StatusBarState> _statusBarStates = {};

  StatusBarObserver() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangePlatformBrightness() {
    super.didChangePlatformBrightness();
    final route = _lastRoute;
    if (_statusBarStates.isEmpty || route == null) {
      //No active screen
      return;
    }
    _processNavigationUpdate(route: route);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final prevRouteName = previousRoute?.settings.name;
    if (prevRouteName != null) {
      _statusBarStates[prevRouteName] = StatusBarState(backgroundColor: StatusBarUtil.bgColor, foregroundStyle: StatusBarUtil.fgStyle);
    }
    _lastRoute = route;
    _processNavigationUpdate(route: route);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final routeName = previousRoute?.settings.name;
    _lastRoute = previousRoute;
    final statusBarState = _statusBarStates[routeName];
    super.didPop(route, previousRoute);
    if (statusBarState == null) {
      if (previousRoute != null) {
        _processNavigationUpdate(route: previousRoute);
      }
      return;
    }
    StatusBarUtil.transformStatusBar(bgColor: statusBarState.backgroundColor, fgStyle: statusBarState.foregroundStyle);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    if (newRoute == null) {
      super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
      return;
    }
    _lastRoute = newRoute;
    _processNavigationUpdate(route: newRoute);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    final routeName = route.settings.name;
    if (routeName == null) {
      return;
    }
    _statusBarStates.remove(routeName);
  }

  Future<void> _processNavigationUpdate({required Route route}) async {
    final screen = ScreensExt.from(route.settings.name ?? "");
    if (screen == null) {
      return;
    }

    final transparentBg = Colors.transparent;
    var coloredBg = Colors.white;
    final context = route.navigator?.context;
    if (context != null) {
      var currTheme = Theme.of(context);
      final themeModeBrightness = ThemeUtil.fromThemeMode(themeController.mode);
      if (themeModeBrightness != null) {
        //User manual brightness change
        currTheme = themeModeBrightness == Brightness.light ? AppDayTheme.themeData : AppNightTheme.themeData;
      } else {
        final themeBrightness = currTheme.brightness;
        final currBrightness = ThemeUtil.getCurrModeByFlutterPlatform();
        if (themeBrightness != currBrightness) {
          //System brightness change
          currTheme = currBrightness == Brightness.light ? AppDayTheme.themeData : AppNightTheme.themeData;
        }
      }
      coloredBg = currTheme.colorScheme.primaryContainer;
    }

    switch(screen) {
      case Screens.analyticsTab:
        await StatusBarUtil.transformByBg(bgColor: coloredBg);
        break;
      case Screens.routeLog:
        await StatusBarUtil.transformByBg(bgColor: coloredBg);
        break;
      case Screens.errlogTab:
        await StatusBarUtil.transformByBg(bgColor: coloredBg);
        break;
      case Screens.pushTab:
        await StatusBarUtil.transformByBg(bgColor: coloredBg);
        break;
    }
  }
}