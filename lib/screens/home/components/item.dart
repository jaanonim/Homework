import 'package:flutter/material.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/screens/home/components/file.dart';
import 'package:homework/screens/home/components/folder.dart';
import 'package:homework/components/yesNoPopup.dart';

class Item extends StatelessWidget {
  final HomeworkItem homeworkItem;
  final Function update;
  final Function(FolderItem) addToHierarchy;

  Item({this.homeworkItem, this.update, this.addToHierarchy});

  @override
  Widget build(BuildContext context) {
    if (homeworkItem is FolderItem) {
      return Folder(homeworkItem: homeworkItem,del: yesNoPopup, update: update, addToHierarchy: addToHierarchy);
    } else {
      return File(homeworkItem: homeworkItem,del: yesNoPopup, update: update);
    }
  }
}
