import 'package:bytebank/components/saldo.dart';
import 'package:flutter/material.dart';

const _tituloAppBar = "Bytebank";

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(_tituloAppBar)),
        body: Align(
          child: Saldo(),
          alignment: Alignment.topCenter,
        ),
      );
}
