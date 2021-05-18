import 'package:meal_tracker/models/meal_model.dart';
import 'package:meal_tracker/screens/widgets/date_card_widget.dart';

List<DateCard> dateCards = [
  DateCard(
    day: "SU",
    date: 8,
    hasMeal: true,
  ),
  DateCard(
    day: "MO",
    date: 9,
  ),
  DateCard(
    day: "TU",
    date: 10,
    hasMeal: true,
    isToday: true,
  ),
  DateCard(
    day: "WE",
    date: 11,
    hasMeal: true,
  ),
  DateCard(
    day: "TH",
    date: 12,
  ),
  DateCard(
    day: "FR",
    date: 13,
  ),
  DateCard(
    day: "SA",
    date: 14,
    hasMeal: true,
  ),
];

List<Meal> meals = [
  Meal(
    id: "1234",
    name: "Bread and Milk",
    description: "The breakfast meal for most people",
    imageUrl: "",
    user: "",
    savedAt: DateTime.now(),
    updatedAt: DateTime.now(),
    remindAt: DateTime.now(),
    mealType: MealType.BREAKFAST,
  ),
  Meal(
    id: "1235",
    name: "Rice with Beef",
    description: "The lunch meal for most people",
    imageUrl: "",
    user: "",
    savedAt: DateTime.now(),
    updatedAt: DateTime.now(),
    remindAt: DateTime.now(),
    mealType: MealType.LUNCH,
  ),
  Meal(
    id: "1236",
    name: "Bread and Milk",
    description: "The snack meal for most people",
    imageUrl: "",
    user: "",
    savedAt: DateTime.now(),
    updatedAt: DateTime.now(),
    remindAt: DateTime.now(),
    mealType: MealType.SNACK,
  ),
  Meal(
    id: "1237",
    name: "Rice with Beef",
    description: "The dinner meal for most people",
    imageUrl: "",
    user: "",
    savedAt: DateTime.now(),
    updatedAt: DateTime.now(),
    remindAt: DateTime.now(),
    mealType: MealType.DINNER,
  ),
];
