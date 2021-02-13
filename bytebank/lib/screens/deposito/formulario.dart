import 'package:bytebank/components/editor.dart';
import 'package:flutter/material.dart';

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
                  Navigator.pop(context, _criaDeposito());
                },
              ),
            ],
          ),
        ),
      );

  void _criaDeposito() {

  }
}
