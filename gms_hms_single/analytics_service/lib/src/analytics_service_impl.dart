
import 'package:analytics_service/analytics_service.dart';
import 'package:analytics_service_gms/analytics_service.dart' as google;
import 'package:analytics_service_hms/analytics_service.dart' as huawei;
import 'package:analytics_service_interface/analytics_service_interface.dart';
import 'package:flutter_hms_gms_availability/flutter_hms_gms_availability.dart';

class AnalyticsServiceImpl implements AnalyticsServiceInterface {

  var _gmsAvailable = false;
  bool get gmsAvailable => _gmsAvailable;
  var _hmsAvailable = false;
  bool get hmsAvailable => _hmsAvailable;

  @override
  ServiceAgent? get agent {
    if (_gmsAvailable) {
      return ServiceAgent.gms;
    }
    if (_hmsAvailable) {
      return ServiceAgent.hms;
    }
    return null;
  }

  @override
  String get agentKey {
    if (_gmsAvailable) {
      return ServiceAgentExt.kGmsAgentKey;
    }
    if (_hmsAvailable) {
      return ServiceAgentExt.kHmsAgentKey;
    }
    return ServiceAgentExt.kGmsAgentKey;
  }

  @override
  Future<void> init() async {
    await _refreshServiceAvailability();
    if (_gmsAvailable) {
      await google.AnalyticsService.instance.init();
      return;
    }
    if (_hmsAvailable) {
      await huawei.AnalyticsService.instance.init();
    }
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) async {
    throw UnimplementedError("Not supported");
  }

  Future<void> _refreshServiceAvailability() async {
    _gmsAvailable = await FlutterHmsGmsAvailability.isGmsAvailable;
    _hmsAvailable = await FlutterHmsGmsAvailability.isHmsAvailable;
  }

  Future<AnalyticsServiceInterface?> _definePriorityService() async {
    await _refreshServiceAvailability();
    if (_gmsAvailable) {
      return google.AnalyticsService.instance;
    }
    if (_hmsAvailable) {
      return huawei.AnalyticsService.instance;
    }
    return null;
  }

  @override
  Future<void> logEvent({required String name, Map<String, Object>? parameters}) async {
    final service = await _definePriorityService();
    await service?.logEvent(name: name, parameters: parameters);
  }

  @override
  Future<void> logLogin({String? loginMethod}) async {
    final service = await _definePriorityService();
    await service?.logLogin(loginMethod: loginMethod);
  }

  @override
  Future<void> logSignUp({required String signUpMethod}) async {
    final service = await _definePriorityService();
    await service?.logSignUp(signUpMethod: signUpMethod);
  }

  @override
  Future<void> setAnalyticsCollectionEnabled(bool enabled) async {
    await _definePriorityService();
    if (_gmsAvailable) {
      await google.AnalyticsService.instance.setAnalyticsCollectionEnabled(enabled);
      if (_hmsAvailable) {
        await huawei.AnalyticsService.instance.setAnalyticsCollectionEnabled(false);
      }
      return;
    }
    if (_hmsAvailable) {
      await huawei.AnalyticsService.instance.setAnalyticsCollectionEnabled(enabled);
      if (_gmsAvailable) {
        await google.AnalyticsService.instance.setAnalyticsCollectionEnabled(false);
      }
    }
  }

  @override
  Future<void> setCurrentScreen({required String? screenName, String screenClassOverride = 'Flutter'}) async {
    final service = await _definePriorityService();
    await service?.setCurrentScreen(screenName: screenName, screenClassOverride: screenClassOverride);
  }

  @override
  Future<void> setUserId({String? id}) async {
    final service = await _definePriorityService();
    await service?.setUserId(id: id);
  }

  @override
  Future<void> setUserProperty({required String name, required String? value}) async {
    final service = await _definePriorityService();
    await service?.setUserProperty(name: name, value: value);
  }
}