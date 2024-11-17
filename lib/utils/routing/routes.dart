
import 'package:flutter/material.dart';
import 'package:knovator_gk_app/screens/splash_screen.dart';
import 'package:knovator_gk_app/utils/routing/routes_name.dart';

import '../../screens/post_detail/view.dart';
import '../../screens/post_list/view.dart';





class Routes{
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch(settings.name) {
      case RouteName.postListScreen:
        return MaterialPageRoute(builder: (context) => PostListScreen());
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => SplashScreen());
      case RouteName.postDescriptionScreen:
        return MaterialPageRoute(builder: (context) => PostDetailScreen(postId: settings.arguments as int,));

      default :
        return MaterialPageRoute(builder: (context){
          return Scaffold(
            body:  Center(child: Text('No route defined')),
          );
        });
    }
  }
}