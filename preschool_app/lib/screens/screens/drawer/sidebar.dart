import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('abc@abc.com'),
            accountName: Text('Test'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/profile.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),

          ),
          ListTile(
            leading: Icon(Icons.local_activity),
            title: Text('Activity'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                '/activity',
                arguments: '',
              );
            },
          ),
          Divider(),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
