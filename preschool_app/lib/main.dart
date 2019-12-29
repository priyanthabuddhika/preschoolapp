import 'package:flutter/material.dart';
import 'package:preschool_app/models/users.dart';
import 'package:preschool_app/screens/screens/wrapper.dart';
import 'package:preschool_app/services/auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Stream Provider always stream userStrm 
    return StreamProvider<User>.value(
      value: AuthService().userStrm,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // creates Wrapper class object
        home: Wrapper(),
      ),
    );
  }
}
