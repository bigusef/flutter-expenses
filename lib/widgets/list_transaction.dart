import 'package:expenses/widgets/empty_list.dart';
import 'package:expenses/widgets/reansaction_card.dart';

import '../models/transaction.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteAction;

  TransactionList(this.transactions, this.deleteAction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? EmpetyList()
        : ListView.builder(
            itemBuilder: (ctx, index) => TransactionCard(
              transaction: transactions[index],
              deleteAction: deleteAction,
            ),
            itemCount: transactions.length,
          );
  }
}
