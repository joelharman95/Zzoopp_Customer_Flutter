import 'package:zzoopp_food/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:zzoopp_food/ui/screens/login_screen.dart';

class AppRouter {
  PageRoute generateMainRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      /*case Routes.tutorial:
        return MaterialPageRoute(
            builder: (_) => TutorialScreen(), settings: settings);*/
      case Routes.login:
        return MaterialPageRoute(
            builder: (_) => LoginScreen(), settings: settings);
      /*case Routes.home:
        return MaterialPageRoute(
            builder: (_) => HomeScreen(), settings: settings);*/
    }
  }
}
