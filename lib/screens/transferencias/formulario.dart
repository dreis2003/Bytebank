import 'package:bytebank/components/editor.dart';
import 'package:bytebank/models/saldo.dart';
import 'package:bytebank/models/transferencia.dart';
import 'package:bytebank/models/transferencias.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const _tituloAppBar = "Criando Transferência";
const _rotuloCampoNumeroConta = "Número da conta";
const _botaoConfirmar = "Confirmar";

class FormularioTransferencia extends StatelessWidget {
  final TextEditingController controladorCampoNumeroConta =
      TextEditingController();

  final TextEditingController controladorCampoValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_tituloAppBar)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Editor(
                controlador: controladorCampoNumeroConta,
                rotulo: _rotuloCampoNumeroConta,
                dica: '0000'),
            Editor(
                controlador: controladorCampoValor,
                rotulo: 'Valor',
                dica: '0.00',
                icone: Icons.monetization_on),
            RaisedButton(
              child: Text(_botaoConfirmar),
              onPressed: () => _criaTransferencia(context),
            )
          ],
        ),
      ),
    );
  }

  void _criaTransferencia(BuildContext context) {
    final int numeroConta = int.tryParse(controladorCampoNumeroConta.text);
    final double valor = double.tryParse(controladorCampoValor.text);
    final _transferenciaValida =
        _validaTransferencia(context, numeroConta, valor);

    if (_transferenciaValida) {
      final novaTransferencia = Transferencia(valor, numeroConta);
      _atualizaEstado(context, novaTransferencia, valor);
      Navigator.pop(context);
    }
  }

  _validaTransferencia(context, numeroConta, valor) {
    final _camposPreenchidos = numeroConta != null && valor != null;

    final _saldoSuficiente =
        valor <= Provider.of<Saldo>(context, listen: false).valor;

    return _camposPreenchidos && _saldoSuficiente;
  }

  _atualizaEstado(context, novaTransferencia, valor) {
    Provider.of<Transferencias>(context, listen: false)
        .adiciona(novaTransferencia);
    Provider.of<Saldo>(context, listen: false).subtrai(valor);
  }
}
