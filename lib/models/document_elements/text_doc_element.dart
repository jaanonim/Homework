import 'package:flutter/cupertino.dart';
import 'package:homework/components/inputPopup.dart';

import 'document_element.dart';

class TextDocElement extends DocumentElement {
  String text;

  final controller = TextEditingController();

  TextDocElement(String text) {
    this.text = text;
  }

  @override
  Widget generatePage() {
    return Align(
        alignment: Alignment.center,
        child: Text(text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
            )));
  }

  @override
  Map toJSON() {
    return {"text": text};
  }

  @override
  void onClick(context, saveFunction) {
    controller.text = text;
    inputPopup(context, "ChangeText", "CHANGE", controller, () {
      text = controller.text;
      saveFunction();
    });
  }
}
