import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

inputPopup(BuildContext context, String title, String buttonText,
    TextEditingController controller, Function create) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          content: TextField(
            autofocus: true,
            controller: controller,
            style: Theme.of(context).textTheme.bodyText1,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(2, 5, 2, 5),
              isDense: true,
            ),
            onSubmitted: (value) {
              Navigator.pop(context);
              create();
            },
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
                create();
              },
              elevation: 5,
              child: Text(buttonText),
            )
          ],
        );
      });
}
