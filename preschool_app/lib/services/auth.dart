import 'package:firebase_auth/firebase_auth.dart';
import 'package:preschool_app/models/users.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based onfirebaseUser
  User _userfromFirebase(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }
  // Auth Change User Stream

  Stream<User> get userStrm {
    return _auth.onAuthStateChanged
    .map(_userfromFirebase);
  }

  // Log in with anonymous

  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Register user with Email and Pwd

  Future registerUserwithEmailandPwd(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


  // Sign in with Email and Password

  Future signInwithEmailandPwd(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sign out 
  
  Future signingOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
