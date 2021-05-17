import 'package:firebase_auth/firebase_auth.dart';
import 'package:meal_tracker/services/auth/base_auth_service.dart';

class AuthService implements BaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future loginWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}

AuthService authservice = AuthService();
