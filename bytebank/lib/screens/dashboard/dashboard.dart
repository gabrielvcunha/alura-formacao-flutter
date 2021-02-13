import 'file:///C:/Users/gabri/Repos/Alura/alura-formacao-flutter/bytebank/lib/screens/dashboard/saldo.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = "Bytebank";

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(_tituloAppBar)),
        body: Align(
          alignment: Alignment.topCenter,
          child: SaldoCard(Saldo(50.00)),
        ),
      );
}
