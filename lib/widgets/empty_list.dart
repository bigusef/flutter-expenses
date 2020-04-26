import 'package:flutter/material.dart';

class EmpetyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'You do not have any expenses yet!!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.title,
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 200,
          child: Image.asset(
            'images/waiting.png',
            fit: BoxFit.cover,
          ),
        )
      ],
    );
  }
}
