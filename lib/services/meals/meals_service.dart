import 'package:meal_tracker/models/meal_model.dart';
import 'package:meal_tracker/services/auth/auth_service.dart';
import 'package:meal_tracker/services/meals/base_meal_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealService implements BaseMealService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late CollectionReference<Map<String, dynamic>> _mealsCollection;
  MealService() {
    // the collection should be meals-userid for future reference
    _mealsCollection = _firestore.collection(
      "meals-" + authservice.currentUser!.uid.toString(),
    );
  }

  @override
  Future<List<Meal>> getMeals() async {
    List<Meal> meals;
    QuerySnapshot documents = await _mealsCollection.get();
    meals = documents.docs.map((doc) => Meal.fromDoc(doc)).toList();
    return meals;
  }

  @override
  Future<List<Meal>> getMealsForDay(String day, List<Meal> meals) async {
    List<Meal> mealsForDay;
    mealsForDay = meals.where((Meal meal) => meal.day == day).toList();
    return mealsForDay;
  }

  @override
  // returns a document snapshot containing the meal from db
  Future<Meal> addMeal({required Meal meal}) async {
    // add a meal to the firestore database
    DocumentReference doc = await _mealsCollection.add(meal.toDoc(meal));
    return Meal.fromDoc(await doc.get());
  }

  @override
  Future updateMeal({required Meal meal, required List updates}) async {
    await _mealsCollection.doc(meal.id).update(Map.fromIterable(updates));
  }

  @override
  Future deleteMeal({required Meal meal}) async {
    await _mealsCollection.doc(meal.id).delete();
  }
}

MealService mealService = MealService();
