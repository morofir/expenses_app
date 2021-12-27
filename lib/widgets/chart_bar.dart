import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendAmount;
  final double spendAmountPrecent;

  ChartBar(this.label, this.spendAmount, this.spendAmountPrecent);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: 20,
        child: FittedBox(
          //for font wont grow
          child: Text('\$${spendAmount.toStringAsFixed(0)}'),
        ),
      ),
      SizedBox(height: 4),
      Container(
          height: 60,
          width: 10,
          child: Stack(children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ),
                color: Color.fromRGBO(220, 220, 220, 1),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            FractionallySizedBox(
                heightFactor: spendAmountPrecent, //0-1 value
                child: Container(
                    decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ))),
          ])), //stack widget
      SizedBox(height: 4),
      Text(label),
    ]);
  }
}
