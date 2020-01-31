import 'package:flutter/material.dart';

class Games extends StatefulWidget {
  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.lightBlue,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "Games",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () async {},
          ),
        ],
      ),
      body: Container(
        // TODO
      ),   
    );
  }
}