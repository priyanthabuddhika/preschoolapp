import 'package:flutter/material.dart';
import 'dart:math';

class ScratchGame extends StatefulWidget {
  @override
  _ScratchGameState createState() => _ScratchGameState();
}

class _ScratchGameState extends State<ScratchGame> {
  //TODO:Assign Images
  AssetImage circle = AssetImage('images/circle.png');
  AssetImage lucky = AssetImage('images/rupee.png');
  AssetImage unlucky = AssetImage('images/sadFace.png');

  //TODO:define array
  List<String> boxState;

  //TODO:random no variable
  int luckyNumber;

  String message;

  //TODO:Initall State
  @override
  void initState(){
    super.initState();
    setState(() {
      boxState = List<String>.generate(9, (index) => 'empty');
      this.message = "";
    });
    genrateRandom();
  }

  //TODO:genrate Random No
  genrateRandom(){
    int random = Random().nextInt(10);
    setState(() {
      luckyNumber = random;
    });
  }
  //TODO:get image
  AssetImage getImage(int index){
    var imageState = boxState[index];
    switch(imageState){
      case "lucky":
      return lucky;
      break;
      case "unlucky":
      return unlucky;
      break;
    }  
    return circle;
  }

  //TODO:programing logic
  programLogic(int index){
    if(luckyNumber == index){
      setState(() {
        boxState[index]= "lucky";
      });
    }
    else{
      setState(() {
        boxState[index]= "unlucky";
      });
    }
  }
  int i=0;
  controller(int index){
    i++;
    if(i<=5){
      programLogic(index);
      if(i==5){
        setState(() {
          this.message = "Game Over!";
        });
      }
    }
  }

  //TODO:reset 
  reset(){
    setState(() {
      boxState = List<String>.filled(9, "empty");
      this.message = "";
    });
    i=0;
    genrateRandom();
  }
  //TODO:showall
  showall(){
    setState(() {
      boxState = List<String>.filled(9, "unlucky");
      boxState[luckyNumber] = "lucky";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scratch And Win'),   
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(20.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
              ),
              itemCount: this.boxState.length,
              itemBuilder: (context,i) => SizedBox(
                width: 40.0,
                height: 40.0,
                child: RaisedButton(
                  onPressed: () =>{
                    this.controller(i),
                  },
                  child: Image(
                    image: this.getImage(i),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
            child: Text(this.message,style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.w800,color: Colors.red),),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(60.0, 10.0, 60.0, 10.0),
              onPressed: showall,
              child: Text('Show All',
                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.white),
              ),
              color: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 3.0),
            child: RaisedButton(
              padding: EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 10.0),
              onPressed: reset,
              child: Text('Reset',
                style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold,color: Colors.white),
              ),
              color: Colors.indigo,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
            ),
          ),
        
        ],
      ),
    );
  }
}