import 'package:meal_tracker/redux/actions/meal/meal_actions.dart';
import 'package:meal_tracker/redux/state/modules/meal_state.dart';

MealState mealsReducer(MealState mealState, dynamic action) {
  if (action is AddMeal) {
    // add meal to db
    return MealState.copyWith(
      meals: mealState.meals,
      isLoading: true,
    );
  }

  if (action is GetMeal) {
    // get a meal from action.id
  }

  if (action is UpdateMeal) {
    // update meal in db using action.updates as the list of updates
    // the meal list in mealstate should remove the action.meal and add the newMeal with updates
    var newMeal;
    return MealState.copyWith(
      meals: mealState.meals
        ..remove(action.meal)
        ..add(newMeal),
      isLoading: true,
    );
  }

  if (action is AddMeal) {
    //remove meal from db
    return MealState.copyWith(
      meals: mealState.meals..remove(action.meal),
      isLoading: true,
    );
  }

  if (action is MealUpdated) {
    //this is the only action that has a loading status of false
    // it is called from the midlleware after any of the above actions, other than the getMeal action
    return MealState.copyWith(
      meals: mealState.meals..add(action.meal!),
      isLoading: false,
    );
  }

  if (action is ShowMeals) {
    return MealState.copyWith(
      meals: action.meals,
      isLoading: false,
    );
  }

  return MealState.copyWith(
    meals: mealState.meals,
    isLoading: mealState.loading,
  );
}
