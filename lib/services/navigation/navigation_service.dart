import 'package:flutter/cupertino.dart';
import 'package:meal_tracker/services/navigation/base_navigation_service.dart';

class NavigationService implements BaseNavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void navigateToNamed(String routePath) {
    navigatorKey.currentState!.pushNamed(routePath);
  }

  @override
  void pushAndReplaceNamed(String routePath) {
    navigatorKey.currentState!.pushReplacementNamed(routePath);
  }
}

NavigationService navigationService = NavigationService();
