import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Bottom bar used in Acivities and games

class BottomBar extends StatelessWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8.0,
      shape: CircularNotchedRectangle(),
      notchMargin: 5.0,
      color: Colors.white, //Color.fromRGBO(58, 66, 86, 1.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.font_download, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                '/',
              );
            },
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.gamepad, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                '/Games',
              );
            },
          )
        ],
      ),
    );
  }
}
