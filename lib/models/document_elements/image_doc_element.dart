import 'dart:io';

import 'package:homework/models/document_elements/document_element.dart';

class ImageDocElement extends DocumentElement {
  String imageSrc;

  ImageDocElement(var imageSrc) {
    this.imageSrc = imageSrc;
  }

  @override
  File generatePage() {
    return File(imageSrc);
  }

  @override
  Map toJSON() {
    return {"imageSrc": imageSrc};
  }
}
