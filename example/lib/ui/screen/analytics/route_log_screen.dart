
import 'package:example/ui/view/text_button_accent.dart';
import 'package:flutter/material.dart';
import 'package:example/generated/l10n.dart';

class RouteLogScreen extends StatelessWidget {

  const RouteLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final currTheme = Theme.of(context);
    final primaryTextTheme = currTheme.primaryTextTheme;

    return Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Stack(children: [
      Center(child: Text(S.current.analytics_route_log_title, textAlign: TextAlign.center, style: primaryTextTheme.displayMedium)),
      Align(alignment: Alignment.bottomCenter, child: Padding(padding: const EdgeInsets.only(bottom: 12), child: SizedBox(width: mediaQuery.size.width,
          child: TextButtonAccent(content: S.current.general_close, onPressed: () => Navigator.of(context).pop())
      )))
    ]))));
  }
}
