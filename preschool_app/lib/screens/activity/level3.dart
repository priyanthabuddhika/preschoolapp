import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/models/lesson.dart';
import 'package:preschool_app/screens/activity/word_selecter.dart';
import 'package:preschool_app/services/database.dart';

// Lesson list class UI
class LevelThreeActivity extends StatefulWidget {
  final String uid;
  LevelThreeActivity({
    Key key,
    @required this.uid,
  }) : super(key: key);

  @override
  _LevelThreeActivityState createState() => _LevelThreeActivityState();
}

class _LevelThreeActivityState extends State<LevelThreeActivity> {
  List lessons; // Lesson List
  String name;

  _LevelThreeActivityState();
  @override
  void initState() {
    DatabaseService().getStringValuesSF().then((onValue) {
      print('jdjklj' + onValue);
      updateName(onValue);
    });
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WordSelectPage(
                          lesson: lesson.title,
                          name: name,
                        )));
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
              color: lesson.color ?? Color.fromRGBO(150, 60, 80, 1.0),
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "Level 3",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: makeBody,
    );
  }

  void updateName(String name) {
    setState(() {
      this.name = name;
    });
  }
}

List getLessons() {
  return [
    Lesson(
      title: 'Letters',
      level: 'Level 3',
      indicatorValue: 0.5,
      icon: FontAwesomeIcons.question,
      color: Colors.teal,
    ),
    Lesson(
        title: "Numbers",
        level: "Level 3",
        indicatorValue: 0.33,
        icon: FontAwesomeIcons.question,
        color: Colors.teal),
    Lesson(
        title: "Colours",
        level: "Level 3",
        indicatorValue: 0.33,
        icon: FontAwesomeIcons.question,
        color: Colors.teal),
    Lesson(
        title: "Animals",
        level: "Level 3",
        indicatorValue: 0.33,
        icon: FontAwesomeIcons.question,
        color: Colors.teal),
    Lesson(
        title: "Vehicles",
        level: "Level 3",
        indicatorValue: 0.33,
        icon: FontAwesomeIcons.question,
        color: Colors.teal),
    Lesson(
        title: "Shapes",
        level: "Level 3",
        indicatorValue: 0.33,
        icon: FontAwesomeIcons.question,
        color: Colors.teal),
    Lesson(
        title: "Relatives",
        level: "Level 3",
        indicatorValue: 0.33,
        icon: FontAwesomeIcons.question,
        color: Colors.teal),
    Lesson(
        title: "Body Parts",
        level: "Level 3",
        indicatorValue: 0.33,
        icon: FontAwesomeIcons.question,
        color: Colors.teal),
  ];
}
