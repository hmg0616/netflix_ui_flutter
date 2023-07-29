import 'package:flutter/material.dart';
import 'package:netflix_ui_flutter/constants.dart';

ThemeData theme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(color: Colors.black),
    textTheme: TextTheme(
      bodyText2: TextStyle(color: kTextColor), // bodyText2는 머터리얼 디자인의 기본 텍스트 스타일
    )
  );
}