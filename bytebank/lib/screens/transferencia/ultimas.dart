import 'package:bytebank/models/transferencias.dart';
import 'package:bytebank/screens/transferencia/lista.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UltimasTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Text(
            "Ultimas transfrencias",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer<Transferencias>(
              builder: (context, transferencias, child) {
                return ListView.builder(
                  padding: EdgeInsets.all(8),
                  itemCount: 2,
                  shrinkWrap: true,
                  itemBuilder: (context, indice) => ItemTransferencia(transferencias.transferencias[indice]),
                );
              }),
          RaisedButton(
            child: Text("Transferências"),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListaTransferencias())),
          ),
        ],
      );
}
