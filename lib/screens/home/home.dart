import 'package:flutter/material.dart';
import 'package:homework/components/menu.dart';
import 'package:homework/models/homeworkItem.dart';
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:homework/screens/home/components/item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<HomeworkItem> homeworks = [
    FileItem(title: "costam", imgUrl: "none"),
    FolderItem(title: "ok"),
    FileItem(title: "ok", imgUrl: "none"),
    FileItem(title: "ok", imgUrl: "none"),
    FolderItem(title: "ok"),
  ];

  createNewDoc(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Center(
              child: Text(
                "Create new homework:",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            content: TextField(
              controller: TextEditingController(),
            ),
            actions: [
              MaterialButton(
                onPressed: () {},
                elevation: 5,
                child: Text('Create'),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("homework"),
        centerTitle: true,
      ),
      drawer: Menu(),
      body: DragAndDropGridView(
        controller: ScrollController(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.7,
        ),
        padding: EdgeInsets.all(20),
        itemBuilder: (context, index) => Item(homeworkItem: homeworks[index],),
        itemCount: homeworks.length,
        onWillAccept: (oldIndex, newIndex) {
          return true;
        },
        onReorder: (oldIndex, newIndex) {
          HomeworkItem _temp;
          _temp = homeworks[newIndex];
          homeworks[newIndex] = homeworks[oldIndex];
          homeworks[oldIndex] = _temp;
          setState(() {});
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewDoc(context);
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
