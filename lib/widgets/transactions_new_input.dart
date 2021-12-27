import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredtitle = titleController.text;

    final enteredAmount = double.parse(amountController.text);

    if (enteredtitle.isEmpty || enteredAmount <= 0)
      return; //no input validation

    widget.addTx(enteredtitle, enteredAmount);

    Navigator.of(context).pop(); //return back after adding new transactions
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextField(
                      autocorrect: true,
                      controller: titleController,
                      onSubmitted: (_) => submitData(), //pass null value method

                      decoration: InputDecoration(
                        labelText: 'Enter Title',
                      )),
                  TextField(
                    autocorrect: true,
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    onSubmitted: (_) =>
                        submitData(), //pass input value method but not using it

                    decoration: InputDecoration(
                      labelText: 'Enter Amount',
                      prefixIcon: Icon(Icons.attach_money_sharp),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      onPressed: submitData, //dont have value from btn
                      child: Text('Add Transaction'))
                ])));
  }
}
