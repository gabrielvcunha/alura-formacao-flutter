import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: FormularioTransferencia(),
    ),
  );
}

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Criando Transferencia")),
    body: Column(
      children: <Widget>[
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
            style: TextStyle(fontSize: 24.0),
            decoration: InputDecoration(
              labelText: "Numero da conta",
              hintText: "0000",
            ),
            keyboardType: TextInputType.number,
            controller: _controladorCampoNumeroConta,
          ),
        ),
        Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: TextField(
              style: TextStyle(fontSize: 24.0),
              decoration: InputDecoration(
                icon: Icon(Icons.monetization_on),
                labelText: "Valor",
                hintText: "0.00",
              ),
              keyboardType: TextInputType.number,
              controller: _controladorCampoValor),
        ),
        RaisedButton(
          child: Text("Confirmar"),
          onPressed: () {
            debugPrint("Clicou no confirmar");
            final int numeroConta =
            int.tryParse(_controladorCampoNumeroConta.text);
            final double valor =
            double.tryParse(_controladorCampoNumeroConta.text);
            if (numeroConta != null && valor != null) {
              final transferenciaCriada = Transferencia(valor, numeroConta);
              debugPrint("$transferenciaCriada");
            }
          },
        ),
      ],
    ),
  );
}

class ListaTransferencias extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Transferencias")),
    body: Column(
      children: <ItemTransferencia>[
        ItemTransferencia(Transferencia(100.0, 1000)),
        ItemTransferencia(Transferencia(200.0, 2000)),
        ItemTransferencia(Transferencia(300.0, 3000)),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      child: Icon(Icons.add),
    ),
  );
}

class ItemTransferencia extends StatelessWidget {
  final Transferencia _transferencia;

  ItemTransferencia(this._transferencia);

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: Icon(Icons.monetization_on),
      title: Text(_transferencia.valor.toString()),
      subtitle: Text(_transferencia.numeroConta.toString()),
    ),
  );
}

class Transferencia {
  final double valor;
  final int numeroConta;

  Transferencia(this.valor, this.numeroConta);

  @override
  String toString() {
    return 'Transferencia{valor: $valor, numeroConta: $numeroConta}';
  }
}
