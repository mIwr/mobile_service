
import 'package:flutter/material.dart';

class AppSnackBar extends SnackBar {

  const AppSnackBar({super.key, required super.content, super.duration = const Duration(seconds: 2), super.action,
  }): super(margin: const EdgeInsets.fromLTRB(16, 0, 16, 32));

  AppSnackBar.text({super.key, required String text, TextStyle? style, super.duration = const Duration(seconds: 2), super.action,
  }): super(content: Text(text, style: style));

}