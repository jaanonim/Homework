import 'package:flutter/cupertino.dart';
import 'package:homework/models/document_elements/image_doc_element.dart';
import 'package:homework/models/document_elements/text_doc_element.dart';

abstract class DocumentElement {
  Widget generatePage();

  Map toJSON();

  static DocumentElement fromJSON(Map obj) {
    if (obj.containsKey("imageSrc")) {
      return ImageDocElement(obj["imageSrc"]);
    }
    if (obj.containsKey("text")) {
      return TextDocElement(obj["text"]);
    }
    throw Exception("I get object which not be Document Element");
  }

  void onClick(context,saveFunction);
}
