import 'package:analytics_service_interface/analytics_service_interface.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

class AnalyticsServiceImpl implements AnalyticsServiceInterface {

  static const _loginEventName = "login";
  static const _loginMethodAttrName = "method";
  static const _signUpEventName = "signup";
  static const _signUpMethodAttrName = "method";
  static const _screenViewEventName = "screen_view";
  static const _screenNameAttrName = "screen_name";
  static const _screenClassAttrName = "screen_class";

  @override
  String get agentKey => ServiceAgentExt.kYandexAppMetricaAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.yandexAppMetrica;
  @override
  bool get canUse => UniversalPlatform.isAndroid || UniversalPlatform.isIOS;

  @override
  Future<void> init() async {
    throw UnimplementedError("Not supported init with default config. Use init method with your own config parameter");
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) async {
    if (!canUse) {
      print("Unsupported platform for AppMetrica analytics - " + UniversalPlatform.operatingSystem);
      return;
    }
    await AppMetrica.activateReporter(AppMetricaReporterConfig(config.apiKey, logs: kDebugMode));
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    if (!canUse) {
      return;
    }
    await AppMetrica.setDataSendingEnabled(enabled);
  }

  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {
    if (!canUse) {
      return;
    }
    final Map<String, Object> attributes = {};
    if (parameters == null) {
      await AppMetrica.reportEvent(name);
      return;
    }
    for (final entry in parameters.entries) {
      final entryVal = entry.value;
      if (entryVal == null) {
        attributes[entry.key] = "NULL";
        continue;
      }
      attributes[entry.key] = entryVal;
    }
    await AppMetrica.reportEventWithMap(name, attributes);
  }

  @override
  Future<void> logLogin({String? loginMethod}) async {
    if (!canUse) {
      return;
    }
    if (loginMethod == null || loginMethod.isEmpty) {
      await AppMetrica.reportEvent(_loginEventName);
      return;
    }
    final Map<String, Object> attributes = {
      _loginMethodAttrName: loginMethod
    };
    await AppMetrica.reportEventWithMap(_loginEventName, attributes);
  }

  @override
  Future<void> logSignUp({required String signUpMethod}) async {
    if (!canUse) {
      return;
    }
    if (signUpMethod.isEmpty) {
      await AppMetrica.reportEvent(_signUpEventName);
      return;
    }
    final Map<String, Object> attributes = {
      _signUpMethodAttrName: signUpMethod
    };
    await AppMetrica.reportEventWithMap(_signUpEventName, attributes);
  }

  @override
  Future<void> setCurrentScreen({required String? screenName, String screenClassOverride = 'Flutter'}) async {
    if (!canUse) {
      return;
    }
    final Map<String, Object> attributes = {
      _screenClassAttrName: screenClassOverride
    };
    if (screenName != null && screenName.isNotEmpty) {
      attributes[_screenNameAttrName] = screenName;
    }
    await AppMetrica.reportEventWithMap(_screenViewEventName, attributes);
  }

  @override
  Future<void> setUserId({String? id}) async {
    if (!canUse) {
      return;
    }
    await AppMetrica.setUserProfileID(id);
  }

  @override
  Future<void> setUserProperty({required String name, required String? value}) async {
    throw UnimplementedError();
  }
}