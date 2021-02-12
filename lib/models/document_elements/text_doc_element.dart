import 'package:flutter/cupertino.dart';
import 'package:Homework/components/inputPopup.dart';

import 'document_element.dart';

class TextDocElement extends DocumentElement {
  String text;

  final controller = TextEditingController();

  TextDocElement(String text) {
    this.text = text;
  }

  @override
  Widget generatePage(saveFunction) {
    return Align(
        alignment: Alignment.center,
        child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: 130, minWidth: double.infinity),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )));
  }

  @override
  Map toJSON() {
    return {"text": text};
  }

  @override
  void onClick(context, saveFunction) {
    controller.text = text;
    inputPopup(context, "ChangeText", "Change", controller, () {
      Navigator.pop(context);
      text = controller.text;
      saveFunction();
    });
  }

  void remove(){
    return;
  }
}
