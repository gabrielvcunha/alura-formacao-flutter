import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = "Criando Transferencia";
const _rotuloCampoNumeroConta = "Numero da conta";
const _dicaCampoNumeroConta = "0000";
const _rotuloCampoValor = "Valor";
const _dicaCampoValor = "0,00";
const _textoBotaoConfirmar = "Confirmar";

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController _controladorCampoNumeroConta =
  TextEditingController();
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(_tituloAppBar)),
    body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Editor(
            controlador: _controladorCampoNumeroConta,
            rotulo: _rotuloCampoNumeroConta,
            dica: _dicaCampoNumeroConta,
          ),
          Editor(
            controlador: _controladorCampoValor,
            rotulo: _rotuloCampoValor,
            dica: _dicaCampoValor,
            icone: Icons.monetization_on,
          ),
          RaisedButton(
            child: Text(_textoBotaoConfirmar),
            onPressed: () {
              _criaTransferencia(context);
            },
          ),
        ],
      ),
    ),
  );

  Transferencia _criaTransferencia(context) {
    final int numeroConta = int.tryParse(_controladorCampoNumeroConta.text);
    final double valor = double.tryParse(_controladorCampoValor.text);

    if (_validaTransferencia(numeroConta, valor)) {
      final novaTransferencia = Transferencia(valor, numeroConta);
      _atualizaEstado(context, novaTransferencia, valor);
      Navigator.pop(context);
    }
    return null;
  }

  bool _validaTransferencia(numeroConta, valor) => numeroConta != null && valor != null;

  void _atualizaEstado(context, novaTransferencia, valor) {
    Provider.of<Transferencias>(context, listen: false).adiciona(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor);
  }
}