import 'package:flutter/material.dart';

final borderRadius = BorderRadius.circular(12);

final inkBoxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: borderRadius,
  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
);

const boxSize = BoxConstraints.expand(width: 170, height: 190);

const boxPadding = EdgeInsets.only(top: 30);

const title = TextStyle(fontSize: 26, color: Colors.black);

const imgPadding = EdgeInsets.all(12);