import 'package:flutter/material.dart';

final borderRadius = BorderRadius.circular(12);

final inkBoxDecoration = (bool active) => BoxDecoration(
    color: active ? Colors.blue[50] : Colors.white,
    borderRadius: borderRadius,
    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
    border: Border.all(color: active ? Colors.blueAccent : Colors.transparent));

BoxConstraints boxSize(bool small) {
  return small
      ? BoxConstraints.expand(width: 150, height: 170)
      : BoxConstraints.expand(width: 170, height: 190);
}

EdgeInsets boxPadding(bool small) {
  return small ? EdgeInsets.only(top: 24) : EdgeInsets.only(top: 30);
}

TextStyle title(bool small) {
  return small
      ? TextStyle(fontSize: 20, color: Colors.black)
      : TextStyle(fontSize: 25, color: Colors.black);
}

const imgPadding = EdgeInsets.all(12);
