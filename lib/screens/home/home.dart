import 'package:flutter/material.dart';
import 'package:homework/components/inputPopup.dart';
import 'package:homework/components/menu.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/screens/home/components/body.dart';
import 'package:homework/screens/home/components/hierarchy_element.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<FolderItem> hierarchy = [FolderItem(title: "home")];
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // TODO: remove this debug
    hierarchy.last.moveToFolder([
      FolderItem(title: "lol"),
      FileItem(title: "costam"),
      FileItem(title: "oek"),
      FileItem(title: "ok"),
      FolderItem(title: "ok"),
    ]);
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
      body: Body(hierarchy: hierarchy,update: (){setState(() { });},),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          inputPopup(context, "Create new homework:", "Create", controller, () {
            HomeworkItem homeworkItem = FileItem(title: controller.text);
            hierarchy.last.moveToFolder([homeworkItem]);
            Navigator.pop(context);
            Navigator.pushNamed(context, "/editHomework",
                arguments: {"homeworkItem": homeworkItem});
            setState(() {});
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
