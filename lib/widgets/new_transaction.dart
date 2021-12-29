import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx) {
    print('constructor new transaction');
  }

  @override
  State<NewTransaction> createState() {
    print('create state new transaction');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate; //not final, changes

  _NewTransactionState() {
    print('constructor new transaction state!');
  }

  @override
  void initState() {
    //for http request mostly.
    super.initState(); //inherit parent class
    print('init state');
  }

  @override
  void didUpdateWidget(covariant NewTransaction oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    print('didUpdateWidget: Called whenever the widget configuration changes');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print('dispose');
  }

  void _submitData() {
    final enteredtitle = _titleController.text;

    final enteredAmount = double.parse(_amountController.text);

    if (enteredtitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return; //no input validation

    widget.addTx(enteredtitle, enteredAmount, _selectedDate);

    Navigator.of(context).pop(); //return back after adding new transactions
  }

  void _openDatePicker() {
    showDatePicker(
            context: context,
            firstDate: DateTime(2019),
            initialDate: DateTime.now(),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        //in order to render the date picker
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
              padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 15),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextField(
                        autocorrect: true,
                        controller: _titleController,
                        onSubmitted: (_) =>
                            _submitData(), //pass null value method

                        decoration: InputDecoration(
                          labelText: 'Enter Title',
                        )),
                    TextField(
                      autocorrect: true,
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                      onSubmitted: (_) =>
                          _submitData(), //pass input value method but not using it

                      decoration: InputDecoration(
                        labelText: 'Enter Amount',
                        prefixIcon: Icon(Icons.attach_money_sharp),
                      ),
                    ),
                    Container(
                      height: 80,
                      child: Row(children: <Widget>[
                        Text(
                          (_selectedDate == null
                              ? 'No date Chosen'
                              : 'Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}'),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.centerRight,
                          child: Platform.isIOS
                              ? CupertinoButton(
                                  child: Text('Choose Date'),
                                  onPressed: _openDatePicker)
                              : ElevatedButton(
                                  child: Text('Choose Date'),
                                  onPressed: _openDatePicker,
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.teal,
                                    padding: EdgeInsets.all(10),
                                  ),
                                ),
                        )
                      ]),
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Colors.teal,
                            textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                        onPressed: _submitData, //dont have value from btn
                        child: Text('Add Transaction'))
                  ]))),
    );
  }
}
