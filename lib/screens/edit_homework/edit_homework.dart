import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework/models/homework_item.dart';
import 'package:homework/models/image_loader.dart';
import 'package:homework/models/pdf_creator.dart';

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
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () {
                print("share");
              }),
          IconButton(
              icon: Icon(Icons.file_download),
              onPressed: () async {
                print("download");
                generatePDF();
                //TODO(n2one): create and download PDF
              })
        ],
      ),
      body: ListView(
        children: [
          for (final i in items)
            Dismissible(
              key: ValueKey(i),
              onDismissed: (direction) {
                setState(() {
                  items.remove(i);
                });
              },
              child: ListTile(
                  title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: generatePage(i))),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var imagePath = await ImageLoader().getImageGallery();
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

  generatePage(String pathImage) {
    var file = new File(pathImage);
    return Stack(children: [
      Image.file(file),
      Align(
        alignment: Alignment.topRight,
        child: Column(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_circle_up_rounded),
              onPressed: () {
                swapPages(pathImage, true);
              },
              iconSize: 50,
            ),
            IconButton(
              icon: Icon(Icons.arrow_circle_down_rounded),
              onPressed: () {
                swapPages(pathImage, false);
              },
              iconSize: 50,
            ),
          ],
        ),
      )
    ]);
    //     chi )
  }

  swapPages(var object, bool isUp) {
    setState(() {
      int oldIndex = items.indexOf(object);
      int newIndex = oldIndex + (isUp ? -1 : 1);
      if (newIndex < 0 || newIndex >= items.length) return;
      var temp = items[oldIndex];
      items.removeAt(oldIndex);
      items.insert(newIndex, temp);
    });
  }

  addNewImage(String path) {
    setState(() {
      items.add(path);
    });
  }

  void generatePDF() {
    var pdf = new PdfCreator();

    for(var src in items){
      pdf.createNewPageSrc(src);
    }
    pdf.save(homework.title);

  }
}
