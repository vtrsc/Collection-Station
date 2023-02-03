import 'package:flutter/material.dart';
import 'package:meuapp/models/cadVeiculoModel.dart';
import 'package:meuapp/providers/cadPessoaVeiculoAPI.dart';

class cadVeiculoController {
  static final cadVeiculoController instance = cadVeiculoController._();
  static final cadVeiculoModel lancamentoGlobal = cadVeiculoModel();

  cadVeiculoController._();

  int id_cad_veiculo = 0;
  TextEditingController placa_veiculo = TextEditingController();
  TextEditingController prefixo_caminhao = TextEditingController();
  TextEditingController marca = TextEditingController();
  TextEditingController modelo = TextEditingController();
  TextEditingController cor = TextEditingController();
  /* O método btnDeleteVeiculo é uma função assíncrona que remove um veículo específico da base de dados.*/

  void limparDados() {
    placa_veiculo.text = '';
    prefixo_caminhao.text = '';
    marca.text = '';
    modelo.text = '';
    cor.text = '';
  }

  btnDeleteVeiculo(context, int id_cad_pessoa_veiculo) async {
    await cadPessoaVeiculoAPI.deleteVeiculo(
      int.parse(id_cad_pessoa_veiculo.toString()),
    );

    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('ATENÇÃO'),
        content: Text('Deleção feita com sucesso!'),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  /// Função para disparar a API e adicionar placa
  btnAddPlaca(context, int id_cad_pessoa) async {
    await cadPessoaVeiculoAPI.cadVeiculoPost(
      int.parse(id_cad_pessoa.toString()),
      this.placa_veiculo.text,
      this.prefixo_caminhao.text,
    );
  }
}
