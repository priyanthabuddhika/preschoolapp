import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:preschool_app/models/game.dart';
import 'package:preschool_app/screens/activity/games/dice.dart';
import 'package:preschool_app/screens/activity/games/drag_drop.dart';
import 'package:preschool_app/screens/activity/games/play.dart';
import 'package:preschool_app/screens/drawer/bottombar.dart';
import 'package:preschool_app/screens/drawer/sidebar.dart';
import 'package:preschool_app/services/database_helper.dart';

class Games extends StatefulWidget {
  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  List games;
  final DatabaseHelper dbHelper = new DatabaseHelper();
  String name = '';
  @override
  void initState() {
    games = getGames();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(GameModel game) => ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
                border: new Border(
                    right: new BorderSide(width: 1.0, color: Colors.white24))),
            child: Icon(game.icon, color: Colors.white),
          ),
          title: Text(
            game.title,
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
                        value: game.indicatorValue,
                        valueColor: AlwaysStoppedAnimation(Colors.yellow)),
                  )),
              Expanded(
                flex: 4,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(game.level,
                        style: TextStyle(color: Colors.white))),
              )
            ],
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            switch (game.title) {
              case 'Dice':
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Dice()));
                break;
              case 'Drag Drop':
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DragDrop()));
                break;
              case 'Play':
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PlayList()));
                break;
            
              default:
            }
          },
        );

    Card makeCard(GameModel game) => Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 8.0,
          margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          child: Container(
            height: 120.0,
            decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(15),
            ),
            child: makeListTile(game),
          ),
        );

    final makeBody = Container(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: games.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(games[index]);
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
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: new IconThemeData(color: Colors.black),
          title: Text(
            "Games",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: makeBody,
        bottomNavigationBar: makeBottom,
        drawer: SideBar('Activity'),
          floatingActionButton: FloatingActionButton(
          onPressed: () {
            try {
              var count = 0;
              Future getCount() async {
                var temp = await dbHelper.getMark(name);
                count = temp ?? 0;
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
                                color: Color.fromRGBO(255, 235, 242, 1.0),
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
                                mainAxisSize: MainAxisSize
                                    .min, // To make the card compact
                                children: <Widget>[
                                  Text(
                                    "$count",
                                    style: TextStyle(
                                        fontSize: 50.0,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.red),
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    'Hello $name, You have $count Ice Creams!',
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
                                        'Ok',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 25.0),
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
            } catch (e) {}
          },
          backgroundColor: Colors.white, //Color.fromRGBO(58, 66, 86, 1.0),
          child: Icon(Icons.fastfood, color: Color.fromRGBO(255, 91, 123, 1)),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

List getGames() {
  return [

    GameModel(
      title: 'Dice',
      level: 'Level 1',
      icon: FontAwesomeIcons.dice,
      indicatorValue: 0.2,
    ),
    GameModel(
      title: 'Drag Drop',
      level: 'Level 1',
      icon: FontAwesomeIcons.gripHorizontal,
      indicatorValue: 0.2,
    ),
    GameModel(
      title: 'Play',
      level: 'Level 1',
      icon: FontAwesomeIcons.play,
      indicatorValue: 0.7,
    ),

  ];
}
