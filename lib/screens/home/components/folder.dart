import 'package:flutter/material.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/components/inputPopup.dart';

class Folder extends StatelessWidget {
  final HomeworkItem homeworkItem;
  final Function del;
  final Function update;
  final Function(FolderItem) addToHierarchy;

  final controller = TextEditingController();

  Folder({this.homeworkItem, this.del, this.update, this.addToHierarchy});

  @override
  Widget build(BuildContext context) {
    controller.text = this.homeworkItem.title;

    return InkWell(
      onTap: () {
        addToHierarchy(homeworkItem);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(homeworkItem.title),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(
                    Icons.folder,
                    size: 60,
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            del(context,
                                "Are you sure you want to delete this folder and everything in it?",
                                () {
                              homeworkItem.deleteItem();
                              update();
                            });
                          },
                          child: Icon(
                            Icons.delete,
                            size: 15,
                          ),
                          height: 25,
                          minWidth: 40,
                        ),
                      ),
                      Expanded(
                        child: MaterialButton(
                          onPressed: () {
                            inputPopup(
                                context, "Rename folder", "Rename", controller,
                                () {
                              this.homeworkItem.title = controller.text;
                              update();
                              Navigator.pop(context);
                            });
                          },
                          child: Icon(
                            Icons.edit,
                            size: 15,
                          ),
                          height: 25,
                          minWidth: 40,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
