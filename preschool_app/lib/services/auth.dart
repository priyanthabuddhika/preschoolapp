import 'package:firebase_auth/firebase_auth.dart';
import 'package:preschool_app/models/users.dart';
import 'package:preschool_app/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user obj based on firebaseUser
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

  Future registerUserwithEmailandPwd(String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = name;
      result.user.updateProfile(updateInfo);
      FirebaseUser user = result.user;
      return _userfromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
// 

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
// Adding a child to firestore
  Future addChild(String name, String age) async {
    try {
        final FirebaseUser user = await _auth.currentUser();
        final String uid = user.uid;

         await DatabaseService(uid: uid).addChild(name, age);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
