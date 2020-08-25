import 'package:expense_tracker/widgets/chart.dart';

import './widgets/new_transactions.dart';
import './widgets/transactions_list.dart';
import './models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.blue,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(fontFamily: 'OpenSans', fontSize: 20)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //to accept ip from text fields

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _usertransactions = [
    //  Transaction(
    //      id: 'T1', title: 'Smartphone', amount: 40, date: DateTime.now()),
    //  Transaction(
    //      id: 'T2', title: 'Medicines', amount: 30.50, date: DateTime.now())
  ];
  List<Transaction> get _recentTransactions {
    return _usertransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransactions(
      String txTitle, double txAmount, DateTime choosenDate) {
    var newTx = Transaction(
        title: txTitle,
        amount: txAmount,
        date: choosenDate,
        id: DateTime.now().toString());
    setState(() {
      _usertransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //ctx - User Provided context to specify in which context Bottomsheet is to be rendered
    //bCtx - Context of showModalBottomSheet.....has Metadata of Widget it builds
    //  since we dont use it _ mentioned
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransactions(_addNewTransactions);
        });
  }

  void _deleteTransactions(String id) {
    setState(() {
      _usertransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar=AppBar(
        title: Text(
          'Expense Tracker',
          style: TextStyle(fontFamily: 'OpenSans'),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () => _startAddNewTransaction(context))
        ],
      );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                width: double.infinity,
                child: Card(
                  color: Colors.blue,
                )),
            Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height) * 0.3,
              child: Chart(_recentTransactions)),
            Container(
              height: (
                MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7 ,
              child: TransactionList(_usertransactions, _deleteTransactions))
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context)),
    );
  }
}
