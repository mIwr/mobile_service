import 'package:analytics_service_interface/analytics_service_interface.dart';
import 'package:huawei_analytics/huawei_analytics.dart';
import 'package:universal_platform/universal_platform.dart';

class AnalyticsServiceImpl implements AnalyticsServiceInterface {

  var _screenName = "";
  var _screenClassName = "";
  HMSAnalytics? _service;

  @override
  String get agentKey => ServiceAgentExt.kHmsAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.hms;
  @override
  bool get canUse => UniversalPlatform.isAndroid || UniversalPlatform.isIOS;

  @override
  Future<void> init() async {
    if (!canUse) {
      print("Unsupported platform for HMS analytics - " + UniversalPlatform.operatingSystem);
      return;
    }
    _service ??= await HMSAnalytics.getInstance();
    await _service?.enableLog();
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) {
    throw UnimplementedError("Not supported");
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    if (!canUse) {
      return;
    }
    final service = _service ?? await HMSAnalytics.getInstance();
    await service.setAnalyticsEnabled(enabled);
  }

  @override
  Future<void> logEvent({required String name, Map<String, Object>? parameters}) async {
    if (!canUse) {
      return;
    }
    final service = _service ?? await HMSAnalytics.getInstance();
    await service.onEvent(name, parameters ?? {});
  }

  @override
  Future<void> logLogin({String? loginMethod}) async {
    if (!canUse) {
      return;
    }
    final Map<String, Object> paramMap = {};
    if (loginMethod != null && loginMethod.isNotEmpty) {
      paramMap["method"] = loginMethod;
    }
    await logEvent(name: "login", parameters: paramMap);
  }

  @override
  Future<void> logSignUp({required String signUpMethod}) async {
    if (!canUse) {
      return;
    }
    await logEvent(name: "sign_up", parameters: {
      "method": signUpMethod
    });
  }

  @override
  Future<void> setCurrentScreen({required String? screenName, String screenClassOverride = 'Flutter'}) async {
    if (!canUse) {
      return;
    }
    final service = _service ?? await HMSAnalytics.getInstance();
    if (_screenName.isEmpty) {
      _screenName = screenName ?? "FlutterScreen";
      _screenClassName = screenClassOverride;
      await service.pageStart(_screenName, _screenClassName);
      return;
    }
    await service.pageEnd(_screenName);
    _screenName = screenName ?? "FlutterScreen";
    _screenClassName = screenClassOverride;

    await service.pageStart(_screenName, _screenClassName);
  }

  @override
  Future<void> setUserId({String? id}) async {
    if (!canUse) {
      return;
    }
    final service = _service ?? await HMSAnalytics.getInstance();
    await service.setUserId(id);
  }

  @override
  Future<void> setUserProperty({required String name, required String? value}) async {
    if (!canUse) {
      return;
    }
    final service = _service ?? await HMSAnalytics.getInstance();
    await service.setUserProfile(name, value ?? "");
  }
}