import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthService {
  FireBaseAuthService(this._firebaseAuth);
  final FirebaseAuth _firebaseAuth;

  Stream<User?> get user => _firebaseAuth.userChanges();
  User? get currentUser => _firebaseAuth.currentUser;
  Future<String> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return "";
    } on FirebaseAuthException catch (error) {
      return error.message ??
          "Error occurred while logging in. Please try again.";
    }
  }

  Future<String> signUp(String email, String password, String username) async {
    try {
      var newUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      await newUser.user!.updateDisplayName(username);
      //await newUser.user!.reload();

      return "";
    } on FirebaseAuthException catch (error) {
      return error.message ??
          "Error occurred while logging in. Please try again.";
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
