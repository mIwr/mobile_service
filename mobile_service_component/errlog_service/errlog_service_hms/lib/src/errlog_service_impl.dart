import 'package:agconnect_crash/agconnect_crash.dart';
import 'package:errlog_service_interface/errlog_service_interface.dart';
import 'package:flutter/foundation.dart';

class ErrlogServiceImpl implements ErrlogServiceInterface {

  @override
  String get agentKey => ServiceAgentExt.kHmsAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.hms;

  @override
  Future<void> init() async {
    return;
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) {
    throw UnimplementedError("Not supported");
  }

  @override
  Future<void> setLoggingEnabled(bool enabled) async {
    return AGCCrash.instance.enableCrashCollection(enabled);
  }

  @override
  Future<void> log(String message) async {
    return AGCCrash.instance.log(message: message);
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails, {bool fatal = false}) async {
    return AGCCrash.instance.onFlutterError(flutterErrorDetails);
  }

  @override
  Future<void> recordError(exception, StackTrace? stack, {reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false}) async {
    return AGCCrash.instance.recordError(exception, stack ?? StackTrace.current, fatal: false);
  }
}