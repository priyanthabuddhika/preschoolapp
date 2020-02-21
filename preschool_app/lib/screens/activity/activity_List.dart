import 'dart:io';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/models/child.dart';
import 'package:preschool_app/models/lesson.dart';
import 'package:preschool_app/screens/activity/level1.dart';
import 'package:preschool_app/screens/activity/level2.dart';
import 'package:preschool_app/screens/activity/level3.dart';
import 'package:preschool_app/screens/activity/selectchild.dart';
import 'package:preschool_app/screens/drawer/sidebar.dart';
import 'package:preschool_app/screens/drawer/bottombar.dart';
import 'package:preschool_app/services/database.dart';
import 'package:preschool_app/services/database_helper.dart';
import 'package:provider/provider.dart';

// Lesson list class UI
class ActivityList extends StatefulWidget {
  final String uid;

  ActivityList({
    Key key,
    @required this.uid,
  }) : super(key: key);

  @override
  _ActivityListState createState() => _ActivityListState(uid);
}

class _ActivityListState extends State<ActivityList> {
  final DatabaseHelper dbHelper = new DatabaseHelper();
  final uID;
  List lessons; // Lesson List
  String name = '';

  _ActivityListState(this.uID);
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
    final children = Provider.of<List<Child>>(
        context); // get Child object list from streamprovider
    List<String> childList = []; // Child list from child objects

    ListTile makeListTile(Lesson lesson) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
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
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40.0),
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
          switch (lesson.title) {
            case 'Level 1':
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LevelOneActivity(
                            uid: uID,
                          )));
              break;
            case 'Level 2':
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LevelTwoActivity(
                            uid: uID,
                          )));
              break;
            case 'Level 3':
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => LevelThreeActivity(
                            uid: uID,
                          )));
              break;
            default:
          }
        });

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

    try {
      if (children.isNotEmpty) {
        int count = 0;
        children.forEach((child) {
          childList.insert(count++, child.name);
        });
      }
    } catch (e) {
      print(e.toString());
    }

    void _showChildSelectMenu() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
            child: SelectChild(childList),
          );
        },
      );
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
            FlatButton.icon(
              icon: Icon(
                FontAwesomeIcons.userCircle,
                color: Colors.white,
              ),
              label: Text(''),
              onPressed: () {
                _showChildSelectMenu();
                setState(() {});
                DatabaseService().getStringValuesSF().then((onValue) {
                  print('jdjklj' + onValue);
                  updateName(onValue);
                });
              },
            )
          ],
        ),
        body: makeBody,
        bottomNavigationBar: makeBottom,
        drawer: SideBar('Activity'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var count;
            Future getCount() async {
              count = await dbHelper.getMark(name);
            }

            getCount().then((value) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(
                              top: 82.0,
                              bottom: 16.0,
                              left: 16.0,
                              right: 16.0,
                            ),
                            margin: EdgeInsets.only(top: 66.0),
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(16.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 10.0,
                                  offset: const Offset(0.0, 10.0),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize:
                                  MainAxisSize.min, // To make the card compact
                              children: <Widget>[
                                Text(
                                  '$count🍦',
                                  style: TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'Congratulations $name, You have $count Ice Creams! ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                SizedBox(height: 24.0),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      'Okay',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Positioned(
                            left: 16.0,
                            right: 16.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.blueAccent,
                              radius: 66.0,
                              backgroundImage:
                                  AssetImage('images/ice_cream.jpg'),
                            ),
                          ),
                          //...top circlular image part,
                        ],
                      ),
                    );
                  });
            });
          },
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          child: Icon(Icons.fastfood),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
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
      title: "Level 1",
      level: "Easy",
      indicatorValue: 0.33,
      icon: FontAwesomeIcons.adn,
    ),
    Lesson(
      title: 'Level 2',
      level: 'Medium',
      indicatorValue: 0.5,
      icon: FontAwesomeIcons.question,
      color: Colors.teal,
    ),
    Lesson(
      title: 'Level 3',
      level: 'Medium',
      indicatorValue: 0.5,
      icon: FontAwesomeIcons.question,
    )
  ];
}
