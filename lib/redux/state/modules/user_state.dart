import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_tracker/services/auth/auth_service.dart';

class UserState {
  final User? user;
  final AuthStatus authStatus;
  final bool loading;
  final String? error;

  UserState({
    required this.user,
    required this.authStatus,
    required this.loading,
    this.error,
  });

  UserState.initialState()
      : this.authStatus = AuthStatus.UNAUTHENTICATED,
        this.loading = false,
        this.user = authservice.currentUser,
        this.error = null;

  UserState.copyWith({
    required UserState prevState,
    User? user,
    AuthStatus? status,
    required bool isLoading,
    String? authError,
  })  : this.user = user ?? prevState.user,
        this.loading = isLoading,
        this.authStatus = status ?? prevState.authStatus,
        this.error = authError;
}

enum AuthStatus {
  UNINITIATED,
  UNAUTHENTICATED,
  AUTHENTICATED,
  AUTHERROR,
}
