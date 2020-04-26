import 'package:expenses/widgets/chart_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';
import 'widgets/list_transaction.dart';
import 'widgets/new_transaction.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expenses',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                color: Colors.black87,
                fontSize: 22,
              ),
            ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> _transactions = [];
  int lastTransactionID = 0;

  void _addTransactionHandler({
    String title,
    double amount,
    DateTime chosenDate,
  }) {
    final newTX = Transaction(
      id: lastTransactionID++,
      title: title,
      amount: amount,
      date: chosenDate,
    );

    setState(() {
      _transactions.add(newTX);
    });
  }

  void _showNewTransactionModelSheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) => NewTransaction(_addTransactionHandler),
    );
  }

  void _handleDeleteTransaction(int id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Transaction> get _recentTransaction {
    return _transactions.where((tx) {
      DateTime rangeEndDate = DateTime.now().subtract(Duration(days: 7));
      return tx.date.isAfter(rangeEndDate);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _showNewTransactionModelSheet(context),
        )
      ],
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.3,
              child: ChartCard(_recentTransaction),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              padding: const EdgeInsets.all(10),
              child: TransactionList(
                _transactions,
                _handleDeleteTransaction,
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => _showNewTransactionModelSheet(context),
      ),
    );
  }
}
