import 'package:bondlyze/config/routes/routes_name.dart';
import 'package:bondlyze/view/bottom_bar.dart';
import 'package:bondlyze/view/home_screen.dart';
import 'package:bondlyze/view/login_screen.dart';
import 'package:bondlyze/view/splash_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashScreen());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());

      case RoutesName.bottom_bar:
        return MaterialPageRoute(builder: (BuildContext context) => const BottomBarScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
