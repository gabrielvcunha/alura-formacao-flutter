import 'package:flutter/material.dart';

class TransactionAuthDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text("Authenticate"),
        content: TextField(
          obscureText: true,
          maxLength: 4,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: TextStyle(fontSize: 64, letterSpacing: 24),
          decoration: InputDecoration(border: OutlineInputBorder()),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => print("Cancela"),
            child: Text("Cancel"),
          ),
          FlatButton(
            onPressed: () => print("Confirma"),
            child: Text("Confirm"),
          ),
        ],
      );
}
