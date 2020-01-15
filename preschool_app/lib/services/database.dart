import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  String uid;

  DatabaseService({this.uid});
  final CollectionReference userCollection = Firestore.instance.collection('UserCol');


  Future updateUserData(String child, int age, String name) async {

    return await userCollection.document(uid).setData(
      {
        'child' : child,
        'age' : age,
        'name' : name,
      }
    );
  }

  Future addChild(String name, String age) async {

    return await userCollection.document(uid).collection('Child').document(name).setData(
      {
        'Name' : name,
        'Age' : age,
      }
    );
  }
} 