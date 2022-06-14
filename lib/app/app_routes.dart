import 'package:brain_master/views/game_screen.dart';
import 'package:brain_master/views/home_screen.dart';
import 'package:brain_master/views/settings_screen.dart';
import 'package:flutter/material.dart';

class AppRoutes {

  static const String splashScreen = "/splash";
  static const String homeScreen = "/home";
  static const String gameScreen = "/game";
  static const String settingScreen = "/settings";

  Route getRoutes(RouteSettings routeSettings){
    switch(routeSettings.name) {
      case settingScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const SettingsScreen(),
              fullscreenDialog: true
          );
        }
      case homeScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const HomeScreen(),
              fullscreenDialog: true
          );
        }
      case gameScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => const GameScreen(),
              fullscreenDialog: true
          );
        }
      case splashScreen:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => Container(),
              fullscreenDialog: true
          );
        }
      default:
        {
          return MaterialPageRoute(
              settings: routeSettings,
              builder: (BuildContext context) => Container(),
              fullscreenDialog: true
          );
        }
    }
  }

  Widget getWidget(BuildContext context, String routeName){
    switch(routeName){
      case settingScreen:
        {
          return const SettingsScreen();
        }
      case homeScreen:
        {
          return const HomeScreen();
        }
      case gameScreen:
        {
          return const GameScreen();
        }
      case splashScreen:
        {
          return Container();
        }
      default:
        {
          return Container();
        }
    }
  }

}