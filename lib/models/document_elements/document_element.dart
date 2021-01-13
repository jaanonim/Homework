import 'dart:io';

import 'package:homework/models/document_elements/image_doc_element.dart';

abstract class DocumentElement {
  File generatePage();

  Map toJSON();

  static DocumentElement fromJSON(Map obj) {
    if (obj.containsKey("imageSrc")) {
      return ImageDocElement(obj["imageSrc"]);
    }
    throw Exception("I get object which not be Document Element");
  }
}
