import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/models/lesson.dart';
import 'package:preschool_app/services/database_helper.dart';

// Selected child profile //
class Progress extends StatefulWidget {
  final String name;

  const Progress({Key key, this.name}) : super(key: key);
  @override
  _ProgressState createState() => _ProgressState(name);
}

class _ProgressState extends State<Progress> {
  DatabaseHelper dbHelper = new DatabaseHelper();
  List lessons;
  final String name;
  List markList;
  var list = new Map();

  _ProgressState(this.name);
  @override
  void initState() {
    lessons = getLessons();
    Future getMark() async {
      markList = await dbHelper.getFullMark(name);
    }

    getMark().then((value) {
      print(markList);
      int count = 0; 
      for (Lesson l in lessons){
      
        print(l.title);
        for (var i in markList) {
          if(i['l'] == l.title){
            double value= double.parse((i['m']/l.noQuestions).toStringAsFixed(1));
            l.indicatorValue = value;
            lessons[count] = l; 
            print("hhj"+(l.indicatorValue).toString());
          }
      }
      count++;
      }
      print(lessons[0].indicatorValue.toString());
      print(list);
      setState(() {
        
      });
    });



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
          trailing: Text(
            (lesson.indicatorValue*100).toString(),
            style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
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
      indicatorValue: 0,
      icon: FontAwesomeIcons.adn,
      color: Color.fromRGBO(255, 91, 123, 1),
      noQuestions: 78,
    ),
    Lesson(
      title: "Numbers",
      indicatorValue: 0,
      icon: FontAwesomeIcons.sortNumericUp,
      color: Color.fromRGBO(114, 238, 255, 1),
      noQuestions: 30,
    ),
    Lesson(
      title: "Colours",
      indicatorValue: 0,
      icon: FontAwesomeIcons.pallet,
      color: Color.fromRGBO(158, 227, 115, 1),
      noQuestions: 33,
    ),
    Lesson(
      title: "Animals",
      indicatorValue: 0,
      icon: FontAwesomeIcons.cat,
      color: Color.fromRGBO(37, 238, 214, 1),
      noQuestions: 30,
    ),
    Lesson(
      title: "Vehicles",
      indicatorValue: 0,
      icon: FontAwesomeIcons.truck,
      color: Color.fromRGBO(189, 255, 189, 1),
      noQuestions: 30,
    ),
    Lesson(
      title: "Shapes",
      indicatorValue: 0,
      icon: FontAwesomeIcons.shapes,
      color: Color.fromRGBO(74, 202, 187, 1),
      noQuestions: 12,
    ),
    Lesson(
      title: "Relatives",
      indicatorValue: 0,
      icon: FontAwesomeIcons.restroom,
      color: Color.fromRGBO(255, 196, 180, 1),
      noQuestions: 24,
    ),
    Lesson(
      title: "Body Parts",
      indicatorValue: 0,
      icon: FontAwesomeIcons.male,
      color: Color.fromRGBO(255, 171, 226, 1),
      noQuestions: 21,
    )
  ];
}
