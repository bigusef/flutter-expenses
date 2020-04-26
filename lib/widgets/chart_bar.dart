import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String title;
  final double amount;
  final double percent;

  ChartBar({
    @required this.title,
    @required this.amount,
    @required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrans) {
        return Column(
          children: <Widget>[
            Container(
              height: constrans.maxHeight * .15,
              child: FittedBox(
                child: Text('\$${amount.toStringAsFixed(0)}'),
              ),
            ),
            SizedBox(
              height: constrans.maxHeight * .05,
            ),
            Container(
              width: 10,
              height: constrans.maxHeight * .60,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(220, 220, 220, 1),
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    widthFactor: percent,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constrans.maxHeight * .05,
            ),
            Container(
              height: constrans.maxHeight * .15,
              child: FittedBox(
                child: Text(title),
              ),
            ),
          ],
        );
      },
    );
  }
}
