
import 'dart:convert';

extension JsonCodecExt on JsonCodec {

  static T? parseInstanceFrom<T>(Map<String, dynamic> jsonMap, {required String key, required T? Function(Map<String, dynamic> jsonMap) parser}) {
    if (!jsonMap.containsKey(key) || jsonMap[key] is Map == false) {
      return null;
    }
    final Map<String, dynamic> map = Map.from(jsonMap);
    final parsed = parser(map);

    return parsed;
  }

  static List<T> parseArrayFrom<T>(Map<String, dynamic> jsonMap, {required String key, required T? Function(Map<String, dynamic> jsonMap) parser}) {
    if (!jsonMap.containsKey(key) || jsonMap[key] is List == false) {
      return [];
    }
    final List<dynamic> arr = List.from(jsonMap[key]);
    final List<T> res = [];
    for (final item in arr) {
      if (item is Map == false) {
        continue;
      }
      final Map<String, dynamic> map = Map.from(item);
      final parsed = parser(map);
      if (parsed == null) {
        continue;
      }
      res.add(parsed);
    }
    if (res.length != arr.length) {
      print("JSON map parsing fail: parsed array length is " + res.length.toString() + "; expected length is " + arr.length.toString());
    }

    return res;
  }

  List<T> arrayFrom<T>(Map<String, dynamic> jsonMap, {required String key, required T? Function(Map<String, dynamic> jsonMap) parser}) {
    return JsonCodecExt.parseArrayFrom(jsonMap, key: key, parser: parser);
  }

  T? instanceFrom<T>(Map<String, dynamic> jsonMap, {required String key, required T? Function(Map<String, dynamic> jsonMap) parser}) {
    return JsonCodecExt.parseInstanceFrom(jsonMap, key: key, parser: parser);
  }
}