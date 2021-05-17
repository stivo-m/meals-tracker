import 'package:meal_tracker/models/meal_model.dart';

abstract class MealActions {}

class AddMeal implements MealActions {
  final Meal meal;

  AddMeal({
    required this.meal,
  });
}

class GetMeal implements MealActions {
  final String id;

  GetMeal({
    required this.id,
  });
}

class UpdateMeal implements MealActions {
  final Meal meal;
  List<dynamic> updates;

  UpdateMeal({
    required this.meal,
    required this.updates,
  });
}

class RemoveMeal implements MealActions {
  final Meal meal;

  RemoveMeal({
    required this.meal,
  });
}

class MealUpdated implements MealActions {}
