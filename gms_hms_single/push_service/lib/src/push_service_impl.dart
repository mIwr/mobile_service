
import 'package:push_service/push_service.dart';
import 'package:push_service_gms/push_service.dart' as google;
import 'package:push_service_hms/push_service.dart' as huawei;
import 'package:flutter_hms_gms_availability/flutter_hms_gms_availability.dart';
import 'package:push_service_interface/model/ps_remote_message.dart';

class PushServiceImpl implements PushServiceInterface {

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
      await google.PushService.instance.init();
      return;
    }
    if (_hmsAvailable) {
      await huawei.PushService.instance.init();
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

  Future<PushServiceInterface?> _definePriorityService() async {
    await _refreshServiceAvailability();
    if (_gmsAvailable) {
      return google.PushService.instance;
    }
    if (_hmsAvailable) {
      return huawei.PushService.instance;
    }
    return null;
  }

  @override
  Future<void> cancelAllNotifications() async {
    final service = await _definePriorityService();
    await service?.cancelAllNotifications();
  }

  @override
  Future<void> deleteToken() async {
    final service = await _definePriorityService();
    await service?.deleteToken();
  }

  @override
  Future<PSRemoteMessage?> getInitialMessage() async {
    final service = await _definePriorityService();
    return await service?.getInitialMessage();
  }

  @override
  Future<String?> getToken() async {
    final service = await _definePriorityService();
    return service?.getToken();
  }

  @override
  Future<void> setForegroundNotificationPresentationOptions({bool alert = false, bool badge = false, bool sound = false}) async {
    final service = await _definePriorityService();
    await service?.setForegroundNotificationPresentationOptions(alert: alert, badge: badge, sound: sound);
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    final service = await _definePriorityService();
    await service?.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    final service = await _definePriorityService();
    await service?.unsubscribeFromTopic(topic);
  }

}