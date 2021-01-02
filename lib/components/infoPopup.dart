import 'package:flutter/material.dart';

infoPopup(BuildContext context, String title, String content, String buttonText) {
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
          content: Text(content),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              elevation: 5,
              child: Text(buttonText),
            )
          ],
        );
      });
}
