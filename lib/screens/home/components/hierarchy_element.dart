import 'package:flutter/material.dart';
import 'package:homework/models/homework_item.dart';

class HierarchyElement extends StatelessWidget {
  final FolderItem folder;
  final bool isLast;
  final Function(FolderItem) removeFromHierarchy;

  HierarchyElement({this.folder, this.isLast, this.removeFromHierarchy});

  @override
  Widget build(BuildContext context) {
    if (isLast) {
      return Row(
        children: [
          MaterialButton(
            onPressed: () {},
            child: Text(folder.title),
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
              removeFromHierarchy(folder);
            },
            child: Text(folder.title),
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
