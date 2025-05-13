import 'package:agconnect_crash/agconnect_crash.dart';
import 'package:errlog_service_interface/errlog_service_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

class ErrlogServiceImpl implements ErrlogServiceInterface {

  @override
  String get agentKey => ServiceAgentExt.kHmsAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.hms;
  @override
  bool get canUse => UniversalPlatform.isAndroid || UniversalPlatform.isIOS;

  @override
  Future<void> init() async {
    if (!canUse) {
      print("Unsupported platform for HMS error logging - " + UniversalPlatform.operatingSystem);
      return;
    }
    return;
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) {
    throw UnimplementedError("Not supported");
  }

  @override
  Future<void> setLoggingEnabled(bool enabled) async {
    if (!canUse) {
      return;
    }
    await AGCCrash.instance.enableCrashCollection(enabled);
  }

  @override
  Future<void> log(String message) async {
    if (!canUse) {
      return;
    }
    await AGCCrash.instance.log(message: message);
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails, {bool fatal = false}) async {
    if (!canUse) {
      return;
    }
    await AGCCrash.instance.onFlutterError(flutterErrorDetails);
  }

  @override
  Future<void> recordError(exception, StackTrace? stack, {reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false}) async {
    if (!canUse) {
      return;
    }
    await AGCCrash.instance.recordError(exception, stack ?? StackTrace.current, fatal: false);
  }
}