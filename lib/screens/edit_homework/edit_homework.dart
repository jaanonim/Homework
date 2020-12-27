import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework/components/yesNoPopup.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/models/image_loader.dart';

class EditHomework extends StatefulWidget {
  @override
  _EditHomeworkState createState() => _EditHomeworkState();
}

class _EditHomeworkState extends State<EditHomework> {
  Map data = {};
  var items = [];
  FileItem homework;

  @override
  Widget build(BuildContext context) {
    data = ModalRoute.of(context).settings.arguments;
    homework = data["homeworkItem"];
    items = homework.pathImages;
    return Scaffold(
      appBar: AppBar(
        title: Text(homework.title),
        centerTitle: true,
      ),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex < 0 || newIndex > items.length) return;
            var temp = items[oldIndex];
            items.removeAt(oldIndex);
            items.insert(newIndex, temp);
          });
        },
        children: [
          for (final i in items)
            ListTile(key: ValueKey(i), title: generatePage(i))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var imagePath = await ImageLoader().getImageGallery();
          //TODO(n2one): Check if user don't select any photos
          addNewImage(imagePath);
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  generatePage(var pathImage) {
    var file = new File(pathImage);
    // return Stack(children: [
    //   Image.file(file),
    //   Align(
    //     alignment: Alignment.topRight,
    //     child: IconButton(
    //       icon: Icon(Icons.delete),
    //       onPressed: () {
    //         yesNoPopup(context, "Are you sure you want to delete this image?",
    //             () {
    //           setState(() {
    //             items.remove(pathImage);
    //           });
    //         });
    //       },
    //       iconSize: 50,
    //     ),
    //   )
    // ]);
    return Image.file(file);
  }

  addNewImage(String path) {
    setState(() {
      items.add(path);
    });
  }
}
