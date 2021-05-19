import 'package:firebase_auth/firebase_auth.dart';

abstract class UserActions {}

class LoginAction implements UserActions {
  final String? email, password;

  LoginAction({
    required this.email,
    required this.password,
  });
}

class RegisterAction implements UserActions {
  final String? name, email, password;

  RegisterAction({
    required this.name,
    required this.email,
    required this.password,
  });
}

class SignInWithGoogleAction implements UserActions {}

class SignOutAction implements UserActions {}

class AuthenticatingAction implements UserActions {}

class AuthenticatedAction implements UserActions {
  final User user;

  AuthenticatedAction({
    required this.user,
  });
}

class AuthenticationError implements UserActions {
  final String? erroMessage;

  AuthenticationError({this.erroMessage});
}

class UnauthenticatedAction implements UserActions {}
