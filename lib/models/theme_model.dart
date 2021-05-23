import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static lightTheme() {
    return ThemeData.light().copyWith(
      accentColor: Color(0XFF0C0C0C),
      primaryColor: Color(0XFF04AAFF),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0XFFFBFBFB),
        brightness: Brightness.light,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0XFFFBFBFB),
      ),
      scaffoldBackgroundColor: Color(0XFFFBFBFB),
      textTheme: GoogleFonts.montserratTextTheme(),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0XFFFBFBFB),
        selectedItemColor: Color(0XFF04AAFF),
        unselectedItemColor: Color(0XFF0C0C0C).withOpacity(0.3),
      ),
    );
  }

  static darkTheme() {
    return ThemeData.dark().copyWith(
      accentColor: Color(0XFFFBFBFB),
      primaryColor: Color(0XFF04AAFF),
      scaffoldBackgroundColor: Color(0XFF0C0C0C),
      textTheme: GoogleFonts.montserratTextTheme(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.black,
        elevation: 10.0,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0XFF0C0C0C),
        brightness: Brightness.dark,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0XFF0C0C0C),
        selectedItemColor: Color(0XFF04AAFF),
        unselectedItemColor: Color(0XFFFBFBFB).withOpacity(0.3),
      ),
    );
  }
}
