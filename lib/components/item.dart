import 'package:flutter/material.dart';
import 'package:homework/models/homeworkItem.dart';

class Item extends StatelessWidget {

  final HomeworkItem homeworkItem;

  Item({this.homeworkItem});

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, "/editHomework",arguments: {
          'title':homeworkItem.title
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

