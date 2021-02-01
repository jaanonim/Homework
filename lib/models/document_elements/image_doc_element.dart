import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Homework/models/document_elements/document_element.dart';

class ImageDocElement extends DocumentElement {
  static const IconData rotate_left = IconData(0xe994, fontFamily: 'MaterialIcons');
  static const IconData rotate_right = IconData(0xe995, fontFamily: 'MaterialIcons');
  String imageSrc;
  int rotation;

  ImageDocElement(var imageSrc, int rotation) {
    this.imageSrc = imageSrc;
    this.rotation = rotation;
  }

  @override
  Widget generatePage(saveFunction) {
    return Stack(children: [Image.file(File(imageSrc)),
      Align(
        alignment: Alignment.topLeft,
        child: Row(children: [
          IconButton(icon: Icon(rotate_left), onPressed: (){
            this.rotation -= 90;
            saveFunction();
          }),
          IconButton(icon: Icon(rotate_right), onPressed: (){
            this.rotation += 90;
            saveFunction();
          })
        ],),
      )]);
  }

  @override
  Map toJSON() {
    return {"imageSrc": imageSrc, "rotation": rotation};
  }

  @override
  void onClick(context, saveFunction) {
    return;
  }

  void remove() {
    File(imageSrc).delete();
  }
}
