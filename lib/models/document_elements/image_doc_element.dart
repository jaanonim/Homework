import 'dart:io';

import 'package:flutter/material.dart';
import 'package:homework/models/document_elements/document_element.dart';

class ImageDocElement extends DocumentElement {
  String imageSrc;

  ImageDocElement(var imageSrc) {
    this.imageSrc = imageSrc;
  }

  @override
  Widget generatePage() {
    return Image.file(File(imageSrc));
  }

  @override
  Map toJSON() {
    return {"imageSrc": imageSrc};
  }

  @override
  void onClick(context,saveFunction) {
    return;
  }

  void remove(){
    File(imageSrc).delete();
  }
}
