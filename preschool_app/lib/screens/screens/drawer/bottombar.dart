import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 8.0,
      shape: CircularNotchedRectangle(),
      notchMargin: 5.0,
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.font_download, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(FontAwesomeIcons.gamepad, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      );
  }
}