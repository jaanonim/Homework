import 'package:flutter/material.dart';
import 'package:homework/models/homeworkItem.dart';
import 'package:homework/screens/home/components/file.dart';
import 'package:homework/screens/home/components/folder.dart';
import 'package:homework/components/yesNoPopup.dart';

class Item extends StatelessWidget {
  final HomeworkItem homeworkItem;

  Item({this.homeworkItem});

  @override
  Widget build(BuildContext context) {
    if (homeworkItem is FolderItem) {
      return Folder(homeworkItem: homeworkItem,del: yesNoPopup);
    } else {
      return File(homeworkItem: homeworkItem,del: yesNoPopup);
    }
  }
}
