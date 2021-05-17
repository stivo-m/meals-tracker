import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/services/auth/base_auth_service.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([FirebaseAuth, User, UserCredential, BaseAuthService])
void main() {
  // late MockUser mockUser;

  setUpAll(() {});

  group(
    "Authentication Test -- ",
    () {},
  );
  group(
    "Meals Test -- ",
    () {
      test(
        "when called, should save meals using the meal service class, and firestore",
        () async {
          // get a meal from user input
          // save the meal in firestore, for the user
        },
      );
    },
  );
}
