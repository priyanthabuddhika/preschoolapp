import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:preschool_app/models/child.dart';
import 'package:shared_preferences/shared_preferences.dart';
// This class perform needed Firestore & Shared preferences functions
class DatabaseService {
  String uid;

  DatabaseService({this.uid});
  CollectionReference childCollection;
  final CollectionReference userCollection =
      Firestore.instance.collection('UserCol');
/* 
  Future updateUserData(String child, int age, String name) async {
    addStringToSF(name);
    return await userCollection.document(uid).setData({
      'child': child,
      'age': age,
      'name': name,
    });
  }
*/
// Add selected child to sharedPreferences
  addStringToSF(String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('selectedChild', value);
    } catch (e) {
      print(e.toString());
    }
  }
// Get currently selected child from sharedpreferences
  Future<String> getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('selectedChild');
    print('dsfjl$stringValue');
    return stringValue;
  }
// Add child profile to firestore
  Future addChild(String name, String age) async {
    addStringToSF(name);
    return await userCollection
        .document(uid)
        .collection('Child')
        .document(name)
        .setData({
      'Name': name,
      'Age': age,
    });
  }

  List<Child> _childlistFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Child(
        name: doc.data['Name'] ?? '',
        age: doc.data['Age'] ?? '',
      );
    }).toList();
  }

  Stream<List<Child>> get childInfo {
    return userCollection
        .document(uid)
        .collection('Child')
        .snapshots()
        .map(_childlistFromSnapshot);
  }
}
