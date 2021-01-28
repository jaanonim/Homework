import 'package:flutter/material.dart';
import 'package:Homework/models/homework_item.dart';

class ItemFeedback extends StatelessWidget {
  final HomeworkItem homeworkItem;

  ItemFeedback({this.homeworkItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(homeworkItem.title),
              ),
            ),
            FittedBox(
              fit: BoxFit.contain,
              child: Icon(
                (homeworkItem is FolderItem)
                    ? Icons.folder
                    : Icons.insert_drive_file,
                size: 72,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
