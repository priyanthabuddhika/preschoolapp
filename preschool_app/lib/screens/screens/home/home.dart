import 'package:flutter/material.dart';
import 'package:preschool_app/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Pre School Arcade'),
        backgroundColor: Colors.white70,
        actions: <Widget>[
          FlatButton.icon(
            label: Text('Sign Out'),
            icon: Icon(Icons.person),
            onPressed: () async {
              await _auth.signingOut();
              
            },
          )
        ],
      ),
    );
  }
}
