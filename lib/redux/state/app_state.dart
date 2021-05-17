import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_tracker/redux/state/modules/meal_state.dart';
import 'package:meal_tracker/redux/state/modules/message_state.dart';
import 'package:meal_tracker/services/auth/auth_service.dart';

class AppState {
  final MealState mealState;
  final MessageState messageState;
  final User? user;

  AppState({
    required this.mealState,
    required this.messageState,
    required this.user,
  });

  AppState.initialState()
      : this.mealState = MealState.initialState(),
        this.messageState = MessageState.initialState(),
        this.user = authservice.currentUser;

  AppState.copyWith({
    required MealState mealState,
    required MessageState messageState,
  })   : this.mealState = mealState,
        this.messageState = messageState,
        this.user = authservice.currentUser;
}
