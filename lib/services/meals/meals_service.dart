import 'package:meal_tracker/models/meal_model.dart';
import 'package:meal_tracker/services/auth/auth_service.dart';
import 'package:meal_tracker/services/meals/base_meal_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealService implements BaseMealService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Future addMeal({required Meal meal}) async {
    // add a meal to the firestore database
    // the collection should be meals-userid for future reference
    await _firestore
        .collection(
          "meals-" + authservice.currentUser!.uid.toString(),
        )
        .add(meal.toDoc(meal));
  }

  @override
  Future getMeal({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future updateMeal({required Meal meal, required List updates}) {
    throw UnimplementedError();
  }

  @override
  Future deleteMeal({required Meal meal}) async {
    await _firestore
        .collection(
          "meals-" + authservice.currentUser!.uid.toString(),
        )
        .add(meal.toDoc(meal));
  }
}
