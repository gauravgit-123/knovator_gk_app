import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knovator_gk_app/utils/routing/routes.dart';
import 'package:knovator_gk_app/utils/routing/routes_name.dart';

import 'utils/Constant.dart';


void main() {
  runApp(UncontrolledProviderScope(container: kProviderContainer,
      child: ProviderScope(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KnovatoR',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouteName.splashScreen,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}


