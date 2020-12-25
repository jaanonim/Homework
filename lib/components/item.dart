import 'package:flutter/material.dart';
import 'package:homework/models/homework_item.dart';

class Item extends StatelessWidget {

  final HomeworkItem homeworkItem;

  Item({this.homeworkItem});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/editHomework",arguments: {
          'homeworkItem':homeworkItem
        });
      },
      child: Draggable(
        child: Card(
          child: Center(child: Text(homeworkItem.title)),
        ),
        feedback: Card(
          child: Center(child: Text(homeworkItem.title)),
        ),


      ),
    );
  }
}

