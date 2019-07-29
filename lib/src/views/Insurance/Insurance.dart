import 'package:flutter/material.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

class Insurance extends StatefulWidget {
  @override
  _InsuranceState createState() => _InsuranceState();
}

class _InsuranceState extends State<Insurance> {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
      body: Text('社保'),
    );
  }
}
