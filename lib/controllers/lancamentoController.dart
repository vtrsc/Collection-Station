import 'package:flutter/material.dart';
import 'package:meuapp/controllers/cadVeiculoController.dart';
import 'package:meuapp/models/lancamentoModel.dart';
import 'package:meuapp/providers/lancamentoAPI.dart';
import 'package:meuapp/providers/lancamentoItemAPI.dart';

/// Controlador para utilizar os dados de lancamento que sao salvos no banco de dados
class LancamentoController {
  static final LancamentoController instance = LancamentoController._();
  static final LancamentoModel lancamentoGlobal = LancamentoModel();

  LancamentoController._();

  TextEditingController idCadPessoaController = TextEditingController();
  TextEditingController id_cad_veicController = TextEditingController();
  TextEditingController idUsuarioController = TextEditingController();
  TextEditingController idEstacaoController = TextEditingController();
  TextEditingController idTipoLancamentoController = TextEditingController();
  TextEditingController dataLancamentoController = TextEditingController();
  TextEditingController placaController = TextEditingController();
  TextEditingController prexifoController = TextEditingController();

  bool switchAnonimoValue = false;

  TextEditingController dsObservacaoController = TextEditingController();
  bool isLoading = false;
  dynamic formKey = GlobalKey<FormState>();
  dynamic scaffoldKey = GlobalKey<ScaffoldState>();

  limparDados() {
    idCadPessoaController.text = '';
    id_cad_veicController.text = '';
    idUsuarioController.text = '';
    idEstacaoController.text = '';
    idTipoLancamentoController.text = '';
    dataLancamentoController.text = '';
    placaController.text = '';
    prexifoController.text = '';
  }

  void initState() {}

  btnAddPlaca(context, List<Map> listaVeiculos, id_cad_pessoa) async {}

  /// Metodo para salvar um lancamento
  btnLancamento(context, List<Map> lista_lancamento_item) async {
    if (dsObservacaoController.text.length > 200) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('O campo observação não pode ter mais de 200 caracteres'),
        backgroundColor: Colors.red,
      ));
    }

    /// Salva o lancamento
    await LancamentoAPI.postLancamento(
        idCadPessoaController.text,
        idUsuarioController.text,
        idEstacaoController.text,
        idTipoLancamentoController.text,
        dataLancamentoController.text,
        dsObservacaoController.text,
        lista_lancamento_item);
    {
      Navigator.popUntil(context, ModalRoute.withName("/menu-acoes"));
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('ATENÇÃO'),
          content: Text('Lançamento realizado com sucesso!'),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                cadVeiculoController.instance.id_cad_veiculo = 0;
                cadVeiculoController.instance.placa_veiculo.text = '';
                cadVeiculoController.instance.prefixo_caminhao.text = '';
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );
    }
  }

  /// Metodo para atualizar um lancamento
  btnUpdateLancamento(
      context, int id_lancamento, List<Map> lista_lancamento_item) async {
    if (switchAnonimoValue == true) {
      idCadPessoaController.text = '0';
    }
    if (dsObservacaoController.text.length > 200) {
      scaffoldKey.currentState.showSnackBar(SnackBar(
        content:
            Text('O  campo observação não pode ter mais de 200 caracteres'),
        backgroundColor: Colors.red,
      ));
    }

    /// verifica se o lancamento é anonimo
    if (switchAnonimoValue == true) {
      idCadPessoaController.text = '0';
    }

    /// deleta os lancamentos_item
    await LancamentoItemAPI.deleteLancamentosItens(id_lancamento);

    /// faz a atualizacao do lancamento com os lancamentos_item
    await LancamentoAPI.putLancamento(
        id_lancamento,
        idCadPessoaController.text,
        idUsuarioController.text,
        idEstacaoController.text,
        idTipoLancamentoController.text,
        dataLancamentoController.text,
        dsObservacaoController.text,
        lista_lancamento_item);
    {
      Navigator.popUntil(context, ModalRoute.withName("/menu-acoes"));
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('ATENÇÃO'),
          content: Text('Atualizacao feita com sucesso!'),
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
  }

  /// Metodo para deletar o lancamento
  btnDeleteLancamento(context, int id_lancamento) async {
    // Esses dois metodos apaga primeiro os Lancamentos de itens e depois o Lancamento em si

    await LancamentoItemAPI.deleteLancamentosItens(id_lancamento); //itens
    await LancamentoAPI.deleteLancamento(id_lancamento); //lancamento
    {
      Navigator.popUntil(context, ModalRoute.withName("/menu-acoes"));
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
  }
}
