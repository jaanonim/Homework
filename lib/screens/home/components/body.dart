import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:flutter/material.dart';
import 'package:homework/components/inputPopup.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/screens/home/components/item.dart';
import 'package:homework/screens/home/components/item_feedback.dart';

class Body extends StatelessWidget {
  final List<FolderItem> hierarchy;
  final Function update;
  final controller = TextEditingController();

  Body({this.hierarchy, this.update});

  void newFolder(oldIndex, newIndex, context) {
    FolderItem newFolder = FolderItem(title: controller.text);
    hierarchy.last.moveToFolder([
      newFolder,
    ]);
    newFolder.moveToFolder([
      hierarchy.last.children[oldIndex],
      hierarchy.last.children[newIndex],
    ]);
    update();
    Navigator.pop(context);
  }

  Widget getItem(index, bool isDragged) {
    Widget item = Item(
        homeworkItem: hierarchy.last.children[index],
        update: () {
          update();
        },
        addToHierarchy: (FolderItem item) {
          hierarchy.add(item);
          update();
        },
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
    return DragAndDropGridView(
      controller: ScrollController(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.7,
      ),
      padding: EdgeInsets.all(20),
      itemBuilder: (context, index) => getItem(index, false),
      itemCount: hierarchy.last.children.length,
      isCustomChildWhenDragging: true,
      childWhenDragging: (index) => getItem(index, true),
      isCustomFeedback: true,
      feedback: (index) =>
          ItemFeedback(homeworkItem: hierarchy.last.children[index]),
      onWillAccept: (oldIndex, newIndex) {
        if (oldIndex == newIndex) {
          return false;
        }
        return true;
      },
      onReorder: (oldIndex, newIndex) {
        if (hierarchy.last.children[newIndex] is FolderItem) {
          (hierarchy.last.children[newIndex] as FolderItem)
              .moveToFolder([hierarchy.last.children[oldIndex]]);
          update();
        } else {
          inputPopup(context, "Create new folder:", "Create", controller, () {
            newFolder(oldIndex, newIndex, context);
          });
        }
      },
    );
  }
}
