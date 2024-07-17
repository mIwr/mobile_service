import 'package:analytics_service_interface/analytics_service_interface.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:flutter/foundation.dart';

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
  Future<void> init() async {
    throw UnimplementedError("Not supported init with default config. Use init method with your own config parameter");
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) {
    return AppMetrica.activateReporter(ReporterConfig(config.apiKey, logs: kDebugMode));
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) {
    return AppMetrica.setDataSendingEnabled(enabled);
  }

  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) {
    final Map<String, Object> attributes = {};
    if (parameters == null) {
      return AppMetrica.reportEvent(name);
    }
    for (final entry in parameters.entries) {
      final entryVal = entry.value;
      if (entryVal == null) {
        attributes[entry.key] = "NULL";
        continue;
      }
      attributes[entry.key] = entryVal;
    }
    return AppMetrica.reportEventWithMap(name, attributes);
  }

  @override
  Future<void> logLogin({String? loginMethod}) {
    if (loginMethod == null || loginMethod.isEmpty) {
      return AppMetrica.reportEvent(_loginEventName);
    }
    final Map<String, Object> attributes = {
      _loginMethodAttrName: loginMethod
    };
    return AppMetrica.reportEventWithMap(_loginEventName, attributes);
  }

  @override
  Future<void> logSignUp({required String signUpMethod}) {
    if (signUpMethod.isEmpty) {
      return AppMetrica.reportEvent(_signUpEventName);
    }
    final Map<String, Object> attributes = {
      _signUpMethodAttrName: signUpMethod
    };
    return AppMetrica.reportEventWithMap(_signUpEventName, attributes);
  }

  @override
  Future<void> setCurrentScreen({required String? screenName, String screenClassOverride = 'Flutter'}) {
    final Map<String, Object> attributes = {
      _screenClassAttrName: screenClassOverride
    };
    if (screenName != null && screenName.isNotEmpty) {
      attributes[_screenNameAttrName] = screenName;
    }
    return AppMetrica.reportEventWithMap(_screenViewEventName, attributes);
  }

  @override
  Future<void> setUserId({String? id}) {
    return AppMetrica.setUserProfileID(id);
  }

  @override
  Future<void> setUserProperty({required String name, required String? value}) async {
    throw UnimplementedError();
  }
}