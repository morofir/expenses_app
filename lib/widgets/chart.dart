import 'package:expenses_app/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(7, (index) {
      //length,function to generate
      final weekday = DateTime.now().subtract(Duration(days: index));
      //sum all the transaction values in this day:
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekday.day &&
            recentTransactions[i].date.month == weekday.month &&
            recentTransactions[i].date.year == weekday.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E()
            .format(weekday)
            .substring(0, 1), //this format is for days
        'amount': totalSum
      }; //this return a map (weekday,amount)
    });
  }

  double get totalSpending {
    return groupTransactionValues.fold(0.0, (sum, item) {
      //reduce function
      return sum + item['amount'];
    });

// change as list to other type
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(12),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValues.map((data) {
            // return Text('${data['day']} : ${data["amount"]} ');
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  data['day'],
                  data['amount'],
                  totalSpending == 0.0 //if there no transactions
                      ? 0.0
                      : (data['amount'] as double) / totalSpending),
            ); //this is the precentage shown
          }).toList(),
        ),
      ),
    );
  }
}
