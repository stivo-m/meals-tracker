class Meal {
  final String name, description, imageUrl;
  final String user;
  final DateTime savedAt, updatedAt, remindAt;

  Meal({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.user,
    required this.savedAt,
    required this.updatedAt,
    required this.remindAt,
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
}
