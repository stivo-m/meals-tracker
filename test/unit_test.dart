import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/services/auth/base_auth_service.dart';
import 'package:meal_tracker/services/meals/base_meal_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  BaseMealService,
  BaseAuthService,
  FirebaseAuth,
  FirebaseFirestore,
])
void main() {
  // late MockUser mockUser;

  setUpAll(() {});

  group(
    "-- Meals Test -- ",
    () {
      test(
        "when called, should add a meal to the db (firestore) and return the meal",
        () async {
          // get a meal from user input
          // save the meal in firestore, for the user
          // obtain the meal from the firestore instance
        },
      );
    },
  );
}
