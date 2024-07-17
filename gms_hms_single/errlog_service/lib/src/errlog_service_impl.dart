
import 'package:errlog_service_gms/errlog_service.dart' as google;
import 'package:errlog_service_hms/errlog_service.dart' as huawei;
import 'package:errlog_service_interface/errlog_service_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_hms_gms_availability/flutter_hms_gms_availability.dart';

class ErrlogServiceImpl implements ErrlogServiceInterface {

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
      await google.ErrlogService.instance.init();
      return;
    }
    if (_hmsAvailable) {
      await huawei.ErrlogService.instance.init();
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

  Future<ErrlogServiceInterface?> _definePriorityService() async {
    await _refreshServiceAvailability();
    if (_gmsAvailable) {
      return google.ErrlogService.instance;
    }
    if (_hmsAvailable) {
      return huawei.ErrlogService.instance;
    }
    return null;
  }

  @override
  Future<void> log(String message) async {
    final service = await _definePriorityService();
    await service?.log(message);
  }

  @override
  Future<void> recordError(exception, StackTrace? stack, {reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false}) async {
    final service = await _definePriorityService();
    await service?.recordError(exception, stack, reason: reason, information: information, printDetails: printDetails, fatal: fatal);
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails, {bool fatal = false}) async {
    final service = await _definePriorityService();
    await service?.recordFlutterError(flutterErrorDetails, fatal: fatal);
  }

  @override
  Future<void> setLoggingEnabled(bool enabled) async {
    await _definePriorityService();
    if (_gmsAvailable) {
      await google.ErrlogService.instance.setLoggingEnabled(enabled);
      if (_hmsAvailable) {
        await huawei.ErrlogService.instance.setLoggingEnabled(false);
      }
      return;
    }
    if (_hmsAvailable) {
      await huawei.ErrlogService.instance.setLoggingEnabled(enabled);
      if (_gmsAvailable) {
        await google.ErrlogService.instance.setLoggingEnabled(false);
      }
    }
  }

}