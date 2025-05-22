
///Analytics service functions mixin
mixin AnalyticsServiceCmdMixin {

  /// Sets whether analytics collection is enabled for this app on this device.
  ///
  /// This setting is persisted across app sessions. By default it is enabled.
  Future<void> setAnalyticsCollectionEnabled(bool enabled);

  /// Logs a custom Flutter Analytics event with the given [name] and event [parameters]
  Future<void> logEvent({required String name, Map<String, Object>? parameters});

  /// Logs the standard `login` event.
  ///
  /// Apps with a login feature can report this event to signify that a user has logged in.
  Future<void> logLogin({String? loginMethod});

  /// Logs the standard `sign_up` event.
  ///
  /// This event indicates that a user has signed up for an account in your
  /// app. The parameter signifies the method by which the user signed up. Use
  /// this event to understand the different behaviors between logged in and
  /// logged out users.
  Future<void> logSignUp({required String signUpMethod});

  /// Sets the current [screenName], which specifies the current visual context
  /// in your app.
  ///
  /// This helps identify the areas in your app where users spend their time
  /// and how they interact with your app.
  ///
  /// The class name can optionally be overridden by the [screenClassOverride]
  /// parameter.
  ///
  /// The [screenName] and [screenClassOverride] remain in effect until the
  /// current `Activity` (in Android) or `UIViewController` (in iOS) changes or
  /// a new call to [setCurrentScreen] is made.
  ///
  /// Setting a null [screenName] clears the current screen name.
  Future<void> setCurrentScreen({required String? screenName, String screenClassOverride = 'Flutter'});

  /// Sets the user ID property.
  ///
  /// Setting a null [id] removes the user id.
  Future<void> setUserId({String? id});

  /// Sets a user property to a given value.
  ///
  /// Up to 25 user-defined property names are supported. Once set, user property
  /// values persist throughout the app lifecycle and across sessions.
  ///
  /// [name] is the name of the user property to set. Should contain 1 to 24
  /// alphanumeric characters or underscores and must start with an alphabetic
  /// character. The "firebase_" prefix is reserved and should not be used for
  /// user property names.
  ///
  /// Setting a null [value] removes the user property.
  Future<void> setUserProperty({required String name, required String? value});
}