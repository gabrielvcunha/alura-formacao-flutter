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
          Consumer<Transferencias>(builder: (context, transferencias, child) {
            int _quantidadeTransferencias =
                transferencias.transferencias.length;

            if (_quantidadeTransferencias == 0)
              return SemTransferenciasCadastradas();

            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount:
                  _quantidadeTransferencias < 2 ? _quantidadeTransferencias : 2,
              shrinkWrap: true,
              itemBuilder: (context, indice) => ItemTransferencia(
                  transferencias.transferencias.reversed.toList()[indice]),
            );
          }),
          RaisedButton(
            child: Text("Ver todas as transferências"),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ListaTransferencias())),
          ),
        ],
      );
}

class SemTransferenciasCadastradas extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.all(35),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Voce ainda nao cadastrou nenhuma transferencia",
            textAlign: TextAlign.center,
          ),
        ),
      );
}
