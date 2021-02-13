import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/screens/dashboard/saldo_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = "Bytebank";

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(_tituloAppBar)),
        body: ListView(children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: SaldoCard(),
          ),
          Consumer<Saldo>(
            builder: (context, saldo, child) => RaisedButton(
              child: Text("Adiciona"),
              onPressed: () {
                saldo.subtrai(10);
              },
            ),
          )
        ]),
      );
}
