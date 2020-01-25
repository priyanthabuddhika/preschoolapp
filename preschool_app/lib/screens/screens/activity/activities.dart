import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/models/lesson.dart';
import 'package:preschool_app/screens/screens/activity/detail_page.dart';
import 'package:preschool_app/screens/screens/drawer/sidebar.dart';
import 'package:preschool_app/screens/screens/drawer/bottombar.dart';

class Activity extends StatefulWidget {
  final String uid;

  Activity({
    Key key,
    @required this.uid,
  }) : super(key: key);

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  List lessons;
  
  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(Lesson lesson) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(lesson.icon, color: Colors.white),
          ),
          title: Text(
            lesson.title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 40.0),
          ),
          subtitle: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Container(
                    // tag: 'hero',
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.2),
                        value: lesson.indicatorValue,
                        valueColor: AlwaysStoppedAnimation(Colors.yellow)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(lesson.level,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            SpinKitWave(
              color: Colors.blue,
              size: 50.0,
            );
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailPage(lesson: lesson.title)));
          },
        );

    Card makeCard(Lesson lesson) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: 120.0,
            decoration: BoxDecoration(
              color: Color.fromRGBO(150, 60, 80, 1.0),
              borderRadius: BorderRadius.circular(15),
            ),
            child: makeListTile(lesson),
          ),
        );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(lessons[index]);
        },
      ),
    );

    final makeBottom = BottomBar();

    Future<bool> _onWillPop() {
      return showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Do you want to exit App'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                FlatButton(
                  onPressed: () => exit(0),
                  /*Navigator.of(context).pop(true)*/
                  child: Text('Yes'),
                ),
              ],
            ),
          ) ??
          false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          elevation: 0,
          iconTheme: new IconThemeData(color: Colors.white),
          title: Text(
            "Lessons",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: <Widget>[
            PopupMenuButton(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Icon(FontAwesomeIcons.userCircle),
              ),
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    child: IconButton(
                      icon: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Icon(Icons.email),
                      ),
                      onPressed: () {
                        clicked(context, "Email sent");
                      },
                    ),
                  ),
                ];
              },
            )
          ],
        ),
        body: makeBody,
        bottomNavigationBar: makeBottom,
        drawer: SideBar('Activity'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          child: Icon(Icons.fastfood),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

void clicked(BuildContext context, menu) {
  final scaffold = Scaffold.of(context);
  scaffold.showSnackBar(
    SnackBar(
      content: Text(menu),
      action: SnackBarAction(
          label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
    ),
  );
}

List getLessons() {
  return [
    Lesson(
      title: "Letters",
      level: "Easy",
      indicatorValue: 0.33,
      price: 20,
      icon: FontAwesomeIcons.adn,
    ),
    Lesson(
      title: "Numbers",
      level: "Easy",
      indicatorValue: 0.33,
      price: 50,
      icon: FontAwesomeIcons.sortNumericUp,
    ),
    Lesson(
      title: "Colours",
      level: "Medium",
      indicatorValue: 0.66,
      icon: FontAwesomeIcons.pallet,
    ),
    Lesson(
      title: "Animals",
      level: "Medium",
      indicatorValue: 0.66,
      price: 30,
      icon: FontAwesomeIcons.cat,
    ),
    Lesson(
      title: "Vehicles",
      level: "Medium",
      indicatorValue: 1.0,
      price: 50,
      icon: FontAwesomeIcons.truck,
    ),
    Lesson(
      title: "Shapes",
      level: "Medium",
      indicatorValue: 1.0,
      price: 50,
      icon: FontAwesomeIcons.shapes,
    ),
    Lesson(
      title: "Relatives",
      level: "Hard",
      indicatorValue: 1.0,
      price: 50,
      icon: FontAwesomeIcons.restroom,
    ),
    Lesson(
      title: "Body Parts",
      level: "Hard",
      indicatorValue: 1.0,
      price: 50,
      icon: FontAwesomeIcons.male,
    )
  ];
}
