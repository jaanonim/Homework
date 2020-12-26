import 'package:flutter/material.dart';
import 'package:homework/components/menu.dart';
import 'package:homework/models/homework_item.dart';
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:homework/screens/home/components/item.dart';
import 'package:homework/components/inputPopup.dart';
import 'package:homework/screens/home/components/hierarchy_element.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FolderItem> hierarchy = [FolderItem(title: "home")];
  final controller = TextEditingController();

  void newFolder(oldIndex, newIndex) {
    FolderItem newFolder = FolderItem(title: controller.text);
    hierarchy.last.MoveToFolder([
      newFolder,
    ]);
    newFolder.MoveToFolder([
      hierarchy.last.children[oldIndex],
      hierarchy.last.children[newIndex],
    ]);
    setState(() {});
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // TODO: remove this debug
    hierarchy.last.MoveToFolder([
      FolderItem(title: "lol"),
      FileItem(title: "costam"),
      FileItem(title: "oek"),
      FileItem(title: "ok"),
      FolderItem(title: "ok"),
    ]);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homework"),
        centerTitle: true,
        bottom: PreferredSize(
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: hierarchy
                      .map((element) => HierarchyElement(
                            folder: element,
                            isLast: element == hierarchy.last,
                            removeFromHierarchy: (folder) {
                              setState(() {
                                for (int i = hierarchy.length - 1; i > 0; i--) {
                                  if (hierarchy[i] == folder) {
                                    break;
                                  }
                                  hierarchy.removeAt(i);
                                }
                              });
                            },
                          ))
                      .toList())),
          preferredSize: Size.fromHeight(40),
        ),
      ),
      drawer: Menu(),
      body: DragAndDropGridView(
        controller: ScrollController(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
        ),
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) => Item(
            homeworkItem: hierarchy.last.children[index],
            update: () {
              setState(() {});
            },
            addToHierarchy: (FolderItem item) {
              setState(() {
                hierarchy.add(item);
              });
            }),
        itemCount: hierarchy.last.children.length,
        onWillAccept: (oldIndex, newIndex) {
          if (oldIndex == newIndex) {
            return false;
          }
          return true;
        },
        onReorder: (oldIndex, newIndex) {
          if (hierarchy.last.children[newIndex] is FolderItem) {
            (hierarchy.last.children[newIndex] as FolderItem)
                .MoveToFolder([hierarchy.last.children[oldIndex]]);
            setState(() {});
          } else {
            inputPopup(context, "Create new folder:", "Create", controller, () {
              newFolder(oldIndex, newIndex);
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          inputPopup(context, "Create new homework:", "Create", controller, () {
            HomeworkItem homeworkItem = FileItem(title: controller.text);
            hierarchy.last.MoveToFolder([homeworkItem]);
            Navigator.pop(context);
            Navigator.pushNamed(context, "/editHomework",
                arguments: {"homeworkItem": homeworkItem});
            setState(() { });
          });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }
}
