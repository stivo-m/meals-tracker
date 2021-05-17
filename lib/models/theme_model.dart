import 'package:flutter/material.dart';

class AppTheme {
  static lightTheme() {
    ThemeData.light().copyWith(
      primaryColor: Color(0X00CC74),
    );
  }

  static darkTheme() {
    ThemeData.dark().copyWith(
      primaryColor: Color(0X00CC74),
    );
  }
}
