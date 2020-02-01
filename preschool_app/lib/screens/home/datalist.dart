import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/models/child.dart';
import 'package:preschool_app/screens/home/progress.dart';
import 'package:preschool_app/screens/home/report_page.dart';
import 'package:provider/provider.dart';

// This class get a child stream from firestore and create a list of child in Home UI 

class ChildList extends StatefulWidget {
  @override
  _ChildListState createState() => _ChildListState();
}

class _ChildListState extends State<ChildList> {
  // TExt theme properties
  final TextStyle whiteText = TextStyle(color: Colors.white);
  final TextStyle blackText = TextStyle(color: Colors.black);
  bool hasChild = false;
  @override
  Widget build(BuildContext context) {
    final children = Provider.of<List<Child>>(context); // Get Child object list from stream provider
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
              return ChildTile(children[index].name,children[index].age);
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

  ChildTile(this.name, this.age);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
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
                    builder: (context) => Progress(),
                  ),
                );
              },
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
                    builder: (context) => ReportPage(this.name,this.age),
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
