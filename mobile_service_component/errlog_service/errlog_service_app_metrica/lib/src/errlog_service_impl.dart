import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:errlog_service_interface/errlog_service_interface.dart';
import 'package:flutter/foundation.dart';

class ErrlogServiceImpl implements ErrlogServiceInterface {

  @override
  String get agentKey => ServiceAgentExt.kYandexAppMetricaAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.yandexAppMetrica;

  @override
  Future<void> init() async {
    throw UnimplementedError("Not supported init with default config. Use init method with your own config parameters");
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) {
    return AppMetrica.activateReporter(ReporterConfig(config.apiKey, logs: kDebugMode));
  }

  @override
  Future<void> setLoggingEnabled(bool enabled) {
    //Sync with analytics enabled options
    return AppMetrica.setDataSendingEnabled(enabled);
  }

  @override
  Future<void> log(String message) {
    return AppMetrica.reportEvent(message);
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails, {bool fatal = false}) {
    final msg = flutterErrorDetails.context?.name ?? "Unknown error name";
    final stackTrace = flutterErrorDetails.stack;
    return AppMetrica.reportError(message: msg, errorDescription: stackTrace == null ? null : AppMetricaErrorDescription(stackTrace));
  }

  @override
  Future<void> recordError(exception, StackTrace? stack, {reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false}) {
    final msg = exception?.toString() ?? "Unknown error name";
    final String info = information.isEmpty
        ? ''
        : (StringBuffer()..writeAll(information, '\n')).toString();
    AppMetricaErrorDescription? desc;
    if (stack != null) {
      desc = AppMetricaErrorDescription(stack, message: info);
    }
    return AppMetrica.reportError(message: msg, errorDescription: desc);
  }
}