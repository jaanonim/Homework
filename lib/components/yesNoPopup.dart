import 'package:flutter/material.dart';

yesNoPopup(BuildContext context, String title, Function onYes) {
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
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              elevation: 5,
              child: Text('No'),
            ),
            MaterialButton(
              onPressed: () {
                onYes();
                Navigator.pop(context);
              },
              elevation: 5,
              child: Text('Yes'),
            )
          ],
        );
      });
}
