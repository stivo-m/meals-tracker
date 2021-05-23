import 'package:meal_tracker/redux/state/modules/meal_state.dart';
import 'package:meal_tracker/redux/state/modules/message_state.dart';
import 'package:meal_tracker/redux/state/modules/user_state.dart';

class AppState {
  final MealState mealState;
  final MessageState messageState;
  final UserState userState;

  AppState({
    required this.mealState,
    required this.messageState,
    required this.userState,
  });

  AppState.initialState()
      : this.mealState = MealState.initialState(),
        this.messageState = MessageState.initialState(),
        this.userState = UserState.initialState();

  AppState.copyWith({
    required MealState mealState,
    required MessageState messageState,
    required UserState userState,
  })   : this.mealState = mealState,
        this.messageState = messageState,
        this.userState = userState;
}
