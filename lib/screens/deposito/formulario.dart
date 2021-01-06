import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = "Receber depósito";
const _botaoConfirmar = "Confirmar";

class FormularioDeposito extends StatelessWidget {
  final TextEditingController controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_tituloAppBar),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Editor(
                  controlador: controladorCampoValor,
                  rotulo: 'Valor',
                  dica: '0.00',
                  icone: Icons.monetization_on),
              RaisedButton(
                child: Text(_botaoConfirmar),
                onPressed: () => _criaDeposito(context),
              )
            ],
          ),
        ));
  }

  _criaDeposito(BuildContext context) {
    final double valor = double.tryParse(controladorCampoValor.text);
    final depositoValido = _validaDeposito(valor);
    if (depositoValido) {
      _atualizaEstado(context, valor);
      Navigator.pop(context);
    }
  }

  _validaDeposito(valor) {
    final _campoPreenchido = valor != null;

    return _campoPreenchido;
  }

  _atualizaEstado(context, valor) {
    Provider.of<Saldo>(context, listen: false).adiciona(valor);
  }
}
