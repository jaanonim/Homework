import 'dart:io';
import 'package:flutter/material.dart';
import 'package:Homework/models/document_elements/document_element.dart';

class ImageDocElement extends DocumentElement {
  String imageSrc;
  int direction;

  ImageDocElement({imageSrc, direction}){
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
            image: FileImage(File(imageSrc))),
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

  @override
  void onClick(context, saveFunction) {
    return;
  }

  void remove() {
    File(imageSrc).delete();
  }
}
