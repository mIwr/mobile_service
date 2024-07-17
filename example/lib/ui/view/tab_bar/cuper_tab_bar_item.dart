
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CuperTabBarItem {

  final String title;
  final String onSvgIcon;
  final String offSvgIcon;

  CuperTabBarItem({required this.title, required this.onSvgIcon, required this.offSvgIcon});

  BottomNavigationBarItem buildItem(BuildContext context) {
    final currTheme = Theme.of(context);
    final currColorScheme = currTheme.colorScheme;

    final unselectedItem = SvgPicture.asset(offSvgIcon, width: 24, height: 24, fit: BoxFit.fitHeight,
        colorFilter: ColorFilter.mode(currColorScheme.surface, BlendMode.srcIn));
    final selectedItem = SvgPicture.asset(onSvgIcon, width: 24, height: 24, fit: BoxFit.fitHeight,
        colorFilter: ColorFilter.mode(currColorScheme.secondary, BlendMode.srcIn));
    return BottomNavigationBarItem(icon: unselectedItem, activeIcon: selectedItem, label: title);
  }
}