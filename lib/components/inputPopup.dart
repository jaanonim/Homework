import 'package:flutter/material.dart';

inputPopup(BuildContext context, String title, String buttonText, TextEditingController controller, Function create) {
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
            controller: controller,
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                create();
              },
              elevation: 5,
              child: Text(buttonText),
            )
          ],
        );
      });
}
