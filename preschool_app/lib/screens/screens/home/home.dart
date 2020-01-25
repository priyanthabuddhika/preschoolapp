import 'package:flutter/material.dart';
import 'package:preschool_app/screens/screens/drawer/sidebar.dart';
import 'package:preschool_app/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:preschool_app/services/database.dart';

class Home extends StatefulWidget {
  final String uid;

  Home(this.uid);
  @override
  _HomeState createState() => _HomeState(uid);
}

class _HomeState extends State<Home> {
  final String uid;
  _HomeState(this.uid);
  // form key state
  final _formKey = GlobalKey<FormState>();
  // Text Style Variables
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final TextStyle blackText = TextStyle(color: Colors.black);

  // Authservice Variable
  final AuthService _auth = AuthService();

  // Add child form variables
  String kidName = '';
  String kidAge = '';

  @override
  Widget build(BuildContext context) {
    print(uid);
    return Scaffold(
      backgroundColor: Colors.white, //Colors.grey.shade800,
      // Top appbar properties
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "Home",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async {
              await _auth.signingOut();
            },
          ),
        ],
      ),
      // Side bar menu properties
      drawer: SideBar('Home'),
      body: _buildBody(context),
      // Floating Action button properties
      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          overlayColor: Colors.black,
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              label: 'Add Child',
              backgroundColor: Colors.red,
              onTap: () {
                // Add child dialog form properties
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      title: Text("Add Child"),
                      content: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Enter Kid\'s Name'),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter a name' : null,
                                onChanged: (val) {
                                  setState(() {
                                    kidName = val;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                    hintText: 'Enter Kid\'s Age'),
                                keyboardType: TextInputType.numberWithOptions(),
                                validator: (val) =>
                                    val.isEmpty ? 'Enter kid\'s Age' : null,
                                onChanged: (val) {
                                  setState(() {
                                    kidAge = val;
                                  });
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Text("Add Child", style: TextStyle(color: Colors.white),),
                                color: Colors.red[700],
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.save();
                                    _auth.addChild(kidName, kidAge);
                                    Navigator.pop(context);
                                    Fluttertoast.showToast(
                                        msg: "Child Added Successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIos: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  }
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ]),
    );
  }

  // Body properties goes here
  Widget _buildBody(BuildContext context) {
    DatabaseService(uid: uid).getData();
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
                "English Learning App",
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}




