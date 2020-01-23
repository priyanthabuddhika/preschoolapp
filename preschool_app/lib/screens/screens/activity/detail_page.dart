import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:preschool_app/services/texttospeech.dart';

class DetailPage extends StatefulWidget {
  final String lesson;
  DetailPage({Key key, this.lesson}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final PageController ctrl = PageController(viewportFraction: 0.8);
  final Firestore db = Firestore.instance;
  Stream slides;

  // Text to Speech Engine
  TextToSpeech tts = TextToSpeech();

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
  _queryDb({String tag }) {
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
          color: Colors.white, borderRadius: BorderRadius.circular(20),
        ),
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(data['char'], style: TextStyle(fontSize: 80.0),),
            ),
            Divider(thickness: 1.5,indent: 15.0, endIndent: 15.0,),
            Expanded(child: Image.network(data['img'])),
            
            Text(data['title'],style: TextStyle(fontSize: 40.0),),
            Divider(thickness: 1.5,indent: 15.0, endIndent: 15.0,),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 25.0),
              
              child: FlatButton(
                color: Colors.green,
                child: Text('Listen',style: TextStyle(fontSize: 25.0),),
                onPressed: () {
                  tts.speak(data['title']);
                },
              ),
            ),
            // TODO
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
