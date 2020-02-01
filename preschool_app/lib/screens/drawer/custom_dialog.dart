import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Image image;
  final BuildContext context1;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    @required this.context1,
    this.image,
    
  });

  @override
  Widget build(context1) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
      ),      
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context1),
    );
  }
  dialogContent(BuildContext context) {
  return Stack(
    children: <Widget>[
     Container(
  padding: EdgeInsets.only(
    top: 25.0,
    bottom: 10,
    left: 10.0,
    right:10.0,
  ),
  margin: EdgeInsets.only(top: 15.0),
  decoration: new BoxDecoration(
    color: Colors.white,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(15.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 10.0,
        offset: const Offset(0.0, 10.0),
      ),
    ],
  ),
  child: Column(
    mainAxisSize: MainAxisSize.min, // To make the card compact
    children: <Widget>[
      Text(
        title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w700,
        ),
      ),
      SizedBox(height: 16.0),
      Text(
        description,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16.0,
        ),
      ),
      SizedBox(height: 24.0),
      Align(
        alignment: Alignment.bottomRight,
        child: FlatButton(
          onPressed: () {
            Navigator.of(context).pop(); // To close the dialog
          },
          child: Text(buttonText),
        ),
      ),
    ],
  ),
),
      //...top circlular image part,
    ],
  );
}
}