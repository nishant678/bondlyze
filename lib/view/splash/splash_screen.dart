import 'package:bondlyze/config/color/app_color.dart';
import 'package:bondlyze/services/splash/splash_service.dart';
import 'package:flutter/material.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 final SplashService _splashService = SplashService();
  @override
  void initState() {
    super.initState();
    _splashService.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
          body: Container(
            decoration: BoxDecoration(gradient: AppColors.appGradient),
            child: Center(
              child: Image.asset("assets/img/app_logo.png", height: 150),
            ),
          ),
        );
  }
}