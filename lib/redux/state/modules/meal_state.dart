import 'package:meal_tracker/models/meal_model.dart';

class MealState {
  final List<Meal> meals;
  final bool loading;

  MealState({
    required this.meals,
    required this.loading,
  });

  MealState.initialState()
      : this.meals = List<Meal>.unmodifiable([]),
        this.loading = false;

  MealState.copyWith({
    required List<Meal> meals,
    required bool isLoading,
  })   : this.loading = isLoading,
        this.meals = meals;
}
