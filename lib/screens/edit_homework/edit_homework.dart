import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework/models/image_loader.dart';
import 'package:homework/screens/edit_homework/components/add_document_element_menu.dart';
import 'package:homework/screens/edit_homework/components/document_editor.dart';

class EditHomework extends StatefulWidget {
  @override
  _EditHomeworkState createState() => _EditHomeworkState();
}

class _EditHomeworkState extends State<EditHomework> {
  Map _data = {};
  DocumentEditor _editor;

  @override
  Widget build(BuildContext context) {
    _data = ModalRoute.of(context).settings.arguments;
    var title = _data["homeworkItem"].title;
    _editor = DocumentEditor(_data["homeworkItem"]);

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          centerTitle: true,
          actions: [
            IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  _editor.sharePDF();
                }),
            IconButton(
                icon: Icon(Icons.file_download),
                onPressed: () {
                  _editor.generatePDF();
                })
          ],
        ),
        body: ListView(
          children: [
            for (final i in _editor.getPages())
              Dismissible(
                key: ValueKey(i),
                onDismissed: (direction) {
                  setState(() {
                    _editor.removePage(i);
                  });
                },
                child: ListTile(
                    title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: generatePage(i))),
              )
          ],
        ),
        floatingActionButton: AddDocumentElementMenu(
            addCameraPhoto: addCameraPhoto, addGalleryPhoto: addGalleryPhoto));
  }

  Future<void> addCameraPhoto() async {
    String src = await ImageLoader().getImageCamera();
    if(src != null){
      setState(() {
        _editor.addNewImage(src);
      });
    }
  }

  Future<void> addGalleryPhoto() async {
    String src = await ImageLoader().getImageGallery();
    if(src != null){
      setState(() {
        _editor.addNewImage(src);
      });
    }
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
                setState(() {
                  _editor.swapPages(pathImage, true);
                });
              },
              iconSize: 50,
            ),
            IconButton(
              icon: Icon(Icons.arrow_circle_down_rounded),
              onPressed: () {
                setState(() {
                  _editor.swapPages(pathImage, false);
                });
              },
              iconSize: 50,
            ),
          ],
        ),
      )
    ]);
    //     chi )
  }
}
