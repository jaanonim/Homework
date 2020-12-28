import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:homework/components/inputPopup.dart';
import 'package:homework/models/hierarchy.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/screens/home/components/item.dart';
import 'package:homework/screens/home/components/item_feedback.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  final controller = TextEditingController();

  Widget getItem(index, bool isDragged, hierarchy) {
    Widget item = Item(
      homeworkItem: hierarchy.now.children[index],
    );

    if (isDragged) {
      return Opacity(
        opacity: 0.5,
        child: item,
      );
    } else {
      return item;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Hierarchy hierarchy = Provider.of<Hierarchy>(context);

    return DragAndDropGridView(
      controller: ScrollController(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      padding: EdgeInsets.all(20),
      itemBuilder: (context, index) => getItem(index, false, hierarchy),
      itemCount: hierarchy.now.children.length,
      isCustomChildWhenDragging: true,
      childWhenDragging: (index) => getItem(index, true, hierarchy),
      isCustomFeedback: true,
      feedback: (index) =>
          ItemFeedback(homeworkItem: hierarchy.now.children[index]),
      onWillAccept: (oldIndex, newIndex) {
        if (oldIndex == newIndex) {
          return false;
        }
        return true;
      },
      onReorder: (oldIndex, newIndex) {
        if (hierarchy.now.children[newIndex] is FolderItem) {
          hierarchy.moveToFolder(hierarchy.now.children[newIndex],
              hierarchy.now.children[oldIndex]);
        } else {
          inputPopup(context, "Create new folder:", "Create", controller, () {
            hierarchy.createFolder(controller.text, [
              hierarchy.now.children[newIndex],
              hierarchy.now.children[oldIndex],
            ]);
            Navigator.pop(context);
          });
        }
      },
    );
  }
}
