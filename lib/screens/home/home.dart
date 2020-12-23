import 'package:flutter/material.dart';
import 'package:homework/components/menu.dart';
import 'package:homework/models/homeworkItem.dart';
import 'package:drag_and_drop_gridview/devdrag.dart';
import 'package:homework/screens/home/components/item.dart';
import 'package:homework/screens/home/components/folder.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FolderItem folder = FolderItem(title: "home");

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
  void initState() {
    super.initState();
    folder.MoveToFolder([
      FolderItem(title: "lol"),
      FileItem(title: "costam", imgUrl: "none"),
      FileItem(title: "oek", imgUrl: "none"),
      FileItem(title: "ok", imgUrl: "none"),
      FolderItem(title: "ok"),
    ]);
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
        itemBuilder: (context, index) => Item(
            homeworkItem: folder.children[index],
            update: () {
              setState(() {});
            }),
        itemCount: folder.children.length,
        onWillAccept: (oldIndex, newIndex) {
          return folder.children[newIndex] is FolderItem;
        },
        onReorder: (oldIndex, newIndex) {
          (folder.children[newIndex] as FolderItem)
              .MoveToFolder([folder.children[oldIndex]]);
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
