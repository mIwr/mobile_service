
import 'package:push_service_interface/model/ps_remote_message.dart';

///Push messaging service functions mixin
mixin PushServiceCmdMixin {

  /// Returns the default push token for this device.
  Future<String?> getToken();

  /// Removes access to an push token previously authorized.
  ///
  /// Messages sent by the server to this token will fail.
  Future<void> deleteToken();

  /// Sets the presentation options for Apple notifications when received in
  /// the foreground.
  ///
  /// By default, on Apple devices notification messages are only shown when
  /// the application is in the background or terminated. Calling this method
  /// updates these options to allow customizing notification presentation behavior whilst
  /// the application is in the foreground.
  ///
  /// Important: The requested permissions and those set by the user take priority
  /// over these settings.
  ///
  /// - [alert] Causes a notification message to display in the foreground, overlaying
  ///   the current application (heads up mode).
  /// - [badge] The application badge count will be updated if the application is
  ///   in the foreground.
  /// - [sound] The device will trigger a sound if the application is in the foreground.
  ///
  /// If all arguments are `false` or are omitted, a notification will not be displayed in the
  /// foreground, however you will still receive events relating to the notification.
  Future<void> setForegroundNotificationPresentationOptions({bool alert = false, bool badge = false, bool sound = false});

  /// Subscribe to topic in background.
  ///
  /// [topic] must match the following regular expression:
  /// `[a-zA-Z0-9-_.~%]{1,900}`.
  Future<void> subscribeToTopic(String topic);

  /// Unsubscribe from topic in background.
  Future<void> unsubscribeFromTopic(String topic);

  /// Cancels all pending scheduled notifications and the ones registered in the notification manager
  Future<void> cancelAllNotifications();

  ///Return received notification after app launch via notification
  Future<PSRemoteMessage?> getInitialMessage();

}