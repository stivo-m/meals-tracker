import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  final String id;
  final String name, description, imageUrl;
  final String user;
  final DateTime savedAt, updatedAt, remindAt;
  final MealType mealType;
  Meal({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.user,
    required this.savedAt,
    required this.updatedAt,
    required this.remindAt,
    this.mealType = MealType.BREAKFAST,
  });

  Map<String, dynamic> toDoc(Meal meal) {
    Map<String, dynamic> mealDoc = Map<String, dynamic>();
    mealDoc['name'] = meal.name;
    mealDoc['description'] = meal.description;
    mealDoc['imageUrl'] = meal.imageUrl;
    mealDoc['user'] = meal.user;
    mealDoc['savedAt'] = meal.savedAt;
    mealDoc['updatedAt'] = meal.updatedAt;
    mealDoc['remindAt'] = meal.remindAt;
    return mealDoc;
  }

  Meal.fromDoc(DocumentSnapshot snapshot)
      : this.id = snapshot.id,
        this.name = snapshot['name'],
        this.description = snapshot['description'],
        this.imageUrl = snapshot['imageUrl'],
        this.user = snapshot['user'],
        this.savedAt = snapshot['savedAt'],
        this.updatedAt = snapshot['updatedAt'],
        this.remindAt = snapshot['remindAt'],
        this.mealType = snapshot['mealType'] ?? MealType.BREAKFAST;

  static String mealTypeString(MealType mealType) {
    switch (mealType) {
      case MealType.BREAKFAST:
        return 'Breakfast';
      case MealType.LUNCH:
        return 'Lunch';
      case MealType.SNACK:
        return 'Snack';
      case MealType.DINNER:
        return 'Dinner';

      default:
        return '';
    }
  }
}

enum MealType {
  BREAKFAST,
  LUNCH,
  SNACK,
  DINNER,
}
