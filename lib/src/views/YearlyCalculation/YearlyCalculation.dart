import 'package:flutter/material.dart';
import 'package:tax_calculator/src/bizViews/IncomeSummaryPanel/IncomeSummaryPanel.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';

class YearlyCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
      showAppBar: false,
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                  padding: EdgeInsets.only(top: 230),
                );
              }

              return ListTile(
                title: Text(index.toString()),
                onTap: () {
                  Scaffold.of(context).hideCurrentSnackBar();
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text(index.toString())));
                },
              );
            },
          ),
          IncomeSummaryPanel(),
        ],
      ),
    );
  }
}
