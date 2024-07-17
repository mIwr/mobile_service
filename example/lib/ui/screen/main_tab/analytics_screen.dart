
import 'dart:math';

import 'package:analytics_service/analytics_service.dart';
import 'package:example/extension/int_ext.dart';
import 'package:example/global_constants.dart';
import 'package:example/ui/screen/analytics/route_log_screen.dart';
import 'package:example/ui/screens_enum.dart';
import 'package:example/ui/view/app_snack_bar.dart';
import 'package:example/ui/view/text_button_accent.dart';
import 'package:example/generated/l10n.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {

  const AnalyticsScreen({super.key});

  @override
  State createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {

  final _analyticsCollectionNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final currTheme = Theme.of(context);
    final currColorScheme = currTheme.colorScheme;
    final primaryTextTheme = currTheme.primaryTextTheme;

    return Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Align(alignment: Alignment.bottomCenter, child:
      Column(mainAxisSize: MainAxisSize.min, children: [
        Stack(alignment: Alignment.centerLeft, children: [
          ValueListenableBuilder<bool>(valueListenable: _analyticsCollectionNotifier, builder: (context, val, child) {
            return Checkbox(value: val, tristate: false, activeColor: currColorScheme.secondary, checkColor: Colors.white, onChanged: (newVal) {
              if (newVal == null) {
                return;
              }
              AnalyticsService.instance.setAnalyticsCollectionEnabled(newVal);
              _analyticsCollectionNotifier.value = newVal;
            });
          }),
          SizedBox(width: mediaQuery.size.width, child: Padding(padding: const EdgeInsets.only(left: 64), child: Text(S.current.analytics_collection, style: primaryTextTheme.bodyLarge)))
        ],),
        const Padding(padding: EdgeInsets.only(top: 8)),
        SizedBox(width: mediaQuery.size.width, child: TextButtonAccent(content: S.current.analytics_send_event, onPressed: () async {
          await AnalyticsService.instance.logEvent(name: kAnalyticsEventName, parameters: {
            "rnd": Random.secure().nextInt(intExt.maxInt32Value)
          });
          if (!context.mounted) {
            return;
          }
          final snack = AppSnackBar.text(text: S.current.general_done, style: primaryTextTheme.labelLarge?.copyWith(color: Colors.white));
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(snack);
        })),
        const Padding(padding: EdgeInsets.only(top: 16)),
        SizedBox(width: mediaQuery.size.width, child: TextButtonAccent(content: S.current.analytics_route_log, 
          onPressed: () => Navigator.of(context).push(MaterialPageRoute(settings: Screens.routeLog.routeSettings(), builder: (context) => const RouteLogScreen()))
        )),
        const Padding(padding: EdgeInsets.only(top: 16))
      ])
    ))));
  }
}