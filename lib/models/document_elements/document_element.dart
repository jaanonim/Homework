import 'package:flutter/cupertino.dart';
import 'package:Homework/models/document_elements/image_doc_element.dart';
import 'package:Homework/models/document_elements/text_doc_element.dart';

abstract class DocumentElement {
  Widget generatePage(saveFunction);

  Map toJSON();

  static DocumentElement fromJSON(Map obj) {
    if (obj.containsKey("imageSrc")) {
      var rotation = obj.containsKey("rotation") ? obj['rotation'] : 0;

      return ImageDocElement(obj["imageSrc"]);
    }
    if (obj.containsKey("text")) {
      return TextDocElement(obj["text"]);
    }
    throw Exception("I get object which not be Document Element");
  }

  void onClick(context, saveFunction);

  void remove();
}
