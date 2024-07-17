
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../global_constants.dart';


class TextButtonAccent extends StatelessWidget {

  final EdgeInsets padding;
  final Color? bgColor;
  final void Function()? onPressed;
  final String? svgIcon;
  final double svgSize;
  final String content;

  const TextButtonAccent({super.key, required this.content, this.svgIcon, this.svgSize = 24.0, this.padding = EdgeInsets.zero, this.bgColor, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final currTheme = Theme.of(context);
    final currColorScheme = currTheme.colorScheme;
    final primaryTextTheme = currTheme.primaryTextTheme;

    final textColor = onPressed == null ? currTheme.disabledColor : Colors.white;
    final textWidget = Text(content, textAlign: TextAlign.center, style: primaryTextTheme.labelLarge?.copyWith(color: textColor));
    final btnBg = bgColor ?? currColorScheme.secondary;
    final svgStr = svgIcon;
    final child = svgStr != null && svgStr.isNotEmpty ? Stack(alignment: Alignment.centerLeft, children: [
      SizedBox(width: svgSize, height: svgSize, child: SvgPicture.asset(svgStr, width: svgSize, height: svgSize, colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn),),),
      Padding(padding: EdgeInsets.only(left: 8 + svgSize), child: textWidget)
    ],) : textWidget;

    return TextButton(onPressed: onPressed, style: TextButton.styleFrom(foregroundColor: currColorScheme.secondaryContainer,
        backgroundColor: btnBg, disabledBackgroundColor: currColorScheme.tertiaryContainer,
        minimumSize: const Size(100, kAppBtnHeight), alignment: Alignment.center, padding: padding,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(24)))), child: child,
    );
  }
}