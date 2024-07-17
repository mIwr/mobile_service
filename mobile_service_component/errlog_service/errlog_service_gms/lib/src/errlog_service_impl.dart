import 'package:errlog_service_interface/errlog_service_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class ErrlogServiceImpl implements ErrlogServiceInterface {

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
  Future<void> setLoggingEnabled(bool enabled) {
    return FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled);
  }

  @override
  Future<void> log(String message) {
    return FirebaseCrashlytics.instance.log(message);
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails, {bool fatal = false}) {
    return FirebaseCrashlytics.instance.recordFlutterError(flutterErrorDetails, fatal: fatal);
  }

  @override
  Future<void> recordError(exception, StackTrace? stack, {reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false}) {
    return FirebaseCrashlytics.instance.recordError(exception, stack, reason: reason, information: information, printDetails: printDetails, fatal: fatal);
  }
}