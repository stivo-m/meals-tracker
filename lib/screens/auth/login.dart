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
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String getBgImage() {
    // Random _rand = Random();
    // int numb = _rand.nextInt(5) + 1;
    String img = 'assets/images/bg1.jpg';
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 100.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: _buildTitle(context),
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
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: _buildEmailField(),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: _buildPasswordField(),
            ),
            SizedBox(
              height: 30.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: _buildLoginButton(store),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: Text(
                'OR',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: _buildGoogleSignInButton(context, store),
            ),
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: _buildCreateAccountButton(),
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

  TextFormField _buildEmailField() {
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Enter your email',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Email cannot be empty';
        }
      },
      controller: _emailController,
    );
  }

  TextFormField _buildPasswordField() {
    return TextFormField(
      obscureText: true,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Enter your password',
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
            width: 1.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      validator: (String? val) {
        if (val!.isEmpty) {
          return 'Password cannot be empty';
        } else if (val.length < 5) {
          return 'Password should be more than 5 characters';
        }
      },
      controller: _passwordController,
    );
  }

  ElevatedButton _buildLoginButton(Store<AppState> store) {
    return ElevatedButton(
      onPressed: store.state.userState.loading
          ? () {}
          : () {
              if (_formState.currentState!.validate()) {
                _formState.currentState?.save();
                store.dispatch(
                  LoginAction(
                    email: _emailController.text.trim(),
                    password: _passwordController.text.trim(),
                  ),
                );
              }
            },
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
        ),
        child: Container(
          width: double.infinity,
          child: Center(
            child: store.state.userState.loading
                ? CircularProgressIndicator()
                : Text(
                    'Login'.toUpperCase(),
                  ),
          ),
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

  TextButton _buildCreateAccountButton() {
    return TextButton(
      onPressed: () {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'New Here?',
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'Create Account',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
