import 'package:flutter/material.dart';
import 'package:tax_calculator/src/shared/decimal.dart';
import 'package:tax_calculator/src/styles/theme.dart';

import 'InputField.style.dart' as InputFieldStyle;

class InputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final bool showTip;
  final String tipMsg;

  InputField({
    this.label,
    this.controller,
    this.onChanged,
    this.showTip = true,
    this.tipMsg,
  });

  @override
  State<StatefulWidget> createState() {
    return _InputFieldState();
  }
}

class _InputFieldState extends State<InputField> {
  final _focusNode = FocusNode();

  _onTapQuestion(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.tipMsg, style: InputFieldStyle.alertText),
            ),
          ],
        );
      },
    );
  }

  _onSubmit(String v) {
    if (widget.controller != null) {
      widget.controller.text = toMoney(D(v));
    }
  }

  _onFocusChange() {
    final _ctrl = widget.controller;

    if (_focusNode.hasFocus && _ctrl != null) {
      _ctrl.selection =
          TextSelection(baseOffset: 0, extentOffset: _ctrl.text.length);
    }
  }

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(widget.label, style: GlobalStyle.tipText),
              if (widget.showTip) ...[
                GestureDetector(
                  onTap: () => _onTapQuestion(context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/question.png',
                      width: 14,
                      height: 14,
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            ],
          ),
          TextField(
            focusNode: _focusNode,
            controller: widget.controller,
            style: InputFieldStyle.inputStyle,
            decoration: InputFieldStyle.inputDecoration,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            onChanged: widget.onChanged,
            onSubmitted: _onSubmit,
          ),
        ],
      ),
    );
  }
}
