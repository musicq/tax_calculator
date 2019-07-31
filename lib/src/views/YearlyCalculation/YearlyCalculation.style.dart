import 'package:flutter/material.dart';

final topicBox = BoxDecoration(
  borderRadius: BorderRadius.only(
    bottomLeft: Radius.circular(40),
    bottomRight: Radius.circular(40),
  ),
  gradient: LinearGradient(
    colors: [Colors.indigoAccent[100], Colors.indigoAccent],
    begin: const FractionalOffset(0.5, 0),
    end: const Alignment(0.3, 1),
    stops: [0, 0.8],
  ),
);
