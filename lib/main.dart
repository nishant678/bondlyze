import 'package:bondlyze/config/routes/routes.dart';
import 'package:bondlyze/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bondlyze',
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: RoutesName.splash,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
  