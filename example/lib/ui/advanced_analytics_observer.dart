
import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens_enum.dart';

class AdvancedAnalyticsObserver extends RouteObserver<ModalRoute<dynamic>> {

  AdvancedAnalyticsObserver({
    required this.analyticsService,
    this.nameExtractor = defaultNameExtractor,
    this.classNameExtractor = defaultClassNameExtractor,
    this.routeFilter = simpleRouteFilter,
    Function(PlatformException error)? onError,
  }) : _onError = onError;

  final AnalyticsServiceInterface analyticsService;
  final String? Function(RouteSettings settings) nameExtractor;
  final String Function(RouteSettings settings) classNameExtractor;
  final bool Function(Route<dynamic>? route) routeFilter;
  final void Function(PlatformException error)? _onError;

  void _sendScreenView(Route<dynamic> route) {
    final String? screenName = nameExtractor(route.settings);
    final String className = classNameExtractor(route.settings);
    if (screenName != null) {
      analyticsService.setCurrentScreen(screenName: screenName, screenClassOverride: className).catchError(
            (Object error) {
          final onError = _onError;
          if (onError == null) {
            print('Analytics observer error: $error');
          } else {
            onError(error as PlatformException);
          }
        },
        test: (Object error) => error is PlatformException,
      );
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (routeFilter(route)) {
      _sendScreenView(route);
    }
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute != null && routeFilter(newRoute)) {
      _sendScreenView(newRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (previousRoute != null &&
        routeFilter(previousRoute) &&
        routeFilter(route)) {
      _sendScreenView(previousRoute);
    }
  }
}

String? defaultNameExtractor(RouteSettings settings) => settings.name;

String defaultClassNameExtractor(RouteSettings settings) {
  final screen = ScreensExt.from(settings.name ?? "");

  return screen?.className ?? "Flutter";
}

bool simpleRouteFilter(Route<dynamic>? route) => route is PageRoute || route is DialogRoute;