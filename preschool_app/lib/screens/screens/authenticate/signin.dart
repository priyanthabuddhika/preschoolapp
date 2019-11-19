import 'package:flutter/material.dart';
import 'package:preschool_app/services/auth.dart';

class signIn extends StatefulWidget {
  @override
  _signInState createState() => _signInState();
}

class _signInState extends State<signIn> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent[100],
      appBar: AppBar(
        backgroundColor: Colors.blueAccent[500],
        elevation: 0.0,
        title: Text('Sign in to Pre School Arcade'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: RaisedButton(
          child: Text('Sign In'),
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null)
              print('Error');
            else
              print('Succesfully Signed In');
            print(result);
          },
        ),
      ),
    );
  }
}
