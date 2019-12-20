import 'package:flutter/material.dart';
import 'package:preschool_app/services/auth.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _auth = AuthService();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(15.0),
            color: Colors.blueAccent[200],
            child: ListTile(
              title: Text('Priyantha'),
              subtitle: Text('abc@abc.com'),
              trailing: CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage('images/profile.png'),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            padding: EdgeInsets.fromLTRB(0, 50, 20, 0),
            color: Colors.cyanAccent,
            child: Text('Welcome To Parent Dashboard'),
          ),
        ],
      ),
    );
  }
}

/* appBar: AppBar(
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



       



       */
