import 'package:meal_tracker/models/meal_model.dart';

abstract class BaseMealService {
  Future addMeal({required Meal meal}) async {}
  Future getMeal({required String id}) async {}
  Future updateMeal(
      {required Meal meal, required List<dynamic> updates}) async {}
  Future deleteMeal({required Meal meal}) async {}
}
