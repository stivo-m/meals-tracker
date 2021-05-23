import 'package:firebase_auth/firebase_auth.dart';

abstract class UserActions {}

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
