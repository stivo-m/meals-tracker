import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meal_tracker/global/strings.dart';
import 'package:meal_tracker/screens/auth/login.dart';
import 'package:meal_tracker/screens/meals/meals.dart';

class CustomRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // var arguments = settings.arguments;
    switch (settings.name) {
      case HOME_ROUTE:
        return MaterialPageRoute(builder: (_) => MealsScreen());
      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  }
}
