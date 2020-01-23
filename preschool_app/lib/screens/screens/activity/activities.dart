import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:preschool_app/models/lesson.dart';
import 'package:preschool_app/screens/screens/activity/detail_page.dart';

class Activity extends StatefulWidget {
  final String data;

  Activity({
    Key key,
    @required this.data,
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
            child: Icon(Icons.autorenew, color: Colors.white),
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
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.teal[300],
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

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0,
        iconTheme: new IconThemeData(color: Colors.white),
        title: Text(
          "Lessons",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
            onPressed: () async {},
          ),
        ],
      ),
      body: makeBody,
      bottomNavigationBar: makeBottom,
    );
  }
}

List getLessons() {
  return [
    Lesson(
        title: "Letters",
        level: "Easy",
        indicatorValue: 0.33,
        price: 20,
        ),
    Lesson(
        title: "Numbers",
        level: "Easy",
        indicatorValue: 0.33,
        price: 50,
        ),
    Lesson(
        title: "Colours",
        level: "Medium",
        indicatorValue: 0.66,
        ),
    Lesson(
        title: "Animals",
        level: "Medium",
        indicatorValue: 0.66,
        price: 30,
        ),
    Lesson(
        title: "Vehicles",
        level: "Medium",
        indicatorValue: 1.0,
        price: 50,
       ),
    Lesson(
        title: "Shapes",
        level: "Medium",
        indicatorValue: 1.0,
        price: 50,
      ),
    Lesson(
        title: "Relatives",
        level: "Hard",
        indicatorValue: 1.0,
        price: 50,
      ),
    Lesson(
        title: "Body Parts",
        level: "Hard",
        indicatorValue: 1.0,
        price: 50,
   )
  ];
}
