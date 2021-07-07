import 'package:firebase_auth/firebase_auth.dart';
import 'package:money/models/user.dart' as my;

class AuthenticateService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  my.User? _userFromFirebaseUser(User? user) {
    return user == null ? null : my.User(uid: user.uid);
  }

  Future register(String email, String password) async {
    try {
      UserCredential userCred = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(userCred.user);
    } catch (e) {
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      UserCredential userCred = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromFirebaseUser(userCred.user);
    } catch (e) {
      return null;
    }
  }

  Stream<my.User?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  Future logOut() async {
    await _auth.signOut();
  }

  Future signInAnon() async {
    await _auth.signInAnonymously();
  }
}
