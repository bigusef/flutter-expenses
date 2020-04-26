import 'package:expenses/models/transaction.dart';
import 'package:expenses/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartCard extends StatelessWidget {
  final List<Transaction> recentTransaction;

  ChartCard(this.recentTransaction);

  List<Map<String, Object>> get groupedTransaction {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (var tx in recentTransaction) {
        if (tx.date.day == weekDay.day && tx.date.month == weekDay.month) {
          totalAmount += tx.amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay),
        'amount': totalAmount,
      };
    }).reversed.toList();
  }

  double get totalSpendingAmount {
    return groupedTransaction.fold(0.0, (sum, item) {
      return sum += item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: groupedTransaction.map((data) {
            final double txPercent = totalSpendingAmount > 0.0
                ? (data['amount'] as double) / totalSpendingAmount
                : 0.0;
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                title: data['day'],
                amount: data['amount'],
                percent: txPercent,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
