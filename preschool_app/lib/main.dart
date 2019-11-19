import 'package:flutter/material.dart';
import 'package:preschool_app/screens/screens/wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Wrapper()
    );
  }
}
