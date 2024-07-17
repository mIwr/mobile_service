import 'package:analytics_service/analytics_service.dart';
import 'package:example/extension/navigator_ext.dart';
import 'package:example/global_variables.dart';
import 'package:example/ui/advanced_analytics_observer.dart';
import 'package:example/ui/screen/main_tab/analytics_screen.dart';
import 'package:example/ui/screen/main_tab/errlog_screen.dart';
import 'package:example/ui/screen/main_tab/push_screen.dart';
import 'package:example/ui/screens_enum.dart';
import 'package:example/ui/status_bar_observer.dart';
import 'package:example/ui/system_nav_bar_observer.dart';
import 'package:example/ui/view/tab_bar/cuper_tab_bar.dart';
import 'package:example/ui/view/tab_bar/cuper_tab_bar_item.dart';
import 'package:example/util/status_bar_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:example/generated/l10n.dart';
import 'package:example/generated/assets.dart';


class TabBarScaffold extends StatefulWidget {

  const TabBarScaffold({super.key});

  @override
  State createState() => _TabBarScaffoldState();
}

class _TabBarScaffoldState extends State<TabBarScaffold> {

  final List<CuperTabBarItem> _tabBarItems = [];
  final List<CupertinoTabView> _tabs = [];
  final List<GlobalKey<NavigatorState>> _navigationKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  final List<Color> _statusBarTabsColors = [
    Colors.transparent,
    Colors.transparent,
    Colors.transparent,
  ];

  ///Global software tab bar item 'tap' support
  final _bottomTabBarKey = GlobalKey();

  var _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabBarItems.addAll([
      CuperTabBarItem(title: S.current.general_analytics, onSvgIcon: R.ASSETS_IC_CHART_FILL_SVG, offSvgIcon: R.ASSETS_IC_CHART_SVG),
      CuperTabBarItem(title: S.current.tab_errlog_name, onSvgIcon: R.ASSETS_IC_BUG_FILL_SVG, offSvgIcon: R.ASSETS_IC_BUG_SVG),
      CuperTabBarItem(title: S.current.tab_push_name, onSvgIcon: R.ASSETS_IC_TELEGRAM_FILL_SVG, offSvgIcon: R.ASSETS_IC_TELEGRAM_SVG),
    ]);
    _tabs.addAll([
      _buildTab(context, navKey: _navigationKeys[0], routeName: kAnalyticsTabRouteKey, payload: const AnalyticsScreen()),
      _buildTab(context, navKey: _navigationKeys[1], routeName: kErrlogTabRouteKey, payload: const ErrlogScreen()),
      _buildTab(context, navKey: _navigationKeys[2], routeName: kPushTabRouteKey, payload: const PushScreen()),
    ]);
  }

  CupertinoTabView _buildTab(BuildContext context, {required GlobalKey<NavigatorState> navKey, required String routeName, required StatefulWidget payload}) {
    AdvancedAnalyticsObserver? analyticsObs;
    try {
      final service = AnalyticsService.instance;
      analyticsObs = AdvancedAnalyticsObserver(analyticsService: service);
    } catch (error) {
      print("Init analytics observer error $error");
    }

    return CupertinoTabView(navigatorKey: navKey, routes: {
      routeName: (context) => payload
    },  navigatorObservers: [
      StatusBarObserver(),
      SystemNavBarObserver(),
      if (analyticsObs != null)
        analyticsObs
    ], onUnknownRoute: (route) {
      //custom route name on tab hack
      return MaterialPageRoute(settings: RouteSettings(name: routeName), builder: (context) => payload);
    },);
  }

  @override
  Widget build(BuildContext context) {

    final bottomBar = CuperBottomTabBar(key: _bottomTabBarKey, tabBarItems: _tabBarItems.map((e) => e.buildItem(context)).toList(growable: false),
      onTap: (newIndex) {
        final navKey = _navigationKeys[newIndex];
        if (newIndex == _selectedTabIndex && navKey.currentState?.canPop() == true) {
          navKey.currentState?.popUntilCan();
          return;
        }
        _statusBarTabsColors[_selectedTabIndex] = StatusBarUtil.bgColor;
        _selectedTabIndex = newIndex;
        StatusBarUtil.transformByBg(bgColor: _statusBarTabsColors[_selectedTabIndex]);
      },);

    return CupertinoPageScaffold(resizeToAvoidBottomInset: false, child: CupertinoTabScaffold(controller: tabBarController,
          tabBar: bottomBar.buildBar(context), tabBuilder: (context, index) {
            return PopScope(canPop: true, onPopInvoked: (didPop) {
              //Android hw/sw back button press handler
              if (!didPop) {
                return;
              }
              final state = _navigationKeys[_selectedTabIndex].currentState;
              if (state?.canPop() == false) {
                return;
              }
              state?.pop();
            }, child: _tabs[index]);
    }));
  }
}