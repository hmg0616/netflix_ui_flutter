
import 'package:flutter/material.dart';
import 'package:netflix_ui_flutter/screens/main_screens.dart';
import 'package:netflix_ui_flutter/screens/profile/profile_screen.dart';
import 'package:netflix_ui_flutter/screens/splash/splash_screen.dart';

final Map<String, WidgetBuilder> route = {
  SplashScreen.routeName: (context) => SplashScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
  MainScreens.routeName: (context) => MainScreens(),
};