import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/services/auth/auth_service.dart';
import 'package:meal_tracker/services/meals/meals_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mocks.dart';
import 'unit_test.mocks.dart';

@GenerateMocks([MealService, AuthService, FirebaseAuth, UserCredential, User])
void main() {
  setupFirebaseAuthMocks();

  late MockAuthService _authService;
  late MockFirebaseAuth _firebaseAuth;
  late MockUserCredential _userCredentials;
  late MockUser _user;
  final String email = 'test@gmail.com', password = "testpassword";

  _setupStubs() {
    when(_userCredentials.user).thenReturn(_user);
    // setup callback for authentication
    when(_firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password))
        .thenAnswer(
      (realInvocation) => Future.value(_userCredentials),
    );
    when(_firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .thenAnswer(
      (realInvocation) => Future.value(_userCredentials),
    );

    when(_authService.currentUser).thenReturn(_user);

    when(_authService.loginWithEmailAndPassword(email, password)).thenAnswer(
      (realInvocation) => _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password),
    );
    when(_authService.registerWithEmailAndPassword(email, email, password))
        .thenAnswer(
      (realInvocation) => _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password),
    );
  }

  _signOutStubs() {
    when(_authService.currentUser).thenReturn(null);

    when(_firebaseAuth.signOut()).thenAnswer(
      (realInvocation) => Future.value(null),
    );

    when(_authService.signOut()).thenAnswer(
      (realInvocation) => _firebaseAuth.signOut(),
    );
  }

  setUpAll(() async {
    await Firebase.initializeApp();
    _authService = MockAuthService();
    _firebaseAuth = MockFirebaseAuth();
    _userCredentials = MockUserCredential();
    _user = MockUser();

    _setupStubs();
  });
  group("-- Authentication Tests --", () {
    test(
      "sign in with email and password",
      () async {
        await _authService.loginWithEmailAndPassword(email, password);
        expect(_authService.currentUser, _user);
      },
    );
    // test(
    //   "sign in with google",
    //   () async {
    //     await _authService.signInWithGoogle();
    //     expect(_authService.currentUser, _user);
    //   },
    // );

    test(
      "register  with email and password",
      () async {
        await _authService.registerWithEmailAndPassword(email, email, password);
        expect(_authService.currentUser, _user);
      },
    );

    test("signout currently logged in user", () async {
      await _authService.registerWithEmailAndPassword(email, email, password);
      _signOutStubs();
      await _authService.signOut();

      expect(_authService.currentUser, null);
    });
  });
}
