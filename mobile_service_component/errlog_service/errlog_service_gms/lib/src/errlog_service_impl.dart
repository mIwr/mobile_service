import 'package:errlog_service_interface/errlog_service_interface.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

class ErrlogServiceImpl implements ErrlogServiceInterface {

  @override
  String get agentKey => ServiceAgentExt.kGmsAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.gms;
  @override
  bool get canUse => UniversalPlatform.isAndroid || UniversalPlatform.isIOS || UniversalPlatform.isMacOS;

  @override
  Future<void> init() async {
    if (!canUse) {
      print("Unsupported platform for Firebase Crashlytics - " + UniversalPlatform.operatingSystem);
      return;
    }
    await Firebase.initializeApp();
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) async {
    throw UnimplementedError("Not supported");
    //await Firebase.initializeApp(name: config.projectId ?? "", options: FirebaseOptions(apiKey: config.apiKey, appId: config.appId ?? "", messagingSenderId: config.messagingSenderId ?? "", projectId: config.projectId ?? ""));
  }

  @override
  Future<void> setLoggingEnabled(bool enabled) async {
    if (!canUse) {
      return;
    }
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(enabled);
  }

  @override
  Future<void> log(String message) async {
    if (!canUse) {
      return;
    }
    await FirebaseCrashlytics.instance.log(message);
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails, {bool fatal = false}) async {
    if (!canUse) {
      return;
    }
    await FirebaseCrashlytics.instance.recordFlutterError(flutterErrorDetails, fatal: fatal);
  }

  @override
  Future<void> recordError(exception, StackTrace? stack, {reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false}) async {
    if (!canUse) {
      return;
    }
    await FirebaseCrashlytics.instance.recordError(exception, stack, reason: reason, information: information, printDetails: printDetails, fatal: fatal);
  }
}