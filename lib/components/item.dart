import 'package:flutter/material.dart';
import 'package:homework/models/homeworkItem.dart';

class Item extends StatelessWidget {

  final HomeworkItem homeworkItem;

  Item({this.homeworkItem});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      child: Card(
        child: Center(child: Text(homeworkItem.title)),
      ),
      feedback: Card(
        child: Center(child: Text(homeworkItem.title)),
      ),
    );
  }
}

