import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:meuapp/controllers/cepController.dart';
import 'package:meuapp/controllers/lancamentoController.dart';
import 'package:meuapp/models/cadPessoaModel.dart';
import 'package:meuapp/models/enderecoModel.dart';
import 'package:meuapp/providers/cadPessoaAPI.dart';
import 'package:meuapp/providers/enderecoAPI.dart';
import 'package:meuapp/views/identificacaoVeiculo.dart';
import 'package:meuapp/views/lancamentoCadPessoaPage.dart';
import 'package:meuapp/views/lancamentoPage.dart';

import 'package:meuapp/views/widgets/radioGroupCadPessoa.dart';

/// Controlador para manipular dados de Cadastro Pessoa (Banco de Dados)
///
/// Principais atributos utilizados sao [idCadPessoaController] e [cpf_cnpjController] para identificacao
/// e passagem de parametros em widgets e métodos.
class cadPessoaController {
  static final cadPessoaController instance = cadPessoaController._();

  cadPessoaController._();
  TextEditingController idCadPessoaController = TextEditingController();
  TextEditingController id_enderecoController = TextEditingController();
  TextEditingController cpf_cnpjController = TextEditingController();
  TextEditingController nomeController = TextEditingController();
  TextEditingController numeroController = TextEditingController();
  TextEditingController complementoController = TextEditingController();
  TextEditingController telefoneController = TextEditingController();
  TextEditingController tipo_cadastroController = TextEditingController();
  TextEditingController IDController = TextEditingController();

  // Metodo para pequisar por ID

  limpaDados() {
    idCadPessoaController.text = '';
    id_enderecoController.text = '';
    cpf_cnpjController.text = '';
    nomeController.text = '';
    numeroController.text = '';
    complementoController.text = '';
    telefoneController.text = '';
    tipo_cadastroController.text = '';
    IDController.text = '';
  }

