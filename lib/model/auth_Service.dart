import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> signUp(String email, String pass) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      User firebaseUser = result.user;
      return firebaseUser;
      
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User> signIn(String email, String pass) async {
    try {
      UserCredential result =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      User firebaseUser = result.user;
      return firebaseUser;

    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User> signOut() async {
    await _auth.signOut();
    return null;
  }

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
