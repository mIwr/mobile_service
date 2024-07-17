import 'package:errlog_service_interface/errlog_service_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class ErrlogServiceImpl implements ErrlogServiceInterface {

  @override
  String get agentKey => ServiceAgentExt.kSentryAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.sentry;

  var _dsn = "";

  @override
  Future<void> init() async {
    throw UnimplementedError("Not supported.");
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) async {
    _dsn = config.dsn ?? config.apiKey;
    await SentryFlutter.init((options) {
      options.attachStacktrace = true;
      options.sendClientReports = true;
      options.enableNativeCrashHandling = true;
      options.enableWatchdogTerminationTracking = true;
      options.dsn = _dsn;
      //performance tracking settings
      options.tracesSampleRate = 1.0;
      options.enableAutoPerformanceTracing = true;
    });
  }

  @override
  Future<void> setLoggingEnabled(bool enabled) async {
    if (enabled == Sentry.isEnabled) {
      return;
    }
    if (!enabled) {
      await Sentry.close();
      return;
    }
    await SentryFlutter.init((options) {
      options.attachStacktrace = true;
      options.sendClientReports = true;
      options.enableNativeCrashHandling = true;
      options.enableWatchdogTerminationTracking = true;
      options.dsn = _dsn;
      //performance tracking settings
      options.tracesSampleRate = 1.0;
      options.enableAutoPerformanceTracing = true;
    });
  }

  @override
  Future<void> log(String message) async {
    await Sentry.captureEvent(SentryEvent(level: SentryLevel.info, message: SentryMessage(message)));
  }

  @override
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails, {bool fatal = false}) async {
    await Sentry.captureEvent(SentryEvent(throwable: flutterErrorDetails.exception, level: fatal ? SentryLevel.fatal : SentryLevel.error));
    await Sentry.captureException(flutterErrorDetails.exception, stackTrace: flutterErrorDetails.stack);
  }

  @override
  Future<void> recordError(exception, StackTrace? stack, {reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false}) async {
    await Sentry.captureEvent(SentryEvent(throwable: exception, level: fatal ? SentryLevel.fatal : SentryLevel.error, message: SentryMessage(information.map((e) => e.toString()).join(';'))));
    await Sentry.captureException(exception, stackTrace: stack);
  }
}