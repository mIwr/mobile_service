
import 'package:flutter/widgets.dart';

enum Screens {

  analyticsTab, routeLog,

  errlogTab,

  pushTab
}

const kAnalyticsTabRouteKey = "/analytics";
const kRouteLogRouteKey = "/analytics/route";

const kErrlogTabRouteKey = "/errlog";

const kPushTabRouteKey = "/push";

extension ScreensExt on Screens {

  static Screens? from(String routeName) {
    switch (routeName) {
      case kAnalyticsTabRouteKey: return Screens.analyticsTab;
      case kRouteLogRouteKey: return Screens.routeLog;

      case kErrlogTabRouteKey: return Screens.errlogTab;

      case kPushTabRouteKey: return Screens.pushTab;
    }

    return null;
  }

  RouteSettings routeSettings ({Object? arguments}) => RouteSettings(name: routeName, arguments: arguments);

  String get routeName {
    switch (this) {
      case Screens.analyticsTab: return kAnalyticsTabRouteKey;
      case Screens.routeLog: return kRouteLogRouteKey;

      case Screens.errlogTab: return kErrlogTabRouteKey;

      case Screens.pushTab: return kPushTabRouteKey;
    }
  }

  String get className {
    switch (this) {
      case Screens.analyticsTab: return "AnalyticsScreen";
      case Screens.routeLog: return "RouteLogScreen";

      case Screens.errlogTab: return "ErrlogScreen";

      case Screens.pushTab: return "PushScreen";
    }
  }
}