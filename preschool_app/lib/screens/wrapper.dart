import 'package:flutter/material.dart';
import 'package:preschool_app/models/child.dart';
import 'package:preschool_app/screens/activity/activity_List.dart';
import 'package:preschool_app/screens/authenticate/authenticate.dart';
import 'package:preschool_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:preschool_app/models/users.dart';
// This wrapper class help provide a Authenticate management to application
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    // Return either authenticate or Activity
    if (user == null) {
      return 
      Authenticate();
    } else {
      return StreamProvider<List<Child>>.value(
      value: DatabaseService(uid: user.uid).childInfo,
      child:ActivityList(uid: user.uid),);
    }
  }
}
