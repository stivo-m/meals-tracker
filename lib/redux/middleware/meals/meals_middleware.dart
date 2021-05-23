import 'package:meal_tracker/redux/actions/meal/meal_actions.dart';
import 'package:meal_tracker/redux/app_redux.dart';
import 'package:meal_tracker/services/meals/meals_service.dart';
import 'package:redux/redux.dart';

mealsMiddleware(
    Store<AppState> store, dynamic action, NextDispatcher next) async {
  if (action is GetMeals) {
    await mealService
        .getMeals()
        .then((meals) => store.dispatch(ShowMeals(meals: meals)));
  }

  if (action is AddMeal) {
    await mealService
        .addMeal(meal: action.meal)
        .then((addedMeal) => store.dispatch(MealUpdated(meal: addedMeal)));
  }

  if (action is RemoveMeal) {
    await mealService
        .deleteMeal(meal: action.meal)
        .then((value) => store.dispatch(MealUpdated()));
  }

  next(action);
}
