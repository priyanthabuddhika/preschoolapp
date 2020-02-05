import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:preschool_app/services/auth.dart';

// SideBar Drawer class

class SideBar extends StatefulWidget {
  // TODO Selected tab higlight
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
              color: Color.fromRGBO(58, 66, 86, 1.0),
            ),
            accountEmail: Text("${user?.email}"),
            accountName: Text("${user?.displayName}"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('images/profile.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.0),
          ),
           ListTile(
            leading: Icon(Icons.local_activity),
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
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              Navigator.pop(context);
              Navigator.of(context).pushNamed(
                '/Home',
                arguments: "${user?.uid}",
              );},
          ),
         
          Divider(),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ListTile(
                leading: Icon(Icons.exit_to_app),
                title: Text('Sign Out'),
                onTap: () async {
                await _authService.signingOut();
                Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
              },
              ),
            ),
          )
        ],
      ),
    );
  }
}