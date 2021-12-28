import 'package:expenses_app/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  void showDialogDelete(context, var id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () => Navigator.of(context).pop(),
    );
    Widget continueButton = TextButton(
        child: Text("Delete"),
        onPressed: () => {deleteTransaction(id), Navigator.of(context).pop()});

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Expense Delete"),
      content: Text("Would you like to delete this expense?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height / 1.5,
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
                        onPressed: () =>
                            showDialogDelete(ctx, transactions[index].id),
                        // deleteTransaction(transactions[index].id),
                        icon: Icon(Icons.delete),
                        color: Colors.red),
                  ),
                );
              },
              itemCount: transactions.length, //number of item to render
            ),
    );
  }
}
