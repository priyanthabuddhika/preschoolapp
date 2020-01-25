import 'package:flutter/material.dart';
import 'package:preschool_app/screens/screens/activity/activities.dart';
import 'package:preschool_app/screens/screens/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:preschool_app/models/users.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // Return either authenticate or home
    if (user == null) {
      return Authenticate();
    } else {
      return Activity(uid: user.uid);
    }
  }
}
