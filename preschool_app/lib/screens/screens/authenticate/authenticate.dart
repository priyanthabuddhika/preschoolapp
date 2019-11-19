import 'package:flutter/material.dart';
import 'package:preschool_app/screens/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return signIn();
  }
}