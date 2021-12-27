import 'package:expenses_app/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 510,
      child: transactions.isEmpty
          ? Column(
              children: [
                Text('No transactions to show...',
                    style: TextStyle(
                      fontSize: 25,
                    )),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 300,
                  child: Image.asset(
                    'assets/images/waiting2.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: CircleAvatar(
                          backgroundColor: Colors.teal[400],
                          foregroundColor: Colors.black,
                          radius: 30,
                          child: Text('\$${transactions[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(transactions[index].title,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand')),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete),
                        color: Colors.red),
                  ),
                );
                // return Card(
                //   child: Row(children: <Widget>[
                //     Container(
                //       margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(12),
                //           border: Border.all(width: 1, color: Colors.black)),
                //       padding: EdgeInsets.all(10),
                //       child: Text(
                //         '\$${transactions[index].amount.toStringAsFixed(2)}', //$ + text
                //         style: TextStyle(fontSize: 16, fontFamily: 'Quicksand'),
                //       ),
                //     ),
                //     Column(children: <Widget>[
                //       Text('${transactions[index].title}',
                //           style: TextStyle(
                //               fontWeight: FontWeight.bold,
                //               fontSize: 21,
                //               color: Colors.teal)),
                //       Text(DateFormat.yMMMMd().format(transactions[index].date),
                //           style: TextStyle(
                //               fontWeight: FontWeight.w400, color: Colors.grey)),
                //     ])
                //   ]),
                // );
              },
              itemCount: transactions.length, //number of item to render
            ),
    );
  }
}
