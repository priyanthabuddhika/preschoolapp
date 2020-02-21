import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/models/lesson.dart';
import 'package:preschool_app/screens/activity/char_selecter.dart';
import 'package:preschool_app/screens/activity/detail_page.dart';
import 'package:preschool_app/services/database.dart';

// Lesson list class UI
class LevelOneActivity extends StatefulWidget {
  final String uid;
  LevelOneActivity({
    Key key,
    @required this.uid, 
  }) : super(key: key);

  @override
  _LevelOneActivityState createState() => _LevelOneActivityState();
}

class _LevelOneActivityState extends State<LevelOneActivity> {
  List lessons; 
  String name;

  _LevelOneActivityState();// Lesson List

  @override
  void initState() {
      
      DatabaseService().getStringValuesSF().then((onValue){
      print('jdjklj'+onValue);
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
            if (lesson.color != null) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CharSelectPage(lesson: lesson.title,name: name,)));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(lesson: lesson.title, name: name,)));
            }
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
          "Level 1",
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
      title: "Letters",
      level: "Easy",
      indicatorValue: 0.33,
      icon: FontAwesomeIcons.adn,
    ),
    Lesson(
      title: "Numbers",
      level: "Easy",
      indicatorValue: 0.33,
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
      icon: FontAwesomeIcons.cat,
    ),
    Lesson(
      title: "Vehicles",
      level: "Medium",
      indicatorValue: 1.0,
      icon: FontAwesomeIcons.truck,
    ),
    Lesson(
      title: "Shapes",
      level: "Medium",
      indicatorValue: 1.0,
      icon: FontAwesomeIcons.shapes,
    ),
    Lesson(
      title: "Relatives",
      level: "Hard",
      indicatorValue: 1.0,
      icon: FontAwesomeIcons.restroom,
    ),
    Lesson(
      title: "Body Parts",
      level: "Hard",
      indicatorValue: 1.0,
      icon: FontAwesomeIcons.male,
    ),
  ];
}
