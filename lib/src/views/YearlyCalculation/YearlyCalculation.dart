import 'package:flutter/material.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

class YearlyCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
        showAppBar: false,
        body: Opacity(
          opacity: 0.8,
          child: Container(
            constraints: BoxConstraints.expand(height: 200),
            decoration: BoxDecoration(
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
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    spreadRadius: 3,
                    blurRadius: 6,
                  )
                ]),
            child: Text('1111'),
          ),
        ));
  }
}
