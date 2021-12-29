import 'package:expenses_app/widgets/chart.dart';
import 'package:expenses_app/widgets/trans_list.dart';
import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'model/transaction.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  // [DeviceOrientation.portraitUp]); //no landscape mode
  runApp(MyApp());
}

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

//WidgetsBindingObserver for mixing
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return GestureDetector(child: NewTransaction(_addNewTransaction));
        }); //for wont use the second context
  }

  final List<Transaction> _userTransactions = [
    //empty at first
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
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('changed lifecycle state: ' + state.toString());
    //inactive,pause,resumed,detached
  }

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
          Duration(days: 30))); //from this month only (now minus 7 days)
    }).toList();
  }

  bool _showChart = false;

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      // _userTransactions.removeWhere((tx)=>tx.id == id);
      _userTransactions.removeWhere((tx) {
        return tx.id == id; //remove by id in the list
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final pageBody = Column(
      mainAxisAlignment: MainAxisAlignment.start, //default value main
      crossAxisAlignment: CrossAxisAlignment.center, //(right left) secon dary
      children: <Widget>[
        isLandscape
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart ',

                    textScaleFactor: 1.2, //1.2 the default font size
                  ),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        //trigger the build method
                        _showChart = val;
                      });
                    },
                  ),
                ],
              )
            : Container(
                width: double.infinity,
                child: Card(
                  color: Colors.white24,
                  child: Chart(_recentTransactions), //chart
                  elevation: 5,
                ),
              ),
        _showChart
            ? Container(
                width: double.infinity,
                child: Card(
                  color: Colors.white24,
                  child: Chart(_recentTransactions), //chart
                  elevation: 5,
                ),
              )
            : TransactionList(_userTransactions, _deleteTransaction), //list
      ],
    );
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
      body: pageBody,
      floatingActionButtonLocation: null, //can change default location
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
