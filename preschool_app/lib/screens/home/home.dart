import 'package:flutter/material.dart';
import 'package:preschool_app/models/child.dart';
import 'package:preschool_app/screens/drawer/sidebar.dart';
import 'package:preschool_app/screens/home/datalist.dart';
import 'package:preschool_app/services/auth.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:preschool_app/services/database.dart';

// HOme UI class for parents, THey can add a child profile and see progress and report of each child
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
    return StreamProvider<List<Child>>.value(
      value: DatabaseService(uid: uid).childInfo,
      child: Scaffold(
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
        ),
        // Side bar menu properties
        drawer: SideBar('Home'),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 4.0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                          height: 100,
                          width: 100,
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.blue,
                            backgroundImage: AssetImage('images/profile.png'),
                          )),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Preschool Arcade",
                              style: blackText.copyWith(
                                  fontSize: 20.0, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 15.0),
                            Text(
                              'Dashboard',
                              style: blackText.copyWith(
                                  fontSize: 15.0, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              flex: 1,
              child: ChildList(uid),
            ),
          ],
        ),
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
                                      hintText: 'Enter Kid\'s first Name'),
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
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
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
                                  child: Text(
                                    "Add Child",
                                    style: TextStyle(color: Colors.white),
                                  ),
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
      ),
    );
  }
}
