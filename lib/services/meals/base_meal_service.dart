import 'package:meal_tracker/models/meal_model.dart';

abstract class BaseMealService {
  Future getMeals() async {}
  Future getMealsForDay(String day, List<Meal> meals) async {}
  Future addMeal({required Meal meal}) async {}
  Future updateMeal(
      {required Meal meal, required List<dynamic> updates}) async {}
  Future deleteMeal({required Meal meal}) async {}
}
