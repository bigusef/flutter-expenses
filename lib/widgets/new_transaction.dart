import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function saveTransaction;

  NewTransaction(this.saveTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _transactionDate;

  void submitNewTransaction() {
    final String addedTitle = titleController.text;
    final double addedAmount = double.parse(amountController.text);

    if (addedTitle.isEmpty || addedAmount <= 0 || _transactionDate == null) {
      return null;
    }

    widget.saveTransaction(
      title: addedTitle,
      amount: addedAmount,
      chosenDate: _transactionDate,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) => submitNewTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitNewTransaction(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text('You don\'t select Date yet.'),
                  ),
                  FlatButton(
                    child: Text('Choose Date'),
                    onPressed: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2019),
                      lastDate: DateTime.now(),
                    ).then(
                      (value) => setState(() {
                        _transactionDate = value;
                      }),
                    ),
                  ),
                ],
              ),
            ),
            FlatButton(
              onPressed: submitNewTransaction,
              child: Text(
                'Add Transaction',
                style: TextStyle(color: Colors.white),
              ),
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
