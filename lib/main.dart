import 'package:flutter/material.dart';
import 'package:netflix_ui_flutter/routes.dart';
import 'package:netflix_ui_flutter/screens/splash/splash_screen.dart';
import 'package:netflix_ui_flutter/theme.dart';

void main() {
  runApp(Netflix());
}

class Netflix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: route,
    );
  }

}
