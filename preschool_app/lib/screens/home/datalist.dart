import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/models/child.dart';
import 'package:preschool_app/screens/home/progress.dart';
import 'package:preschool_app/screens/home/report_page.dart';
import 'package:preschool_app/services/database.dart';
import 'package:provider/provider.dart';

// This class get a child stream from firestore and create a list of child in Home UI

class ChildList extends StatefulWidget {
  final String uid;
  ChildList(this.uid);
  @override
  _ChildListState createState() => _ChildListState(uid);
}

class _ChildListState extends State<ChildList> {
  final String uID;
  _ChildListState(this.uID);
  // TExt theme properties
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final TextStyle blackText = TextStyle(color: Colors.black);
  bool hasChild = false;
  @override
  Widget build(BuildContext context) {
    final children = Provider.of<List<Child>>(
        context); // Get Child object list from stream provider
    if (children.isNotEmpty) {
      setState(() {
        hasChild = true;
      });
    }
    children.forEach((child) {
      print(child.name);
      print(child.age);
    });
    return hasChild
        ? ListView.builder(
            itemCount: children.length,
            itemBuilder: (context, index) {
              return ChildTile(children[index].name, children[index].age, uID);
            },
          )
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.orange,
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          child: Text(
                            'No children found',
                            style:
                                Theme.of(context).textTheme.display1.copyWith(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                    ),
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.exclamationTriangle,
                          size: 50.0,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 20.0,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class ChildTile extends StatelessWidget {
  final String name;
  final String age;
  final String uId;
  // Text theme
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final TextStyle blackText = TextStyle(color: Colors.black);
  // List of colors randomly use in child list containers
  final List<Color> colorList = [
    Colors.green,
    Colors.yellow,
    Colors.red,
    Colors.blue,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.brown
  ];
  final _random = new Random();

  ChildTile(this.name, this.age, this.uId);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 20.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10.0),
                    child: FlatButton(
                      padding: EdgeInsets.all(0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: colorList[_random.nextInt(colorList.length)],
                        ),
                        height: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            ListTile(
                              title: Text(
                                name,
                                style: Theme.of(context)
                                    .textTheme
                                    .display1
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 24.0,
                                    ),
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
                      onPressed: () {
                        print('Test worked');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Progress(name: name,),
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    right: 0.0,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("Are you sure?"),
                              content: new Text(
                                  "Deleting a child profile will delete all data of this child including progress and full report"),
                              actions: <Widget>[
                                // usually buttons at the bottom of the dialog
                                new FlatButton(
                                  child: new Text(
                                    "Delete",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  onPressed: () {
                                    DatabaseService(uid: uId).deleteChild(name);
                                    Navigator.of(context).pop();
                                    Fluttertoast.showToast(
                                        msg:
                                            "Child profile deleted successfully",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIos: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0);
                                  },
                                ),
                                new FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.red,
                          child: Icon(Icons.close, color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.all(0),
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: colorList[_random.nextInt(colorList.length)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      title: Text(
                        name,
                        style: Theme.of(context).textTheme.display1.copyWith(
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
                        'Report',
                        style: whiteText,
                      ),
                    )
                  ],
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportPage(this.name, this.age),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