  Future<CadPessoaModel?> pesquisaID(context) async {
    CadPessoaModel? PesquisaID = CadPessoaModel();

    if (idCadPessoaController.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ATENÇÃO'),
          content: const Text('ID não encontrado'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  /// Metodo para pesquisar dados de pessoa pelo CPF ou CNPJ
  Future<CadPessoaModel?> pesquisaCPFCNPJ( 
      context,
      int idEstacao,
      int idTipoLancamento,
      int idUsuario,
      String complemento,
      String bairroEndereco,
      String numeroEndereco) async {
    CadPessoaModel? PesquisaCPF_CNPJ = CadPessoaModel();

    /// 1. Se o tamanho for menor que 11, é invalido111
    if (!UtilBrasilFields.isCNPJValido(cpf_cnpjController.text.trim()) &&
        !UtilBrasilFields.isCPFValido(cpf_cnpjController.text.trim()) == true) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('ATENÇÃO'),
                content: const Text('CPF ou CNPJ inválido'),
                actions: [
                  TextButton(
                    onPressed: () {
                      cpf_cnpjController.clear();

                      ///setar o foco no campo CPF
                      ///cpf_cnpjController.focusNode();
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              ));

      return null;
    }

    /// 2. Validar se o CPF é válido

    /// 4. Se o campo CPF/CNPJ estiver valido executa a pesquisa do provider cadPessoaAPI
    ///.replaceAll(new RegExp(r'[^0-9]'),'')
    PesquisaCPF_CNPJ = await cadPessoaAPI
        .consultaPessoaPorCPFCNPJ(cpf_cnpjController.text.trim());

    if (PesquisaCPF_CNPJ == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('ATENÇÃO'),
                content:
                    const Text('Pessoa Nao Cadastrada! Deseja Cadastrar ?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Não'),
                  ),
                  TextButton(
                    child: const Text("Sim"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LancamentoCadPessoaPage(
                                  idEstacao: idEstacao,
                                  idUsuario: idUsuario,
                                  complemento: complemento,
                                  bairroEndereco: bairroEndereco,
                                  numeroEndereco: numeroEndereco)));
                    },
                  )
                ],
              ));
    } else {
      idCadPessoaController.text = PesquisaCPF_CNPJ.id_cad_pessoa!.toString();
      nomeController.text = PesquisaCPF_CNPJ.nome!;
      cpf_cnpjController.text = PesquisaCPF_CNPJ.cpf_cnpj!;

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LancamentoPage(
                    idUsuario: idUsuario,
                    idEstacao: idEstacao,
                    idTipoLancamento: idTipoLancamento,
                  )));

      return PesquisaCPF_CNPJ;
    }
    return null;
  }

  Future getDadosCadPessoa(int idCadPessoa) async {
    try {
      CadPessoaModel? dadosPessoa =
          await cadPessoaAPI.consultaPessoaID(idCadPessoa);
      idCadPessoaController.text = dadosPessoa!.id_cad_pessoa.toString();
      id_enderecoController.text = dadosPessoa.id_endereco.toString();
      cpf_cnpjController.text = dadosPessoa.cpf_cnpj!;
      telefoneController.text = dadosPessoa.telefone.toString();
      nomeController.text = dadosPessoa.nome!;

      EnderecoModel? dadosEndereco =
          await enderecoAPI.consultarEndereco_byID(dadosPessoa.id_endereco!);
      cepController.instance.CepController.text = dadosEndereco!.cep!;
      cepController.instance.logradouroController.text =
          dadosEndereco.logradouro!;
      cepController.instance.CidadeController.text = dadosEndereco.municipio!;
      cepController.instance.ufController.text = dadosEndereco.uf!;
      cepController.instance.BairroController.text = dadosEndereco.bairro!;
      cepController.instance.numeroController.text = dadosEndereco.numero!;
      cepController.instance.complementoController.text =
          dadosEndereco.complemento!;
    } catch (e) {}
  }

  /// Função para atualizar o cadastro de uma pessoa juntamente com seu endereço
  void AtualizarCadPessoa(context) async {
    // ID_endereço para atualizar CadPessoa.
    String id_endereco_var = id_enderecoController.text;

    /// Primeiro verifica se o endereço inserido já existe para pegar o id, caso contrário criar.
    cepController cep = cepController.instance;
    int idEnderecoAtual = await enderecoAPI.consultarEndereco_byInfo(
        cep.CepController.text,
        cep.numeroController.text,
        cep.complementoController.text);

    if (cepController.instance.CepController.text == "" ||
        cepController.instance.numeroController.text == "" ||
        nomeController.text == "" ||
        cpf_cnpjController.text == "")
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('ATENÇAO'),
          content: const Text('Preencha todos os campos!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      );

    /// Caso todos os campos obrigatorios estejam preenchidos
    else {
      if (idEnderecoAtual.toString() == id_enderecoController.text) {
        // Reforça que pegue o id_endereco do endereço já criado.
        id_endereco_var = idEnderecoAtual.toString();

        enderecoAPI.atualizarEndereco(
            idEnderecoAtual.toString(),
            cep.CepController.text,
            cep.numeroController.text,
            cep.complementoController.text,
            cep.logradouroController.text,
            cep.BairroController.text,
            cep.CidadeController.text,
            cep.ufController.text);
      } else {
        var enderecoPost = await enderecoAPI.cadastrarEndereco(
            cep.CepController.text,
            cep.numeroController.text,
            cep.complementoController.text,
            cep.logradouroController.text,
            cep.BairroController.text,
            cep.CidadeController.text,
            cep.ufController.text);

        // Caso seja endereço novo pegar a instância criada.
        id_endereco_var = enderecoPost!.idEndereco.toString();
      }

      /// Atualiza o cadastro de CadPessoa (munícipe)
      cadPessoaAPI.atualizarCadPessoa(
        idCadPessoaController.text,
        id_endereco_var,
        cpf_cnpjController.text,
        nomeController.text,
        int.parse(telefoneController.text),
      );

      showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
                title: const Text('ATENÇÃO'),
                content: const Text('Infomações atualizadas com sucesso!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              ));
    }
  }

  /// Metodo para cadastrar pessoa e seu endereco no banco de dados
  void salvarPessoa(
      context,
      int idEstacao,
      int idUsuario,
      String complemento,
      String bairroEndereco,
      String numeroEndereco,
      String telefoneController) async {
    /// Verificacao se é pessoa fisica ou juridica

    if (cpf_cnpjController.text.length == 14) {
      RadioGroupCadPessoa.instance.tipoCadPessoa = 'F';
    } else if (cpf_cnpjController.text.length == 18) {
      RadioGroupCadPessoa.instance.tipoCadPessoa = "J";
    } else {
      throw Exception("Erro ao gravar o tipo de cadastro");
    }

    ///GRAVA O ENDEREÇO DA PESSOA
    EnderecoModel? objEnderecoCadastrado = await enderecoAPI.cadastrarEndereco(
      cepController.instance.CepController.text,
      cepController.instance.numeroController.text,
      cepController.instance.complementoController.text,
      cepController.instance.logradouroController.text,
      cepController.instance.BairroController.text,
      cepController.instance.CidadeController.text,
      cepController.instance.ufController.text,
    );

    if (objEnderecoCadastrado != null) {
      /// Cadastra pessoa

      CadPessoaModel? objPessoaCadastrada = await cadPessoaAPI.cadastrarPessoa(
          objEnderecoCadastrado.idEndereco.toString(),
          cpf_cnpjController.text,
          nomeController.text,
          RadioGroupCadPessoa.instance.tipoCadPessoa,
          int.parse(telefoneController)) as CadPessoaModel;

      /// Tratativa para verificar se a pessoa foi cadastrada com sucesso
      /// ignore: unnecessary_null_comparison
      if (objPessoaCadastrada == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Erro ao cadastrar Pessoa")));
      } else if (cepController.instance.CepController.text == "" ||
          cepController.instance.numeroController.text == "" ||
          nomeController.text == "" ||
          cpf_cnpjController.text == "") {
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
                  title: const Text('ATENÇAO'),
                  content: const Text(
                      'Campos obrigatórios: CEP, Número, Nome e CPF/CNPJ.'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                ));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('ATENÇÃO'),
            content: const Text('Pessoa cadastrada com sucesso!'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => IdentificacaoVeiculo(
                        idCadPessoa: objPessoaCadastrada.id_cad_pessoa!,
                        idUsuario: int.parse(LancamentoController
                            .instance.idUsuarioController.text),
                        idEstacao: int.parse(LancamentoController
                            .instance.idEstacaoController.text),
                        complemento:
                            cepController.instance.complementoController.text,
                        bairroEndereco:
                            cepController.instance.BairroController.text,
                        numeroEndereco:
                            cepController.instance.numeroController.text,
                        idTipoLancamento: int.parse(LancamentoController
                            .instance.idTipoLancamentoController.text),
                      ),
                    ),
                  );
                },
                child: const Text('Ok'),
              ),
            ],
          ),
        );
      }
    }
  }
}
