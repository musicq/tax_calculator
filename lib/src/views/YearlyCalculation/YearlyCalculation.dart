import 'package:flutter/material.dart';
import 'package:tax_calculator/src/bizViews/IncomeSummaryPanel/IncomeSummaryPanel.dart';
import 'package:tax_calculator/src/widgets/MainContainer/MainContainer.dart';
import 'package:tax_calculator/src/widgets/MonthCard/MonthCard.dart';

class YearlyCalculation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MainContainer(
      showAppBar: false,
      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey[100],
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: ListView.builder(
              itemCount: 13,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: EdgeInsets.only(top: 230),
                  );
                }

                return MonthCard(
                  month: index,
                );
              },
            ),
          ),
          IncomeSummaryPanel(),
        ],
      ),
    );
  }
}
