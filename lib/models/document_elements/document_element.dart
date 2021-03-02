import 'package:flutter/cupertino.dart';
import 'package:Homework/models/document_elements/image_doc_element.dart';
import 'package:Homework/models/document_elements/text_doc_element.dart';

abstract class DocumentElement {
  Widget generatePage(saveFunction, context);

  Map toJSON();

  static DocumentElement fromJSON(Map obj) {
    if (obj.containsKey("imageSrc")) {
      var direction = obj.containsKey("direction") ? obj['direction'] : 0;

      return ImageDocElement(imageSrc: obj["imageSrc"], direction: direction);
    }
    if (obj.containsKey("text")) {
      return TextDocElement(obj["text"]);
    }
    throw Exception("I get object which not be Document Element");
  }

  void onClick(context, saveFunction);

  void remove();
}
