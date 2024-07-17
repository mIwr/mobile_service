import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:huawei_push/huawei_push.dart';
import 'package:push_service_interface/model/ps_remote_message.dart';
import 'package:push_service_interface/push_service_interface.dart';

void _onPushOpenedApp(dynamic message) {
  if (message is RemoteMessage == false) {
    return;
  }
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
  DateTime? sentTime;
  final sentTsMs = message.sentTime;
  if (sentTsMs != null && sentTsMs > 0) {
    sentTime = DateTime.fromMillisecondsSinceEpoch(sentTsMs);
  }
  final additionalData = HashMap<String, dynamic>();
  additionalData["to"] = message.to;
  additionalData["token"] = message.token;
  additionalData["collapseKey"] = message.collapseKey;
  additionalData["urgency"] = message.urgency;
  additionalData["originalUrgency"] = message.originalUrgency;
  additionalData["sendMode"] = message.sendMode;
  additionalData["receiptMode"] = message.receiptMode;
  additionalData["analyticInfoStr"] = message.analyticInfo;
  additionalData["analyticInfo"] = message.analyticInfoMap;
  final dataStr = message.data;
  additionalData["dataStr"] = dataStr;
  final data = message.dataOfMap ?? {};
  if (dataStr != null && dataStr.isNotEmpty && data.isEmpty) {
    additionalData["data"] = dataStr;
  } else {
    additionalData["data"] = data;
  }
  additionalData["title"] = message.notification?.title;
  additionalData["titleLocArgs"] = message.notification?.titleLocalizationArgs;
  additionalData["titleLocKey"] = message.notification?.titleLocalizationKey;
  additionalData["body"] = message.notification?.body;
  additionalData["bodyLocArgs"] = message.notification?.bodyLocalizationArgs;
  additionalData["bodyLocKey"] = message.notification?.bodyLocalizationKey;
  final hmsAndroidNotification = message.notification;
  if (hmsAndroidNotification != null) {
    additionalData["android"] = hmsAndroidNotification.toMap();
  }
  final parsed = PSRemoteMessage(messageId: message.messageId, from: message.from, sentTime: sentTime,
      messageType: message.type, collapseKey: message.collapseKey, ttl: message.ttl, payload: additionalData);

  return parsed;
}

class PushServiceImpl implements PushServiceInterface  {

  var _initialized = false;

  @override
  String get agentKey => ServiceAgentExt.kHmsAgentKey;
  @override
  ServiceAgent? get agent => ServiceAgent.hms;

  @override
  Future<void> init() async {
    await Push.setAutoInitEnabled(true);
    if (_initialized) {
      return;
    }
    _initialized = true;
    Push.getTokenStream.listen(_onTokenUpd);
    //Foreground push handler
    try {
      Push.onMessageReceivedStream.listen(_onForegroundMessage);
    }
    catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    //Push app launch handler
    try {
      Push.onNotificationOpenedApp.listen(_onPushOpenedApp);
    }
    catch (error) {
      if (kDebugMode) {
        print(error);
      }
    }
    //Background push handler
    Push.registerBackgroundMessageHandler(onAndroidBackgroundMessage);
  }

  @override
  Future<void> initWithConfig(ServiceConfig config) {
    throw UnimplementedError("Not supported");
  }

  void _onTokenUpd(String token) {}

  @override
  Future<String?> getToken() async {
    Push.getToken("");
    final tk = await Push.getTokenStream.asBroadcastStream().first;

    return tk;
  }

  @override
  Future<void> deleteToken() async {
    await Push.deleteToken("");

    return;
  }

  @override
  Future<void> setForegroundNotificationPresentationOptions({bool alert = false, bool badge = false, bool sound = false}) async {
    //Not supported for HMS
    return;
  }

  @override
  Future<void> subscribeToTopic(String topic) async {
    await Push.subscribe(topic);
  }

  @override
  Future<void> unsubscribeFromTopic(String topic) async {
    await Push.unsubscribe(topic);
  }

  @override
  Future<void> cancelAllNotifications() {
    return Push.cancelAllNotifications();
  }

  @override
  Future<PSRemoteMessage?> getInitialMessage() async {
    final hmsMsg = await Push.getInitialNotification();
    if (hmsMsg == null) {
      return null;
    }
    final psrMsg = _from(hmsMsg);

    return psrMsg;
  }
}