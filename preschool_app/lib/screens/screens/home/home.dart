import 'package:flutter/material.dart';
import 'package:preschool_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {

  static final String path = "lib\screens\screens\home\home.dart";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Text Style Variables
  final TextStyle whiteText = TextStyle(color: Colors.white); 
  final TextStyle blackText = TextStyle(color: Colors.black); 
  // Authservice Variable
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //Colors.grey.shade800,
      // Top appbar properties
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text("Home",style: TextStyle(color: Colors.white),),
        centerTitle: true,
         actions: <Widget>[
            FlatButton.icon(
              label: Text('Sign Out',style: TextStyle(color: Colors.white),),
              icon: Icon(Icons.person,color: Colors.white,),
              onPressed: () async {
                await _auth.signingOut();
              },
            )
          ],
      ),

      // Side bar menu properties

      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('abc@abc.com'),
              accountName: Text('User Test'),
              currentAccountPicture: CircleAvatar(backgroundImage: AssetImage('images/profile.png'),),),
            Padding(padding: EdgeInsets.only(top: 20.0),),
            ListTile(leading: Icon(Icons.home), title: Text('Home'),),
            ListTile(leading: Icon(Icons.local_activity), title: Text('Activity'),),
            Divider(),
           Expanded(
             child: Align(
               alignment: FractionalOffset.bottomCenter,
               child: ListTile(leading: Icon(Icons.settings), title: Text('Settings'),),
             ),
           )
          ],
        ),
      ),

      body:_buildBody(context),
        );
  }
   // Body properties goes here
  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 50.0),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 190,
                      color: Colors.blue,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Kamal",
                              style:
                                  Theme.of(context).textTheme.display1.copyWith(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                      ),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.walking,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Progress',
                              style: whiteText,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 120,
                      color: Colors.green,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Kamal",
                              style:
                                  Theme.of(context).textTheme.display1.copyWith(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                      ),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.heartbeat,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Report',
                              style: whiteText,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 120,
                      color: Colors.red,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Nimal",
                              style:
                                  Theme.of(context).textTheme.display1.copyWith(
                                        color: Colors.white,
                                        fontSize: 24.0,
                                      ),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.fire,
                              color: Colors.white,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Progress',
                              style: whiteText,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      height: 190,
                      color: Colors.yellow,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Nimal",
                              style:
                                  Theme.of(context).textTheme.display1.copyWith(
                                        fontSize: 24.0,
                                        color: Colors.black,
                                      ),
                            ),
                            trailing: Icon(
                              FontAwesomeIcons.road,
                              color: Colors.black,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(
                              'Report',
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
// Header and title properties goes here
  Widget _buildHeader() {
    return Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            value: 0.5,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            backgroundColor: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Preschool\nArcade Dashboard",
                style: blackText.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              Text(
                "45% to go",
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
        )
      ],
    );
  }

 }


