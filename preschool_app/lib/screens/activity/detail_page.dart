import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:preschool_app/services/database_helper.dart';
import 'package:preschool_app/services/texttospeech.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DetailPage extends StatefulWidget {
  final String lesson;
  final String name;
  DetailPage({Key key, this.lesson, this.name}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState(lesson, name);
}

class _DetailPageState extends State<DetailPage> {
  final String name;
  final String lesson;
  final DatabaseHelper dbHelper = new DatabaseHelper();
  final PageController ctrl =
      PageController(viewportFraction: 0.8); // Pageview controller
  final Firestore db = Firestore.instance;
  Stream slides; // pages in pageview

  // Text to Speech Engine
  TextToSpeech tts = TextToSpeech();

  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;

  _DetailPageState(this.lesson, this.name);

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
    final double offset = active ? 20 : 0;
    final double top = active ? 100 : 200;

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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                data['char'],
                style: TextStyle(fontSize: 60.0),
              ),
            ),
            Divider(
              thickness: 1.5,
              indent: 15.0,
              endIndent: 15.0,
            ),
            Expanded(
              child: CachedNetworkImage(
                imageUrl: data['img'],
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Text(
              data['title'],
              style: TextStyle(fontSize: 40.0),
            ),
            Divider(
              thickness: 1.5,
              indent: 15.0,
              endIndent: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 25.0),
              child: FlatButton(
                color: Colors.green,
                child: Text(
                  'Listen',
                  style: TextStyle(fontSize: 25.0),
                ),
                onPressed: () {
                  tts.speak(data['title']);
                  var mark;
                  Future getScore() async {
                    mark = await dbHelper.getMark(name);
                  }

                  Future updateScore() async {
                    await dbHelper.updateMark(
                        name, 1, lesson, currentPage.toString(), 1);
                  }

                  updateScore().then((value) {
                    getScore().then((onValue) {
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
                                      mainAxisSize: MainAxisSize
                                          .min, // To make the card compact
                                      children: <Widget>[
                                        Text(
                                          '+1🍦',
                                          style: TextStyle(
                                              fontSize: 50.0,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.red),
                                        ),
                                        SizedBox(height: 16.0),
                                        Text(
                                          'Congratulations $name, You have $mark Ice Creams! ', 
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
                                            },
                                            child: Text(
                                              'Okay',
                                              style:
                                                  TextStyle(color: Colors.red),
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
                  });

                  Future.delayed(const Duration(seconds: 1), () {
                    setState(() {
                      ctrl.nextPage(
                        duration: Duration(seconds: 2),
                        curve: Curves.easeOutQuint,
                      );
                    });
                  });
                },
              ),
            ),
          ],
        ),
      ),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
            color: Colors.black87,
            blurRadius: blur,
            offset: Offset(offset, offset))
      ]),
    );
  }
}
