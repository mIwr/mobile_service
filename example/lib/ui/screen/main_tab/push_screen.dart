
import 'package:example/ui/view/app_snack_bar.dart';
import 'package:example/ui/view/text_button_accent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:push_service/push_service.dart';
import 'package:example/generated/l10n.dart';

class PushScreen extends StatefulWidget {

  const PushScreen({super.key});

  @override
  State createState() => _PushScreenState();
}

class _PushScreenState extends State<PushScreen> {

  final _pushTokenController = TextEditingController(text: "N/A");

  @override
  void initState() {
    super.initState();
    try {
      PushService.instance.getToken().then((tk) {
        if (tk == null || tk.isEmpty) {
          return;
        }
        if (kDebugMode) {
          print("Push token " + tk);
        }
        _pushTokenController.text = tk;
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final currTheme = Theme.of(context);
    final primaryTextTheme = currTheme.primaryTextTheme;

    return Scaffold(body: SafeArea(child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Align(alignment: Alignment.bottomCenter, child:
    Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text("Push Token", style: primaryTextTheme.bodyMedium),
      const Padding(padding: EdgeInsets.only(top: 12)),
      TextField(controller: _pushTokenController, maxLines: null, keyboardType: TextInputType.multiline, autocorrect: false,
        autofocus: false, enableSuggestions: false),
      const Padding(padding: EdgeInsets.only(top: 16)),
      SizedBox(width: mediaQuery.size.width, child: TextButtonAccent(content: S.current.push_refresh_token, onPressed: () async {
        await PushService.instance.deleteToken();
        final tk = await PushService.instance.getToken();
        if (tk == null || tk.isEmpty) {
          return;
        }
        if (kDebugMode) {
          print("Push token " + tk);
        }
        _pushTokenController.text = tk;
        if (!context.mounted) {
          return;
        }
        final snack = AppSnackBar.text(text: S.current.general_done, style: primaryTextTheme.labelLarge?.copyWith(color: Colors.white));
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(snack);
      })),
      const Padding(padding: EdgeInsets.only(top: 16)),
    ])
    ))));
  }
}