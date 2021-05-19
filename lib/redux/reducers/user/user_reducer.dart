import 'package:meal_tracker/redux/actions/user/user_actions.dart';
import 'package:meal_tracker/redux/state/modules/user_state.dart';

UserState userReducer(UserState prevState, dynamic action) {
  if (action is LoginAction) {
    return UserState.copyWith(
      prevState: prevState,
      isLoading: true,
    );
  }
  if (action is RegisterAction) {
    return UserState.copyWith(
      prevState: prevState,
      isLoading: true,
    );
  }

  if (action is SignInWithGoogleAction) {
    return UserState.copyWith(
      prevState: prevState,
      isLoading: true,
    );
  }
  if (action is SignOutAction) {
    return UserState.copyWith(
      prevState: prevState,
      user: null,
      isLoading: true,
    );
  }

  if (action is AuthenticatedAction) {
    return UserState.copyWith(
      prevState: prevState,
      user: action.user,
      status: AuthStatus.AUTHENTICATED,
      isLoading: false,
    );
  }

  if (action is AuthenticationError) {
    return UserState.copyWith(
      prevState: prevState,
      user: null,
      status: AuthStatus.AUTHERROR,
      isLoading: false,
      authError: action.erroMessage,
    );
  }
  if (action is UnauthenticatedAction) {
    return UserState.copyWith(
      prevState: prevState,
      user: null,
      status: AuthStatus.UNAUTHENTICATED,
      isLoading: false,
    );
  }
  return UserState.copyWith(
    prevState: prevState,
    isLoading: false,
  );
}
