
import 'dart:io';

import 'app.dart';
import 'app_http_overrides.dart';
import 'global_variables.dart';

import 'package:analytics_service/analytics_service.dart';
import 'package:errlog_service/errlog_service.dart';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:install_referrer/install_referrer.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'util/app_install_info_util.dart';
import 'ui/screens_enum.dart';
import 'ui/tab_bar_scaffold.dart';

abstract class LaunchHelper {

  static Future<void> initApp() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (Platform.isAndroid) {
      final androidPlatform = await DeviceInfoPlugin().androidInfo;
      final sdkVer = androidPlatform.version.sdkInt;
      if (sdkVer <= 26) {
        //Expired Let's crypt CA cert fix on Android <= 8.0
        HttpOverrides.global = AppHttpOverrides();
      }
    }

    final appInstallInfo = await InstallReferrer.app;
    appInstallSource = AppInstallInfoUtil.getAppInstallSourceString(appInstallInfo);

    await _initMobileServices();

    _readPackageInfo();

    Widget startScreen = const TabBarScaffold();
    const initialRouteName = kAnalyticsTabRouteKey;

    runApp(ExampleApp(startScreen: startScreen, initialRouteName: initialRouteName));
  }

  static Future<void> _initMobileServices() async {
    try {
      await AnalyticsService.instance.init();
      await ErrlogService.instance.init();
      FlutterError.onError = ErrlogService.instance.recordFlutterError;
      AnalyticsService.instance.setAnalyticsCollectionEnabled(true);
      ErrlogService.instance.setLoggingEnabled(true);
    } catch (error) {
      print("Remote messaging service unavailable: $error");
    }
  }

  static void _readPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    currAppName = packageInfo.appName;
    appBundleId = packageInfo.packageName;
    appVersionCode = packageInfo.version;
    appVersionNumber = int.tryParse(packageInfo.buildNumber) ?? 1;
  }
}