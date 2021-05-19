import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_tracker/redux/actions/user/user_actions.dart';
import 'package:meal_tracker/redux/app_redux.dart';
import 'package:meal_tracker/services/auth/auth_service.dart';
import 'package:redux/redux.dart';

userMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is LoginAction) {
    try {
      await authservice
          .loginWithEmailAndPassword(action.email!, action.password!)
          .then((value) {
        if (authservice.currentUser != null) {
          store.dispatch(AuthenticatedAction(user: authservice.currentUser!));
        }
      });
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      store.dispatch(AuthenticationError(erroMessage: e.message.toString()));
    }
  }
  if (action is RegisterAction) {
    await authservice
        .registerWithEmailAndPassword(
            action.name!, action.email!, action.password!)
        .then((value) {
      if (authservice.currentUser != null) {
        store.dispatch(AuthenticatedAction(user: authservice.currentUser!));
      } else {
        store.dispatch(UnauthenticatedAction());
      }
    });
  }
  if (action is SignInWithGoogleAction) {
    await authservice.signInWithGoogle().then((value) {
      if (authservice.currentUser != null) {
        store.dispatch(AuthenticatedAction(
          user: authservice.currentUser!,
        ));
      } else {
        store.dispatch(UnauthenticatedAction());
      }
    });
  }
  if (action is SignOutAction) {
    await authservice
        .signOut()
        .then((value) => store.dispatch(UnauthenticatedAction()));
  }

  next(action);
}
