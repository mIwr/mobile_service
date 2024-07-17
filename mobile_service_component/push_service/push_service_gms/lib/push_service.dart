import 'dart:async';

import 'src/push_service_impl.dart';
import 'package:push_service_interface/model/ps_remote_message.dart';
import 'package:push_service_interface/push_service_interface.dart';

export 'package:push_service_interface/push_service_interface.dart';
export 'package:push_service_interface/model/ps_remote_message.dart';

abstract class PushService {

  static String get agentKey => ServiceAgentExt.kGmsAgentKey;
  static ServiceAgent get agent => ServiceAgent.gms;

  static PushServiceInterface? _service;

  static PushServiceInterface get instance {
    var service = _service;
    if (service != null) {
      return service;
    }
    service = PushServiceImpl();
    _service = service;

    return service;
  }

  /// Returns a Stream that is called when an incoming push payload is received whilst
  /// the Flutter instance is in the foreground
  ///
  /// The Stream contains the platform remote message
  static Stream<PSRemoteMessage> get onMessage => PushServiceInterface.onMessage;

  /// Set a message handler function which is called when the app is in the background or terminated.
  ///
  /// This provided handler must be a top-level function and cannot be anonymous
  /// For Android callback handlers used shared_preferences plugin: 'ps_user_callback_key' key (flutter.ps_user_callback_key) is reserved
  static void onBackgroundMessage(Future<void> Function(PSRemoteMessage message) handler) {
    PushServiceInterface.onBackgroundMessage(handler);
  }

  /// Returns a Stream that is called when a user presses a notification message displayed
  /// via FCM.
  ///
  /// A Stream event will be sent if the app has opened from a background state
  /// (not terminated).
  ///
  /// If your app is opened via a notification whilst the app is terminated,
  /// see [getInitialMessage].
  static Stream<PSRemoteMessage> get onMessageOpenedApp => PushServiceInterface.onMessageOpenedApp;
}
