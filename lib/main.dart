import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/trans_list.dart';
import 'package:expenses_app/widgets/transactions_new_input.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: MyHomePage(),
      theme: ThemeData(
          fontFamily: 'Quicksand',
          primarySwatch:
              null), //we can use it for auto theme, all btns object will be in this shades
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(child: NewTransaction(_addNewTransaction));
        }); //for wont use the second context
  }

  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'Sufersal',
    //   amount: 129.49,
    //   date: DateTime.now(),
    // )
  ];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
          Duration(days: 7))); //from this week only (now minus 7 days)
    }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87, // status bar color
        title: Text('Personal Expenses'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add_circle_outline_rounded),
              onPressed: () => _startAddNewTransaction(context)),
        ],
      ),
      //need to be here, wont work (or we can do it inside translist with 300 height)
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start, //default value main
          crossAxisAlignment:
              CrossAxisAlignment.center, //(right left) secondary
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Card(
                color: Colors.white24,
                child: Chart(_recentTransactions),
                elevation: 5,
              ),
            ),
            TransactionList(_userTransactions),
          ]),
      floatingActionButtonLocation: null, //can change default location
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
