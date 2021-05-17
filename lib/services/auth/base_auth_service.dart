import 'package:firebase_auth/firebase_auth.dart';

abstract class BaseAuthService {
  User? get currentUser;
  Future loginWithEmailAndPassword(String email, String password) async {}
  Future registerWithEmailAndPassword(
      String name, String email, String password) async {}
  Future signInWithGoogle() async {}
  Future signOut() async {}
}
