import 'package:flutter/material.dart';

void main() => runApp(BytebankApp());

class BytebankApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: ListaTransferencias(),
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
            Editor(
              controlador: _controladorCampoNumeroConta,
              rotulo: "Numero da conta",
              dica: "0000",
            ),
            Editor(
              controlador: _controladorCampoValor,
              rotulo: "Valor",
              dica: "0,00",
              icone: Icons.monetization_on,
            ),
            RaisedButton(
              child: Text("Confirmar"),
              onPressed: () {
                Navigator.pop(context, _criaTransferencia());
              },
            ),
          ],
        ),
      );

  Transferencia _criaTransferencia() {
    debugPrint("Criando tranferencia");
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);
    if (numeroConta != null && valor != null) {
      final Transferencia transferenciaCriada =
          Transferencia(valor, numeroConta);
      debugPrint("$transferenciaCriada");
      return transferenciaCriada;
    }
  }
}

class Editor extends StatelessWidget {
  final TextEditingController controlador;
  final String rotulo;
  final String dica;
  final IconData icone;

  Editor({this.controlador, this.rotulo, this.dica, this.icone});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: TextField(
          style: TextStyle(fontSize: 24.0),
          decoration: InputDecoration(
            icon: icone != null ? Icon(icone) : null,
            labelText: rotulo,
            hintText: dica,
          ),
          keyboardType: TextInputType.number,
          controller: controlador,
        ),
      );
}

class ListaTransferencias extends StatelessWidget {
  final List<Transferencia> _transferencias = List();

  @override
  Widget build(BuildContext context) {
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    _transferencias.add(Transferencia(100.0, 1000));
    return Scaffold(
      appBar: AppBar(title: Text("Transferencias")),
      body: ListView.builder(
        itemCount: _transferencias.length,
        itemBuilder: (context, indice) {
          final transferencia = _transferencias[indice];
          return ItemTransferencia(transferencia);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          final Future<Transferencia> future = Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormularioTransferencia(),
            ),
          );
          future.then((transferenciaRecebida) {
            debugPrint("Chegou no then do future");
            debugPrint("$transferenciaRecebida");
            _transferencias.add(transferenciaRecebida);
          });
        },
      ),
    );
  }
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
