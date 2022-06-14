import 'dart:io';
import 'package:brain_master/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

import 'app_routes.dart';

class App extends StatelessWidget {

  static const App _instance = App._internal();
  const App._internal();

  factory App() {
    return _instance;
  }

  @override
  Widget build(BuildContext context) {
    return getMaterialApp(widget: const HomeScreen(), title: 'Brain Master', context: context);
  }

  Widget getMaterialApp({required Widget widget, required String title, required BuildContext context}){

    return MaterialApp(
          title: title,
          debugShowCheckedModeBanner: false,
          home: widget,
          onGenerateRoute: getAppRoutes().getRoutes,
    );
  }

  AppRoutes getAppRoutes(){
    return AppRoutes();
  }

  Future<dynamic> setNavigation(BuildContext context, String routeName) async {
    Future.delayed(const Duration(milliseconds: 10), () async {
      final navigator = await Navigator.push(
          context,
          PageTransition(
              child: getAppRoutes().getWidget(context, routeName),
              type: PageTransitionType.fade,
              settings: RouteSettings(name: routeName),
              duration: const Duration(microseconds: 0))
      );
      return navigator;
    });
  }

  void setBackNavigation(BuildContext context) {
    Navigator.pop(context, "true");
  }

  void closeApp() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else {
      exit(0);
    }
  }
}
