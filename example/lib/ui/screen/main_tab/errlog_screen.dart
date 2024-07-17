
import 'package:errlog_service/errlog_service.dart';
import 'package:example/ui/view/app_snack_bar.dart';
import 'package:example/ui/view/text_button_accent.dart';
import 'package:flutter/material.dart';
import 'package:example/generated/l10n.dart';

class ErrlogScreen extends StatefulWidget {

  const ErrlogScreen({super.key});

  @override
  State createState() => _ErrlogScreenState();
}

class _ErrlogScreenState extends State<ErrlogScreen> {

  final _errorLoggingNotifier = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final currTheme = Theme.of(context);
    final currColorScheme = currTheme.colorScheme;
    final primaryTextTheme = currTheme.primaryTextTheme;

    return Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Align(alignment: Alignment.bottomCenter, child:
    Column(mainAxisSize: MainAxisSize.min, children: [
      Stack(alignment: Alignment.centerLeft, children: [
        ValueListenableBuilder<bool>(valueListenable: _errorLoggingNotifier, builder: (context, val, child) {
          return Checkbox(value: val, tristate: false, activeColor: currColorScheme.secondary, checkColor: Colors.white, onChanged: (newVal) {
            if (newVal == null) {
              return;
            }
            ErrlogService.instance.setLoggingEnabled(newVal);
            _errorLoggingNotifier.value = newVal;
          });
        }),
        SizedBox(width: mediaQuery.size.width, child: Padding(padding: const EdgeInsets.only(left: 64), child: Text(S.current.errlog_collection, style: primaryTextTheme.bodyLarge)))
      ],),
      const Padding(padding: EdgeInsets.only(top: 8)),
      SizedBox(width: mediaQuery.size.width, child: TextButtonAccent(content: S.current.errlog_simulate_err, onPressed: () async {
        await ErrlogService.instance.log("Pre-error log");
        await ErrlogService.instance.recordError(Exception("Dummy exception message"), StackTrace.current);
        if (!context.mounted) {
          return;
        }
        final snack = AppSnackBar.text(text: S.current.general_done, style: primaryTextTheme.labelLarge?.copyWith(color: Colors.white));
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      })),
      const Padding(padding: EdgeInsets.only(top: 16))
    ])
    ))));
  }
}