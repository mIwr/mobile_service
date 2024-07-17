import 'dart:async';
import 'dart:collection';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:push_service_interface/model/ps_remote_message.dart';
import 'package:push_service_interface/push_service_interface.dart';

void _onPushOpenedApp(RemoteMessage message) {
  final psrMsg = _from(message);
  PushServiceInterface.onMessageOpenedAppEventsController.add(psrMsg);
}

@pragma('vm:entry-point')
Future<void> onAndroidBackgroundMessage(RemoteMessage message) async {
  final psrMsg = _from(message);
  var handler = PushServiceInterface.onBackgroundMessageHandler;
  if (handler != null) {
    handler(psrMsg);
    return;
  }
  handler = await PushServiceInterface.getBgMsgHandlerFromNonMainContext();
  if (handler == null) {
    return;
  }
  handler(psrMsg);
}

void _onForegroundMessage(RemoteMessage message) {
  final psrMsg = _from(message);
  PushServiceInterface.onMessageEventsController.add(psrMsg);
}

PSRemoteMessage _from(RemoteMessage message) {
  final additionalData = HashMap<String, dynamic>();
  additionalData["mutableContent"] = message.mutableContent;
  additionalData["threadId"] = message.threadId;
  additionalData["data"] = message.data;
  additionalData["title"] = message.notification?.title;
  additionalData["titleLocArgs"] = message.notification?.titleLocArgs;
  additionalData["titleLocKey"] = message.notification?.titleLocKey;
  additionalData["body"] = message.notification?.body;
  additionalData["bodyLocArgs"] = message.notification?.bodyLocArgs;
  additionalData["bodyLocKey"] = message.notification?.bodyLocKey;
  final webNotification = message.notification?.web;
  if (webNotification != null) {
    additionalData["web"] = webNotification.toMap();
  }
  final appleNotification = message.notification?.apple;
  if (appleNotification != null) {
    additionalData["apple"] = appleNotification.toMap();
  }
  final androidNotification = message.notification?.android;
  if (androidNotification != null) {
    additionalData["android"] = androidNotification.toMap();
  }
  final parsed = PSRemoteMessage(messageId: message.messageId, from: message.from, sentTime: message.sentTime,
      messageType: message.messageType, collapseKey: message.collapseKey, ttl: message.ttl, payload: additionalData);

  return parsed;
}

class PushServiceImpl implements PushServiceInterface {

  var _initialized = false;

  @override
  String get agentKey => ServiceAgentExt.kGmsAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.gms;

  @override
  Future<void> init() async {
    await Firebase.initializeApp();
    await _pushInit();
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) async {
    throw UnimplementedError("Not supported");
    /*await Firebase.initializeApp(name: config.projectId ?? "", options: FirebaseOptions(apiKey: config.apiKey, appId: config.appId ?? "", messagingSenderId: config.messagingSenderId ?? "", projectId: config.projectId ?? ""));
    await _pushInit();*/
  }

  Future<void> _pushInit() async {
    await FirebaseMessaging.instance.setAutoInitEnabled(true);
    if (_initialized) {
      return;
    }
    _initialized = true;
    //Foreground push handler
    try {
      FirebaseMessaging.onMessage.listen(_onForegroundMessage);
    }
    catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    //Push app launch handler
    try {
      FirebaseMessaging.onMessageOpenedApp.listen(_onPushOpenedApp);
    }
    catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    //Background push handler
    FirebaseMessaging.onBackgroundMessage(onAndroidBackgroundMessage);
  }

  @override
  Future<String?> getToken() {
    return FirebaseMessaging.instance.getToken();
  }

  @override
  Future<void> deleteToken() {
    return FirebaseMessaging.instance.deleteToken();
  }

  @override
  Future<void> setForegroundNotificationPresentationOptions({bool alert = false, bool badge = false, bool sound = false}) {
    return FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: alert, badge: badge, sound: sound);
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await FirebaseMessaging.instance.subscribeToTopic(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await FirebaseMessaging.instance.unsubscribeFromTopic(topic);
  }

  @override
  Future<void> cancelAllNotifications() async {
    if (kDebugMode) {
      print("No implemented functionality for GMS service");
    }
  }

  @override
  Future<PSRemoteMessage?> getInitialMessage() async {
    final fcmMsg = await FirebaseMessaging.instance.getInitialMessage();
    if (fcmMsg == null) {
      return null;
    }
    final psrMsg = _from(fcmMsg);

    return psrMsg;
  }
}