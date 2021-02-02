import 'dart:io';

import 'package:flutter/material.dart';
import 'package:Homework/models/document_elements/document_element.dart';
import 'package:image/image.dart' as img;

class ImageDocElement extends DocumentElement {
  static const IconData rotate_left = IconData(0xe994, fontFamily: 'MaterialIcons');
  static const IconData rotate_right = IconData(0xe995, fontFamily: 'MaterialIcons');
  String imageSrc;
  var decodedImg;
  var encodedImg;

  ImageDocElement(var imageSrc) {
    this.imageSrc = imageSrc;
    encodedImg = File(imageSrc).readAsBytesSync();
    decodedImg = img.decodeImage(encodedImg);
  }

  Future<void> rotateImage(int direction) async{
    decodedImg = img.copyRotate(decodedImg , direction);
    encodedImg = img.encodeJpg(decodedImg);
    File(imageSrc).writeAsBytes(encodedImg);
  }

  @override
  Widget generatePage(saveFunction) {
    return Stack(children: [Image.memory(encodedImg),
      Align(
        alignment: Alignment.topLeft,
        child: Row(children: [
          IconButton(icon: Icon(rotate_left), onPressed: () {
            rotateImage(-90);
            saveFunction();
          }),
          IconButton(icon: Icon(rotate_right), onPressed: () {
            rotateImage(90);
            saveFunction();
          })
        ],),
      )]);
  }

  @override
  Map toJSON() {
    return {"imageSrc": imageSrc};
  }

  @override
  void onClick(context, saveFunction) {
    return;
  }

  void remove() {
    File(imageSrc).delete();
  }
}
