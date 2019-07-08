import 'package:flutter/material.dart';
import 'package:tax_calculator/src/styles/theme.dart';

import 'InputField.style.dart' as InputFieldStyle;

class InputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  InputField({this.label, this.controller, this.onChanged});

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
          Text(widget.label, style: GlobalStyle.tipText),
          TextField(
            controller: widget.controller,
            style: InputFieldStyle.inputStyle,
            decoration: InputFieldStyle.inputDecoration,
            keyboardType: TextInputType.number,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}
