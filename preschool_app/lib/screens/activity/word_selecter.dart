import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:preschool_app/services/database_helper.dart';

class WordSelectPage extends StatefulWidget {
  final String name;
  final String lesson;
  WordSelectPage({Key key, this.lesson, this.name}) : super(key: key);

  @override
  _WordSelectPageState createState() => _WordSelectPageState(lesson, name);
}

class _WordSelectPageState extends State<WordSelectPage> {
  final String name;
  final String lesson;
  final DatabaseHelper dbHelper = new DatabaseHelper();
  final PageController ctrl =
      PageController(viewportFraction: 0.8); // Pageview controller
  final Firestore db = Firestore.instance;
  Stream slides; // pages in pageview

  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;

  _WordSelectPageState(this.lesson, this.name);

  @override
  void initState() {
    dbHelper.initializeDatabase();
    String lesson = widget.lesson;
    _queryDb(tag: lesson);
    // Set state when page changes
    ctrl.addListener(() {
      int next = ctrl.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: slides,
      initialData: [],
      builder: (context, AsyncSnapshot snap) {
        List slideList = snap.data.toList();

        return Scaffold(
          backgroundColor: Color.fromRGBO(255, 228, 221, 1.0),
          body: PageView.builder(
            controller: ctrl,
            itemCount: slideList.length,
            itemBuilder: (context, int currentIdx) {
              if (currentIdx == 0) {
                //return _buildTagPage();
                bool active = currentIdx == currentPage;
                return _buildStoryPage(slideList[currentIdx], active);
              } else if (slideList.length >= currentIdx) {
                // Active page
                bool active = currentIdx == currentPage;
                return _buildStoryPage(slideList[currentIdx], active);
              }
              return null;
            },
          ),
        );
      },
    );
  }

  // Query Firestore
  _queryDb({String tag}) {
    // Make a Query
    Query query = db.collection('/Lessons/$tag/res');

    // Map the documents to the data payload
    slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
  }

  // Builder Functions

  Widget _buildStoryPage(Map data, bool active) {
    // Animated Properties
    final double blur = active ? 30 : 0;
    final double offset = active ? 10 : 0;
    final double top = active ? 50 : 150;

    List<Widget> widgetList = [
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
        child: FlatButton(
          color: Colors.green,
          child: Text(

            randomWord(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
            ),
          ),
          onPressed: () {
            var count;
            Future getCount() async {
              count = await dbHelper.updateMark(
                  name, 3, lesson, currentPage.toString(), 0);
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
                                  //'-1🍦',
                                  "$count",
                                  style: TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'You have lost one Ice Cream, Answer correctly to gain ice creams',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  data['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(height: 24.0),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        ctrl.nextPage(
                                          duration: Duration(milliseconds: 900),
                                          curve: Curves.easeOutQuint,
                                        );
                                      });
                                      // To close the dialog
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
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
        child: FlatButton(
          color: Colors.green,
          child: Text(
            data['title'],
            style: TextStyle(fontSize: 25.0,
            color: Colors.white),
          ),
          onPressed: () {
            var count;
            Future getCount() async {
              count = await dbHelper.updateMark(
                  name, 3, lesson, currentPage.toString(), 1);
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
                                  //'+1🍦',
                                  "$count",
                                  style: TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'You have won one Ice Cream, Answer correctly to gain more ice creams',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  data['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(height: 24.0),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        ctrl.nextPage(
                                          duration: Duration(milliseconds: 500),
                                          curve: Curves.easeOutQuint,
                                        );
                                      }); // To close the dialog
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
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
        child: FlatButton(
          color: Colors.green,
          child: Text(
            randomWord(),
            style: TextStyle(fontSize: 25.0,
            color: Colors.white),
          ),
          onPressed: () {
            var count;
            Future getCount() async {
              count = await dbHelper.updateMark(
                  name, 3, lesson, currentPage.toString(), 0);
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
                                  //'-1🍦',
                                  "$count",
                                  style: TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.red),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  'You have lost one Ice Cream, Answer correctly to gain ice creams',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  data['title'],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 35.0,
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                SizedBox(height: 24.0),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        ctrl.nextPage(
                                          duration: Duration(milliseconds: 900),
                                          curve: Curves.easeOutQuint,
                                        );
                                      });
                                      // To close the dialog
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
        ),
      ),
    ];
    widgetList.shuffle();

    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutQuint,
      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                color: Color.fromRGBO(235, 135, 110, 1.0),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'Select correct word',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold,color: Colors.white),
                  ),
                ),
              ),
            ),
           
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: CachedNetworkImage(
                  imageUrl: data['img'],
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Divider(
              thickness: 1.5,
              indent: 15.0,
              endIndent: 15.0,
            ),
            widgetList[0],
            widgetList[1],
            widgetList[2],
          ],
        ),
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
            color: Colors.black12,
            blurRadius: blur,
            offset: Offset(offset, offset))
      ]),
    );
  }

  String randomWord() {
    List words = [
      'Apple',
      'Ball',
      'Cat',
      'Dog',
      'Elephant',
      'Fish',
      'Grapes',
      'Home',
      'Ice Cream',
      'Jug',
      'Kite',
      'Lion',
      'Mango',
      'Nest',
      'Orange',
      'Parrot',
      'Queen',
      'Rat',
      'Sun',
      'Tiger',
      'Umbrella',
      'Van',
      'Watch',
      'Xylophone',
      'Yak',
      'Zebra',
      'Zero',
      'One',
      'Two',
      'Three',
      'Four',
      'Five',
      'Six',
      'Seven',
      'Eight',
      'Nine',
      'Ten',
      'Black',
      'White',
      'Yellow',
      'Blue',
      'Brown',
      'Gray',
      'Green',
      'Orange',
      'Pink',
      'Purple',
      'Red',
      'Lion',
      'Parrot',
      'Rat',
      'Tiger',
      'Yak',
      'Zebra',
      'Cat',
      'Dog',
      'Fish',
      'Tuk-Tuk',
      'Bus',
      'Car',
      'Airplane',
      'Bicycle',
      'Motor Bike',
      'Helicopter',
      'Jeep',
      'Train',
      'Circle',
      'Triangel',
      'Eclipse',
      'Square',
      'Brother',
      'Father',
      'Uncle',
      'Grand Father',
      'Sister',
      'Aunty',
      'Mother',
      'Grand Mother'
          'Neck',
      'Ear',
      'Hand',
      'Nose',
      'Eye',
      'Leg',
      'Mouth',
      'Pen',
      'Pencil',
      'Wire',
      'Desk',
      'Chair',
      'Watch'
    ];
    Random random = new Random();
    print(words.length);
    int count = random.nextInt(90);
    return words[count];
  }

  String getChartwo(String text) {
    String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    int rand = Random().nextInt(25);
    if (alphabet[rand] != text[0]) {
      return alphabet[rand];
    } else {
      return alphabet[++rand];
    }
  }
}
