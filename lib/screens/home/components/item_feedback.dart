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
            SizedBox(width: 100, child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  homeworkItem.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),),

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
