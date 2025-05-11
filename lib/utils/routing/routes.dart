import 'package:cracku_gk_app/screens/home_screen.dart';
import 'package:cracku_gk_app/utils/routing/routes_name.dart';
import 'package:flutter/material.dart';

import '../../screens/Questions/view.dart';
import '../../screens/splash_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.quizScreen:
        return MaterialPageRoute(builder: (context) => QuestionsScreen());
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());

      default:
        return MaterialPageRoute(builder: (context) {
          return Scaffold(
            body: Center(child: Text('No route defined')),
          );
        });
    }
  }
}
