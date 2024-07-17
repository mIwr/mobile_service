
import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'global_variables.dart';
import 'ui/advanced_analytics_observer.dart';
import 'ui/screens_enum.dart';
import 'ui/tab_bar_scaffold.dart';
import 'ui/status_bar_observer.dart';
import 'ui/system_nav_bar_observer.dart';
import 'ui/theme/app_day_theme.dart';
import 'ui/theme/app_night_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:example/generated/l10n.dart';

class ExampleApp extends StatefulWidget {

  final Widget? startScreen;
  final String initialRouteName;

  const ExampleApp({super.key, this.startScreen, required this.initialRouteName});

  @override
  State createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarObs = StatusBarObserver();
    final navBarObs = SystemNavBarObserver();
    AdvancedAnalyticsObserver? analyticsObs;
    try {
      analyticsObs = AdvancedAnalyticsObserver(analyticsService: AnalyticsService.instance);
    } catch (error) {
      print("Init analytics observer error $error");
    }

    return StreamBuilder<Locale>(stream: localeController.onLocaleChange, initialData: localeController.locale, builder: (context, snapshot) {
      final val = snapshot.data ?? localeController.locale;

      return FutureBuilder(future: S.load(val), builder: (context, loadSnapshot) {
        return StreamBuilder<ThemeMode>(stream: themeController.onThemeModeChange, initialData: themeController.mode, builder: (context, themeSnapshot) {
          final mode = themeSnapshot.data ?? themeController.mode;

          return MaterialApp(localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate
          ], navigatorObservers: kDebugMode ? [
            statusBarObs,
            navBarObs
          ] : [
            statusBarObs,
            navBarObs,
            if (analyticsObs != null)
              analyticsObs,
          ], supportedLocales: S.delegate.supportedLocales, navigatorKey: mainNavKey,
            routes: {
              kAnalyticsTabRouteKey: (context) => const TabBarScaffold(),
            },
            title: currAppName, home: widget.initialRouteName.isNotEmpty ? null : widget.startScreen,
            initialRoute: widget.initialRouteName,
            themeMode: mode, theme: AppDayTheme.themeData, darkTheme: AppNightTheme.themeData,
            debugShowCheckedModeBanner: false, showSemanticsDebugger: false,
          );
        });
      });
    });
  }
}