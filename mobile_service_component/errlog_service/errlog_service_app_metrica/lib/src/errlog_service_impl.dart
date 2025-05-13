import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:errlog_service_interface/errlog_service_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

class ErrlogServiceImpl implements ErrlogServiceInterface {

  @override
  String get agentKey => ServiceAgentExt.kYandexAppMetricaAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.yandexAppMetrica;
  @override
  bool get canUse => UniversalPlatform.isAndroid || UniversalPlatform.isIOS;

  @override
  Future<void> init() async {
    throw UnimplementedError("Not supported init with default config. Use init method with your own config parameters");
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) async {
    if (!canUse) {
      print("Unsupported platform for AppMetrica error logging - " + UniversalPlatform.operatingSystem);
      return;
    }
    await AppMetrica.activateReporter(AppMetricaReporterConfig(config.apiKey, logs: kDebugMode));
  }

  @override
  Future<void> setLoggingEnabled(bool enabled) async {
    if (!canUse) {
      return;
    }
    //Sync with analytics enabled options
    await AppMetrica.setDataSendingEnabled(enabled);
  }

  @override
  Future<void> log(String message) async {
    if (!canUse) {
      return;
    }
    await AppMetrica.reportEvent(message);
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails, {bool fatal = false}) async {
    if (!canUse) {
      return;
    }
    final msg = flutterErrorDetails.context?.name ?? "Unknown error name";
    final stackTrace = flutterErrorDetails.stack;
    await AppMetrica.reportError(message: msg, errorDescription: stackTrace == null ? null : AppMetricaErrorDescription(stackTrace));
  }

  @override
  Future<void> recordError(exception, StackTrace? stack, {reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false}) async {
    if (!canUse) {
      return;
    }
    final msg = exception?.toString() ?? "Unknown error name";
    final String info = information.isEmpty
        ? ''
        : (StringBuffer()..writeAll(information, '\n')).toString();
    AppMetricaErrorDescription? desc;
    if (stack != null) {
      desc = AppMetricaErrorDescription(stack, message: info);
    }
    await AppMetrica.reportError(message: msg, errorDescription: desc);
  }
}