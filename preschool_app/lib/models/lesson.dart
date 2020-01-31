
import 'package:flutter/cupertino.dart';

class Lesson {
  
  String title;
  String level;
  double indicatorValue;
  String content;
  IconData icon;
  Color color;

  Lesson(
      {this.title, this.level, this.indicatorValue, this.content, this.icon,this.color});
}

// Lesson model for activity list