import 'package:flutter/material.dart';
import 'package:flutter_bloc_concept/presentation/screens/home_screen.dart';
import 'package:flutter_bloc_concept/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_concept/presentation/screens/third_screen.dart';

class AppRouter {

  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (_) => const HomeScreen(
              title: 'HomeScreen',
              colors: Colors.blueAccent,
            ));
        break;
      case '/second':
        return MaterialPageRoute(
            builder: (_) => const SecondScreen(
              title: 'SecondScreen',
              colors: Colors.redAccent,
            ));
        break;
      default:
        return MaterialPageRoute(
            builder: (_) => const ThirdScreen(
              title: 'ThirdScreen',
              colors: Colors.greenAccent,
            ));
    }
  }
}
