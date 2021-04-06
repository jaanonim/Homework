import 'dart:io';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:Homework/models/document_elements/document_element.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image/image.dart' as img;

class ImageDocElement extends DocumentElement {
  String imageSrc;
  int direction;
  bool _done = false;

  ImageDocElement({imageSrc, direction}) {
    this.imageSrc = imageSrc;
    this.direction = direction != Null ? direction : 0;
  }

  @override
  Widget generatePage(saveFunction, context) {
    return Stack(children: [
      RotatedBox(
        quarterTurns: direction,
        child: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: MemoryImage(File(imageSrc).readAsBytesSync())),
      ),
      Align(
        alignment: Alignment.topLeft,
        child: Row(
          children: [
            MaterialButton(
              onPressed: () {
                direction--;
                saveFunction();
              },
              elevation: 10.0,
              child: Icon(
                Icons.rotate_left,
                size: 25.0,
              ),
              shape: CircleBorder(),
              color: Theme.of(context).accentColor,
              minWidth: 0,
            ),
            MaterialButton(
              onPressed: () {
                direction++;
                saveFunction();
              },
              elevation: 10.0,
              child: Icon(
                Icons.rotate_right,
                size: 25.0,
              ),
              shape: CircleBorder(),
              color: Theme.of(context).accentColor,
              minWidth: 0,
            ),
          ],
        ),
      )
    ]);
  }

  @override
  Map toJSON() {
    return {"imageSrc": imageSrc, "direction": direction};
  }

  List<int> rotate(saveFunction) {
    var file = File(imageSrc);
    var data = file.readAsBytesSync();
    if (direction % 4 != 0) {
      var decodedImg = img.decodeImage(data);
      decodedImg = img.copyRotate(decodedImg, direction * 90);
      data = img.encodeJpg(decodedImg);
      file.writeAsBytes(data);
      direction = 0;
      saveFunction();
    }
    return data;
  }

  @override
  void onClick(context, saveFunction) async {
    if (_done) {
      return;
    }
    Flushbar(
      message: 'Loading...',
      backgroundColor: Theme.of(context).accentColor,
      leftBarIndicatorColor: Theme.of(context).primaryColor,
      duration: Duration(seconds: 3),
    )..show(context);
    _done = true;
    await Future.delayed(Duration(seconds: 1), () async {
      editPhoto(context, saveFunction);
    });
  }

  void editPhoto(context, saveFunction) async {
    rotate(saveFunction);

    File c = await ImageCropper.cropImage(
      sourcePath: imageSrc,
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Edit photo',
          toolbarColor: Theme.of(context).primaryColor,
          statusBarColor: Colors.cyan[850],
          backgroundColor: Theme.of(context).backgroundColor,
          hideBottomControls: true,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false),
    );
    if (c != null) {
      if (await c.exists()) {
        this.remove();
        this.imageSrc = c.path;
        saveFunction();
      }
    }
    _done = false;
  }

  void remove() {
    File(imageSrc).delete();
  }
}
