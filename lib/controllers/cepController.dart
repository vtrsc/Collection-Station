import 'package:flutter/material.dart';
import 'package:meuapp/models/cepCorreiosModel.dart';
import 'package:meuapp/providers/cepAPI.dart';

/// Controlador para consultar e recuperar dados de CEP
class cepController {
  static final cepController instance = cepController._();

  cepController._();
  TextEditingController CepController = TextEditingController();
  TextEditingController BairroController = TextEditingController();
  TextEditingController CidadeController = TextEditingController();
  TextEditingController ufController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController logradouroController = TextEditingController();

  // ERRO ESTÁ NA HORA DE CAREEGAR A LISTA NA HOMEESTACAOPAGE.DART.
  // OU SEJA, TEMOS A LISTA NA UsuarioAPI, MAS NÃO ESTAMOS CONSEGUINDO CARREGAR ELA NA TELA.
  // Future<List<DadosUsuarioModel>?> dadosUsuarioModel = LoginController._() as Future<List<DadosUsuarioModel>?>;

  bool isLoading = false;
  dynamic formKey = GlobalKey<FormState>();
  dynamic scaffoldKey = GlobalKey<ScaffoldState>();

  /* O método btnPesquisa é uma função assíncrona que busca informações de endereço através de um CEP específico*/
  btnPesquisa(context) async {
    CepCorreiosModel? buscaEnderecoModel =
        await cepAPI.buscaEndereco(CepController.text.trim());

    if (cepController.instance.CepController.text.length < 8) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('CEP Inválido')));
      buscaEnderecoModel!.cep = null;
      buscaEnderecoModel.logradouroDNEC = null;
      buscaEnderecoModel.bairro = null;
      buscaEnderecoModel.localidade = null;
      buscaEnderecoModel.uf = null;
    }

    /// Caso ache um CEP valido salva os valores
    if (buscaEnderecoModel != null) {
      CepController.text = buscaEnderecoModel.cep!;
      logradouroController.text = buscaEnderecoModel.logradouroDNEC!;
      BairroController.text = buscaEnderecoModel.bairro!;
      CidadeController.text = buscaEnderecoModel.localidade!;
      ufController.text = buscaEnderecoModel.uf!;
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('CEP não encontrado')));
    }
  }
}
