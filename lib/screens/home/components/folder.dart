import 'package:flutter/material.dart';
import 'package:homework/models/homeworkItem.dart';

class Folder extends StatelessWidget {
  final HomeworkItem homeworkItem;

  Folder({this.homeworkItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(homeworkItem.title),
            ),
            Icon(
              Icons.folder,
              size: 72,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  onPressed: () {},
                  child: Icon(
                    Icons.delete,
                    size: 15,
                  ),
                  height: 25,
                  minWidth: 40,
                ),
              ],
            )
          ])),
    );
  }
}
