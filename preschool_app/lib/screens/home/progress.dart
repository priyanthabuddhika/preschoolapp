import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/models/lesson.dart';
// Selected child profile // TODO Get selected child and fetch data from the database to show child progress
class Progress extends StatefulWidget {
  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  List lessons;

  @override
  void initState() {
    lessons = getLessons();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile _makeListTile(Lesson lesson) => ListTile(
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
                  child: SizedBox(
                    height: 25.0,
                    // tag: 'hero',
                    child: LinearProgressIndicator(
                        backgroundColor: Color.fromRGBO(209, 224, 224, 0.3),
                        value: lesson.indicatorValue,
                        valueColor: AlwaysStoppedAnimation(Colors.yellow)),
                  )),

            ],
          ),
          trailing:
              Text('16%',style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold, color: Colors.white),),
        );

    Card _makeCard(Lesson lesson) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: 120.0,
            decoration: BoxDecoration(
              color: lesson.color,
              borderRadius: BorderRadius.circular(15),
            ),
            child: _makeListTile(lesson),
          ),
        );

    final _makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return _makeCard(lessons[index]);
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
          "Progress",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: _makeBody,
    );
  }
}

List getLessons() {
  return [
    Lesson(
      title: "Letters",
      indicatorValue: 0.33,
      icon: FontAwesomeIcons.adn,
      color: Color.fromRGBO(255, 91, 123, 1),
    ),
    Lesson(
      title: "Numbers",
      indicatorValue: 0.33,
      icon: FontAwesomeIcons.sortNumericUp,
      color: Color.fromRGBO(114,238,255,1),
    ),
    Lesson(
      title: "Colours",
      indicatorValue: 0.66,
      icon: FontAwesomeIcons.pallet,
       color: Color.fromRGBO(158,227,115,1),
    ),
    Lesson(
      title: "Animals",
      indicatorValue: 0.66,
      icon: FontAwesomeIcons.cat,
       color: Color.fromRGBO(37,238,214,1),
    ),
    Lesson(
      title: "Vehicles",
      indicatorValue: 1.0,
      icon: FontAwesomeIcons.truck,
       color: Color.fromRGBO(189,255,189,1),
    ),
    Lesson(
      title: "Shapes",
      indicatorValue: 1.0,
      icon: FontAwesomeIcons.shapes,
       color: Color.fromRGBO(74,202,187,1),
    ),
    Lesson(
      title: "Relatives",
      indicatorValue: 1.0,
      icon: FontAwesomeIcons.restroom,
       color: Color.fromRGBO(255,196,180,1),
    ),
    Lesson(
      title: "Body Parts",
      indicatorValue: 1.0,
      icon: FontAwesomeIcons.male,
       color: Color.fromRGBO(255,171,226,1),
    )
  ];
}
