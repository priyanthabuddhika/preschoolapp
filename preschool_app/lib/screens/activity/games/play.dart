import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlayList extends StatefulWidget {
  @override
  _PlayListState createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  void play({int numb}) {
    final player = AudioCache();
    player.play('note$numb.wav');
  }

  Expanded buildKey({int playNum, Color color, String word}) {
    return Expanded(
      child: FlatButton(
        onPressed: () {
          try {
            Fluttertoast.showToast(
                msg: word,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.TOP,
                timeInSecForIos: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 70.0);
          } catch (e) {
            print(e.toString());
          }

          setState(() {
            play(numb: playNum);
          });
        },
        child: null,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildKey(playNum: 1, color: Colors.green, word: getWord()),
          buildKey(playNum: 2, color: Colors.blue, word: getWord()),
          buildKey(playNum: 3, color: Colors.cyan, word: getWord()),
          buildKey(playNum: 4, color: Colors.orange, word: getWord()),
          buildKey(playNum: 5, color: Colors.pink, word: getWord()),
          buildKey(playNum: 6, color: Colors.teal, word: getWord()),
          buildKey(playNum: 7, color: Colors.red, word: getWord()),
        ],
      ),
    );
  }
}

String getWord() {
  List<String> wordList = [
    'Cat',
    'Van',
    'Dog',
    'Bicycle',
    'Lion',
    'Bus',
    'Rat',
    'Car',
    'Apple'
  ];
  int random = Random().nextInt(8);
  return wordList[random];
}
