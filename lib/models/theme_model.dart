import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static lightTheme() {
    ThemeData.light().copyWith(
      primaryColor: Color(0XFF04AAFF),
      scaffoldBackgroundColor: Color(0XFFFBFBFB),
      textTheme: GoogleFonts.montserratTextTheme(),
    );
  }

  static darkTheme() {
    ThemeData.dark().copyWith(
      primaryColor: Color(0XFF04AAFF),
      scaffoldBackgroundColor: Color(0XFF0C0C0C),
      textTheme: GoogleFonts.montserratTextTheme(),
    );
  }
}
