
import 'dart:collection';

///Push service message
class PSRemoteMessage {

  /// A unique ID assigned to every message.
  final String? messageId;
  /// The topic name or message identifier.
  final String? from;
  /// The time the message was sent, represented as a [DateTime].
  final DateTime? sentTime;
  /// The message type of the message.
  final String? messageType;
  /// The collapse key a message was sent with. Used to override existing messages with the same key.
  final String? collapseKey;
  /// The time to live for the message in seconds.
  final int? ttl;

  /// Any additional data sent with the message.
  final HashMap<String, dynamic> payload;

  ///Notification title from payload
  String? get title {
    String? title = payload["title"];

    return title;
  }

  ///Notification body from payload
  String? get body {
    String? body = payload["body"];

    return body;
  }

  ///iOS notification subtitle from payload
  String? get appleSubtitle {
    final ios = appleMap;
    if (ios == null || !ios.containsKey("subtitle") || ios["subtitle"] is String == false) {
      return null;
    }
    final String? subtitle = ios["subtitle"];

    return subtitle;
  }

  ///Android notification channel ID from payload
  String? get androidChannelId {
    final android = androidMap;
    if (android == null || !android.containsKey("channelId") || android["channelId"] is String == false) {
      return null;
    }
    final String id = android["channelId"] ?? "";

    return id;
  }

  ///Notification data map from payload
  HashMap<String, dynamic> get data {
    if (!payload.containsKey("data") || payload["data"] is Map == false) {
      return HashMap();
    }
    final HashMap<String, dynamic> map = HashMap.from(payload["data"]);

    return map;
  }

  ///Android notification settings map
  HashMap<String, dynamic>? get androidMap {
    if (!payload.containsKey("android") || payload["android"] is Map == false) {
      return null;
    }
    final HashMap<String, dynamic> map = HashMap.from(payload["android"]);

    return map;
  }

  ///iOS notification settings map
  HashMap<String, dynamic>? get appleMap {
    if (!payload.containsKey("apple") || payload["apple"] is Map == false) {
      return null;
    }
    final HashMap<String, dynamic> map = HashMap.from(payload["apple"]);

    return map;
  }

  ///Web notification settings map
  HashMap<String, dynamic>? get webMap {
    if (!payload.containsKey("web") || payload["web"] is Map == false) {
      return null;
    }
    final HashMap<String, dynamic> map = HashMap.from(payload["web"]);

    return map;
  }

  PSRemoteMessage({this.messageId, this.from, this.sentTime, this.messageType, this.collapseKey, this.ttl, required this.payload});

  @override
  String toString() {
    var msg = "Push";
    final id = messageId;
    if (id != null && id.isNotEmpty) {
      msg += ' $id';
    }

    return msg;
  }
}