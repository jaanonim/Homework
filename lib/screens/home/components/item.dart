import 'package:flutter/material.dart';
import 'package:Homework/models/homework_item.dart';
import 'package:Homework/screens/home/components/file.dart';
import 'package:Homework/screens/home/components/folder.dart';

class Item extends StatelessWidget {
  final HomeworkItem homeworkItem;

  Item({this.homeworkItem});

  @override
  Widget build(BuildContext context) {
    Widget content = (homeworkItem is FolderItem)
        ? Folder(homeworkItem: homeworkItem)
        : File(homeworkItem: homeworkItem);
    return Card(
      child: content,
    );
  }
}
