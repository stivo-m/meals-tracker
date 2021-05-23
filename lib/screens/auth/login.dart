import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meal_tracker/global/strings.dart';
import 'package:meal_tracker/redux/actions/user/user_actions.dart';
import 'package:meal_tracker/redux/app_redux.dart';
import 'package:meal_tracker/redux/state/modules/user_state.dart';
import 'package:meal_tracker/services/auth/auth_service.dart';
import 'package:meal_tracker/services/navigation/navigation_service.dart';
import 'package:redux/redux.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  String getBgImage() {
    Random _rand = Random();
    int numb = _rand.nextInt(5) + 1;
    String img = 'assets/images/bg$numb.jpg';
    return img;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(getBgImage()),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.multiply,
            ),
          ),
        ),
        child: StoreBuilder<AppState>(
          onInit: (store) {
            if (authservice.currentUser != null) {
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                navigationService.pushAndReplaceNamed(HOME_ROUTE);
              });
            }
          },
          builder: (BuildContext context, Store<AppState> store) {
            if (store.state.userState.authStatus == AuthStatus.AUTHENTICATED &&
                store.state.userState.user != null) {
              SchedulerBinding.instance!.addPostFrameCallback((_) {
                navigationService.pushAndReplaceNamed(HOME_ROUTE);
              });
            }
            return _buildForm(context, store);
          },
        ),
      ),
    );
  }

  Form _buildForm(BuildContext context, Store<AppState> store) {
    return Form(
      key: _formState,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: _buildTitle(context),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: _buildDescription(context),
            ),
            if (store.state.userState.authStatus == AuthStatus.AUTHERROR)
              AnimatedContainer(
                curve: Curves.bounceInOut,
                duration: Duration(milliseconds: 600),
                margin: const EdgeInsets.only(
                  top: 15.0,
                  left: 20.0,
                  right: 20.0,
                ),
                height: 40,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.deepOrangeAccent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    store.state.userState.error ?? "An Error occured",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: _buildGoogleSignInButton(context, store),
            ),
          ],
        ),
      ),
    );
  }

  Padding _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Text(
            'Meals',
            style: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Tracker',
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 35,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Text(
        'If I am declaring the variables as final then then the values(variables) i want to change(on pressed) are in set state(){} so those variables can be changed What to do to prevent this?',
        maxLines: 5,
        style: TextStyle(
          color: Colors.white.withOpacity(0.9),
          fontSize: 16,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  ElevatedButton _buildGoogleSignInButton(
      BuildContext context, Store<AppState> store) {
    return ElevatedButton(
      onPressed: store.state.userState.loading
          ? null
          : () {
              store.dispatch(SignInWithGoogleAction());
            },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Theme.of(context).accentColor,
        ),
        overlayColor: MaterialStateProperty.all(
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.google,
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            SizedBox(width: 10),
            Text(
              'Login with Google',
              style: TextStyle(
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
