import 'dart:async';

import 'package:bondlyze/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class SplashService {
  void isLogin(BuildContext context){
    Timer(
        const Duration(seconds: 2),
        () => Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false),
      );
  }
}
