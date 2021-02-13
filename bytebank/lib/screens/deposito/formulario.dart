import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = "Receber Deposito";
const _rotuloCampoValor = "Valor";
const _dicaCampoValor = "0.00";
const _textoBotaoConfirmar = "Confirmar";

class FormularioDeposito extends StatelessWidget {
  final TextEditingController _controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(_tituloAppBar)),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Editor(
                controlador: _controladorCampoValor,
                rotulo: _rotuloCampoValor,
                dica: _dicaCampoValor,
                icone: Icons.monetization_on,
              ),
              RaisedButton(
                child: Text(_textoBotaoConfirmar),
                onPressed: () {
                  _criaDeposito(context);
                },
              ),
            ],
          ),
        ),
      );

  void _criaDeposito(context) {
    final double valor = double.tryParse(_controladorCampoValor.text);
    if (_validaDeposito(valor)) {
      _atualizaEstado(context, valor);
      Navigator.pop(context);
    }
  }

  bool _validaDeposito(valor) => valor != null;

  void _atualizaEstado(context, valor) {
    Provider.of<Saldo>(context, listen: false).adiciona(valor);
  }
}
