import 'package:flutter/material.dart';

class InputField extends StatefulWidget {
  final String label;

  InputField({this.label});

  @override
  State<StatefulWidget> createState() {
    return _InputFieldState();
  }
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.label,
            textAlign: TextAlign.start,
            style: TextStyle(color: Colors.black12),
          ),
          TextField(
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 30),
            decoration: InputDecoration(
              icon: Icon(
                Icons.attach_money,
                size: 20,
              ),
            ),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
