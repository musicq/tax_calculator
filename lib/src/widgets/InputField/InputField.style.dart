import 'package:flutter/material.dart';

final inputDecoration = InputDecoration(
  prefixIcon: SizedBox(
    child: Center(
      widthFactor: 0,
      child: Text(
        '￥',
        style: TextStyle(color: Colors.black54, fontSize: 24),
      ),
    ),
  ),
);

const inputStyle = TextStyle(fontSize: 30);
