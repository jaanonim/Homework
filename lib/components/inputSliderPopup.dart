import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void inputSliderPopup(BuildContext context, String title, String buttonText,
    int value, Function(int) create) async {

  final v = await showDialog<int>(
    context: context,
    builder: (context) => InputSliderPopup(initialValue: value, title: title, buttonText: buttonText, create: create),
  );
  if (v != null) {
    create(v);
  }
}

class InputSliderPopup extends StatefulWidget {

  final int initialValue;
  final String title;
  final String  buttonText;
  final Function(int) create;

  const InputSliderPopup({Key key, this.initialValue, this.title, this.buttonText, this.create}) : super(key: key);

  @override
  _InputSliderPopupState createState() => _InputSliderPopupState();
}

class _InputSliderPopupState extends State<InputSliderPopup> {

  int _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      content: SizedBox(
        height: 50,
        child: Slider(
          value: _value.toDouble(),
          min: 10,
          max: 100,
          divisions: 9,
          activeColor: Theme.of(context).accentColor,
          label: _value.round().toString(),
          onChanged: (double value) {
            setState(() {
              _value = value.round();
            });
          },
          onChangeEnd: (double value){
            setState(() {
              _value = value.round();
            });
            widget.create(_value);
          },
        ),
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
          },
          elevation: 5,
          child: Text(widget.buttonText),
        )
      ],
    );
  }
}
