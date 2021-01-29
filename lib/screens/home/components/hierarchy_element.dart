import 'package:flutter/material.dart';
import 'package:Homework/models/hierarchy.dart';
import 'package:Homework/models/homework_item.dart';
import 'package:provider/provider.dart';

class HierarchyElement extends StatelessWidget {
  final FolderItem folder;
  final bool isLast;

  HierarchyElement({this.folder, this.isLast});

  @override
  Widget build(BuildContext context) {
    Hierarchy hierarchy = Provider.of<Hierarchy>(context);

    if (isLast) {
      return Row(
        children: [
          MaterialButton(
            onPressed: () {},
            child: Text(folder.title, style: TextStyle(color: Colors.white),),
            height: 0,
            minWidth: 10,
            padding: EdgeInsets.all(5),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          MaterialButton(
            onPressed: () {
              hierarchy.removeFromHierarchy(folder);
            },
            child: Text(folder.title, style: TextStyle(color: Colors.white),),
            height: 0,
            minWidth: 10,
            padding: EdgeInsets.all(5),
          ),
          Text('>')
        ],
        mainAxisSize: MainAxisSize.min,
      );
    }
  }
}
