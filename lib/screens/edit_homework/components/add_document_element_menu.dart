import 'package:flutter/material.dart';

class AddDocumentElementMenu extends StatefulWidget {
  final Function addCameraPhoto, addGalleryPhoto, addTextElement;

  AddDocumentElementMenu(
      {this.addCameraPhoto, this.addGalleryPhoto, this.addTextElement});

  @override
  _AddDocumentElementMenuState createState() => _AddDocumentElementMenuState(
      addCameraPhoto: addCameraPhoto,
      addGalleryPhoto: addGalleryPhoto,
      addTextElement: addTextElement);
}

class _AddDocumentElementMenuState extends State<AddDocumentElementMenu>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _buttonColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  Function addCameraPhoto, addGalleryPhoto, addTextElement;

  _AddDocumentElementMenuState(
      {this.addCameraPhoto, this.addGalleryPhoto, this.addTextElement});

  @override
  initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250))
          ..addListener(() {
            setState(() {});
          });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _buttonColor = ColorTween(
      begin: Colors.cyan[700],
      end: Colors.red[700],
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: Curves.linear,
      ),
    ));
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  Widget addGallery() {
    return Container(
        child: FloatingActionButton(
        onPressed: addGalleryPhoto,
        tooltip: 'Add photo from gallery',
        heroTag: "gallery",
        child: Icon(
          Icons.add_photo_alternate,
          color: Colors.white,
        ),
    ));
  }

  Widget addCamera() {
    return Container(
      child: FloatingActionButton(
        onPressed: addCameraPhoto,
        tooltip: 'Add photo from gallery',
        heroTag: "camera",
        child: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget addText() {
    return Container(
      child: FloatingActionButton(
        onPressed: addTextElement,
        tooltip: 'add text element',
        heroTag: "text",
        child: Icon(
          Icons.title,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget toggle() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: _buttonColor.value,
        onPressed: animate,
        tooltip: 'Toggle',
        heroTag: "taggle",
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          color: Colors.white,
          progress: _animateIcon,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 3.0,
            0.0,
          ),
          child: addGallery(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 2.0,
            0.0,
          ),
          child: addCamera(),
        ),
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * 1.0,
            0.0,
          ),
          child: addText(),
        ),
        toggle(),
      ],
    );
  }
}
