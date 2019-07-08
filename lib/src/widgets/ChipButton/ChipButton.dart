import 'package:flutter/material.dart';

class ChipButton extends StatelessWidget {
  final String text;
  final Function onTap;

  ChipButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(width: 60, height: 24),
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.black38),
        child: Text(text, style: TextStyle(color: Colors.black38)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        onPressed: onTap,
      ),
    );
  }
}
