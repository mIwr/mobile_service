
import 'package:flutter/foundation.dart';

///Error logging service functions mixin
mixin ErrlogServiceCmdMixin {

  /// Enables/disables automatic data collection.
  Future<void> setLoggingEnabled(bool enabled);

  /// Logs a message that's included in the next fatal or non-fatal report.
  Future<void> log(String message);

  /// Submits a report of an error caught by the Flutter framework.
  /// Use [fatal] to indicate whether the error is a fatal or not.
  Future<void> recordFlutterError(FlutterErrorDetails flutterErrorDetails, {bool fatal = false});

  /// Submits a report of a caught error.
  Future<void> recordError(dynamic exception, StackTrace? stack, {dynamic reason, Iterable<Object> information = const [], bool? printDetails, bool fatal = false});
}