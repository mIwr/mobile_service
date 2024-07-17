import 'package:analytics_service_interface/analytics_service_interface.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';

class AnalyticsServiceImpl implements AnalyticsServiceInterface {

  @override
  String get agentKey => ServiceAgentExt.kGmsAgentKey;

  @override
  ServiceAgent? get agent => ServiceAgent.gms;

  @override
  Future<void> init() async {
    await Firebase.initializeApp();
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) async {
    throw UnimplementedError("Not supported");
    //await Firebase.initializeApp(name: config.projectId ?? "", options: FirebaseOptions(apiKey: config.apiKey, appId: config.appId ?? "", messagingSenderId: config.messagingSenderId ?? "", projectId: config.projectId ?? ""));
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) {
    return FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(enabled);
  }

  @override
  Future<void> logEvent({required String name, Map<String, Object>? parameters}) {
    return FirebaseAnalytics.instance.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> logLogin({String? loginMethod}) {
    return FirebaseAnalytics.instance.logLogin(loginMethod: loginMethod);
  }

  @override
  Future<void> logSignUp({required String signUpMethod}) {
    return FirebaseAnalytics.instance.logSignUp(signUpMethod: signUpMethod);
  }

  @override
  Future<void> setCurrentScreen({required String? screenName, String screenClassOverride = 'Flutter'}) {
    return FirebaseAnalytics.instance.logScreenView(screenName: screenName, screenClass: screenClassOverride);
  }

  @override
  Future<void> setUserId({String? id}) {
    return FirebaseAnalytics.instance.setUserId(id: id);
  }

  @override
  Future<void> setUserProperty({required String name, required String? value}) {
    return FirebaseAnalytics.instance.setUserProperty(name: name, value: value);
  }
}