import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meal_tracker/global/router.dart';
import 'package:meal_tracker/global/strings.dart';
import 'package:meal_tracker/models/theme_model.dart';
import 'package:meal_tracker/redux/app_redux.dart';
import 'package:meal_tracker/redux/middleware/user/user_middleware.dart';
import 'package:meal_tracker/redux/reducers/reducer.dart';
import 'package:meal_tracker/screens/auth/login.dart';
import 'package:meal_tracker/services/auth/auth_service.dart';
import 'package:meal_tracker/services/navigation/navigation_service.dart';
import 'package:redux/redux.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final Store<AppState> _store = Store<AppState>(
    appReducer,
    initialState: AppState.initialState(),
    middleware: [userMiddleware],
  );
  runApp(MyApp(store: _store));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  const MyApp({
    Key? key,
    required this.store,
  }) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StoreProvider(
      store: store,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.lightTheme(),
        darkTheme: AppTheme.darkTheme(),
        themeMode: ThemeMode.system,
        initialRoute:
            authservice.currentUser == null ? LOGIN_ROUTE : HOME_ROUTE,
        onGenerateRoute: CustomRouter.onGenerateRoute,
        navigatorKey: navigationService.navigatorKey,
      ),
    );
  }
}
