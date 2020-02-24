import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:preschool_app/services/auth.dart';

// SideBar Drawer class

class SideBar extends StatefulWidget {
  final String selectedTab;
  SideBar(this.selectedTab);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  final AuthService _authService = AuthService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromRGBO(26, 215, 192, 1.0),
            ),
            accountEmail: Text("${user?.email}"),
            accountName: Text("${user?.displayName}"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/profile.png'),
              backgroundColor: Color.fromRGBO(18, 153, 136, 1.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
          ListTile(
            leading: Icon(
              Icons.local_activity,
              color: Color.fromRGBO(114, 238, 215, 1.0),
            ),
            title: Text('Activity'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                '/',
                arguments: "${user?.uid}",
              );
            },
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Color.fromRGBO(191, 148, 255, 1.0),
            ),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                '/Home',
                arguments: "${user?.uid}",
              );
            },
          ),
          Divider(),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  color: Color.fromRGBO(158, 227, 115, 1.0),
                ),
                title: Text('Sign Out'),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // return object of type Dialog
                      return AlertDialog(
                        title: new Text("Are you sure?"),
                        content: new Text(
                            "If you click sign out you will be signed out immediately"),
                        actions: <Widget>[
                          // usually buttons at the bottom of the dialog
                          new FlatButton(
                            child: new Text("Close"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          new FlatButton(
                            child: new Text(
                              "Sign Out",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () async {
                              await _authService.signingOut();
                              Navigator.popUntil(
                                  context,
                                  ModalRoute.withName(
                                      Navigator.defaultRouteName));
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
