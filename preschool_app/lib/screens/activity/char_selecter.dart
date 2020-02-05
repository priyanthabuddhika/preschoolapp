import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CharSelectPage extends StatefulWidget {
  final String lesson;
  CharSelectPage({Key key, this.lesson}) : super(key: key);

  @override
  _CharSelectPageState createState() => _CharSelectPageState();
}

class _CharSelectPageState extends State<CharSelectPage> {
  final PageController ctrl =
      PageController(viewportFraction: 0.8); // Pageview controller
  final Firestore db = Firestore.instance;
  Stream slides; // pages in pageview

  // Keep track of current page to avoid unnecessary renders
  int currentPage = 0;

  @override
  void initState() {
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
              padding: const EdgeInsets.all(15.0),
              child: Text(
                'Select the correct letter ',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
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
              blankTxt(data['title']),
              style: TextStyle(fontSize: 40.0),
            ),
            Divider(
              thickness: 1.5,
              indent: 15.0,
              endIndent: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
              child: FlatButton(
                color: Colors.blue[200],
                child: Text(
                  getChar(data['title']),
                  style: TextStyle(
                    fontSize: 25.0,
                  ),
                ),
                onPressed: () {
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
                                      '-1🍦',
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
                                            ctrl.nextPage(duration: Duration(milliseconds: 900), curve: Curves.easeOutQuint,);
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
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
              child: FlatButton(
                color: Colors.blue[200],
                child: Text(
                  splitchar(data['title']),
                  style: TextStyle(fontSize: 25.0),
                ),
                onPressed: () {
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
                                          Navigator.of(context)
                                              .pop(); 
                                               setState(() {
                                            ctrl.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOutQuint,);
                                          });// To close the dialog
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
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 8.0),
              child: FlatButton(
                color: Colors.blue[200],
                child: Text(
                  getChartwo(data['title']),
                  style: TextStyle(fontSize: 25.0),
                ),
                onPressed: () {
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
                                      '-1🍦',
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
                                          Navigator.of(context)
                                              .pop(); 
                                               setState(() {
                                            ctrl.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeOutQuint,);
                                          });// To close the dialog
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

  String splitchar(String text) {
    String char = text[0];
    return char;
  }

  String getChar(String text) {
    String char = text[1];
    return char.toUpperCase();
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

  String blankTxt(String text) {
    return '_' + text.substring(1);
  }
}
