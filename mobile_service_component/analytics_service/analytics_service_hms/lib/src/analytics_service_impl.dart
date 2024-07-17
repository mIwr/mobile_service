import 'package:analytics_service_interface/analytics_service_interface.dart';
import 'package:huawei_analytics/huawei_analytics.dart';

class AnalyticsServiceImpl implements AnalyticsServiceInterface {

  var _screenName = "";
  var _screenClassName = "";
  HMSAnalytics? _service;

  @override
  String get agentKey => ServiceAgentExt.kHmsAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.hms;

  @override
  Future<void> init() async {
    _service ??= await HMSAnalytics.getInstance();
    await _service?.enableLog();
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) {
    throw UnimplementedError("Not supported");
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    final service = _service ?? await HMSAnalytics.getInstance();
    return service.setAnalyticsEnabled(enabled);
  }

  @override
  Future<void> logEvent({required String name, Map<String, Object>? parameters}) async {
    final service = _service ?? await HMSAnalytics.getInstance();
    return service.onEvent(name, parameters ?? {});
  }

  @override
  Future<void> logLogin({String? loginMethod}) {
    final Map<String, Object> paramMap = {};
    if (loginMethod != null && loginMethod.isNotEmpty) {
      paramMap["method"] = loginMethod;
    }
    return logEvent(name: "login", parameters: paramMap);
  }

  @override
  Future<void> logSignUp({required String signUpMethod}) {
    return logEvent(name: "sign_up", parameters: {
      "method": signUpMethod
    });
  }

  @override
  Future<void> setCurrentScreen({required String? screenName, String screenClassOverride = 'Flutter'}) async {
    final service = _service ?? await HMSAnalytics.getInstance();
    if (_screenName.isEmpty) {
      _screenName = screenName ?? "FlutterScreen";
      _screenClassName = screenClassOverride;
      return service.pageStart(_screenName, _screenClassName);
    }
    await service.pageEnd(_screenName);
    _screenName = screenName ?? "FlutterScreen";
    _screenClassName = screenClassOverride;

    return service.pageStart(_screenName, _screenClassName);
  }

  @override
  Future<void> setUserId({String? id}) async {
    final service = _service ?? await HMSAnalytics.getInstance();

    return service.setUserId(id);
  }

  @override
  Future<void> setUserProperty({required String name, required String? value}) async {
    final service = _service ?? await HMSAnalytics.getInstance();

    return service.setUserProfile(name, value ?? "");
  }
}