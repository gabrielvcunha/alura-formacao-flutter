import 'package:flutter/material.dart';

class Saldo extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: EdgeInsets.all(20.0),
      child: Text(
        "50.00",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 40,
          fontWeight: FontWeight.bold,
        ),
      )
    ),
  );
}
