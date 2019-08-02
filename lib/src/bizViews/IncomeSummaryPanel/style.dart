import 'package:flutter/material.dart';

final boxStyle = BoxDecoration(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(40),
    bottomRight: Radius.circular(40),
  ),
  gradient: LinearGradient(
    colors: [Colors.indigoAccent, Colors.indigoAccent[400]],
    begin: const FractionalOffset(0.5, 0),
    end: const Alignment(0.3, 1),
    stops: [0, 0.8],
  ),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      offset: Offset(0, 2),
      spreadRadius: 3,
      blurRadius: 6,
    )
  ],
);

const alertText = TextStyle(fontSize: 16, color: Colors.black54);
