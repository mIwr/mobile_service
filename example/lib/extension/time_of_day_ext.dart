
import 'package:flutter/material.dart';

extension TimeOfDayExt on TimeOfDay {

  int compareTo(TimeOfDay other) {
    if (hour == other.hour) {
      if (minute == other.minute) {
        return 0;
      } else if (minute > other.minute) {
        return 1;
      }
      return -1;
    } else if (hour > other.hour) {
      return 1;
    }
    return -1;
  }
}