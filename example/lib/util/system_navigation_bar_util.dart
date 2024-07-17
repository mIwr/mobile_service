
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';

abstract class SystemNavigationBarUtil {

  ///Device OS SDK version number
  static int? _sdkNum;
  ///Current navigation bar background color
  static Color _navBarBg = Colors.transparent;
  ///Current navigation bar foreground style (content style)
  static Brightness _navBarFgStyle = Brightness.light;

  ///Change status bar background and foreground colors
  static Future<void> transformNavigationBar({required Color bgColor, required Brightness fgStyle}) async {
    if (!Platform.isAndroid) {
      return;
    }
    var num = _sdkNum ?? -1;
    if (num == -1) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      num = androidInfo.version.sdkInt;
      _sdkNum = num;
    }
    if (num > 0 && num <= 27) {
      return;
    }

    _navBarBg = bgColor;
    _navBarFgStyle = fgStyle;
    await FlutterStatusbarcolor.setNavigationBarColor(_navBarBg, animate: true);
    await FlutterStatusbarcolor.setNavigationBarWhiteForeground(fgStyle == Brightness.light);
  }
}