
import 'dart:math';

import 'package:flutter/foundation.dart';

extension intExt on int {

  static const int _maxValue = 9223372036854775807;//2^63-1
  static const int _maxValueWeb = 9007199254740991;//2^53-1
  static const int _minValue = -9223372036854775808;
  static const int _minValueWeb = -9007199254740992;

  static int get maxInt32Value {
    return 2147483647;
  }

  static int get minInt32Value {
    return -2147483648;
  }

  static int get maxValue {
    return kIsWeb ? _maxValueWeb : _maxValue;
  }

  static int get minValue {
    return kIsWeb ? _minValueWeb : _minValue;
  }

  int round(int exponent10) {
    if (exponent10 <= 0) {
      return this;
    }
    final divider = pow(10, exponent10);
    var buff = (toDouble() / divider).round() * divider;
    return buff.toInt();
  }
}