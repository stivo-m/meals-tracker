import 'package:meal_tracker/redux/app_redux.dart';
import 'package:meal_tracker/redux/reducers/meals/meals_reducer.dart';
import 'package:meal_tracker/redux/reducers/message/message_reducer.dart';

AppState appReducer(AppState prevState, dynamic action) {
  return AppState.copyWith(
    mealState: mealsReducer(prevState.mealState, action),
    messageState: messageReducer(prevState.messageState, action),
  );
}
