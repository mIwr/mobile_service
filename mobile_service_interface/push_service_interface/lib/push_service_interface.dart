import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/ps_remote_message.dart';
import 'push_service_cmd_mixin.dart';
import 'package:base_service_interface/base_service_interface.dart';

export 'package:base_service_interface/model/service_agent.dart';
export 'package:base_service_interface/model/service_config.dart';
export 'package:base_service_interface/base_service_interface.dart';

///Service interface for push messaging purposes
abstract class PushServiceInterface extends BaseServiceInterface with PushServiceCmdMixin {

  ///Preference key, which contains background message method pointer (Android-only)
  static const _prefUserCallbackKey = "ps_user_callback_key";

  ///Foreground message events controller
  static final StreamController<PSRemoteMessage> onMessageEventsController = StreamController.broadcast();
  /// Returns a Stream that is called when an incoming push payload is received whilst the Flutter instance is in the foreground
  ///
  /// The Stream contains the platform remote message
  static Stream<PSRemoteMessage> get onMessage => onMessageEventsController.stream;

  /// Set a message handler function which is called when the app is in the background or terminated.
  ///
  /// This provided handler must be a top-level function and cannot be anonymous
  /// For Android callback handlers used shared_preferences plugin: 'ps_user_callback_key' key (flutter.ps_user_callback_key) is reserved
  static Future<void> onBackgroundMessage(Future<void> Function(PSRemoteMessage message) handler) async {
    _onBackgroundMessageHandler = handler;
    if (!Platform.isAndroid) {
      return;
    }
    //Android -> get handler pointer and save to shared preferences
    final bgHandle = PluginUtilities.getCallbackHandle(handler);
    if (bgHandle == null) {
      return;
    }
    final rawHandle = bgHandle.toRawHandle();
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt(_prefUserCallbackKey, rawHandle);
  }
  
  static Future<void> Function(PSRemoteMessage message)? _onBackgroundMessageHandler;
  ///Background message handler
  static Future<void> Function(PSRemoteMessage message)? get onBackgroundMessageHandler => _onBackgroundMessageHandler;

  ///Restore background message handler by pointer (Android-only)
  static Future<Future<void> Function(PSRemoteMessage message)?> getBgMsgHandlerFromNonMainContext() async {
    final preferences = await SharedPreferences.getInstance();
    final rawHandle = preferences.getInt(_prefUserCallbackKey) ?? 0;
    if (rawHandle <= 0) {
      return null;
    }
    try {
      final handle = CallbackHandle.fromRawHandle(rawHandle);
      final func = PluginUtilities.getCallbackFromHandle(handle);
      if (func == null) {
        return null;
      }
      final handler = func as Future<void> Function(PSRemoteMessage message);

      return handler;
    } catch(error) {
      if (kDebugMode) {
        print(error);
      }
    }

    return null;
  }

  static final StreamController<PSRemoteMessage> onMessageOpenedAppEventsController = StreamController.broadcast();
  /// Returns a Stream that is called when a user presses a notification message
  ///
  /// A Stream event will be sent if the app has opened from a background state (not terminated).
  ///
  /// If your app is opened via a notification whilst the app is terminated, see [getInitialMessage].
  static Stream<PSRemoteMessage> get onMessageOpenedApp => onMessageOpenedAppEventsController.stream;
}
