// ignore_for_file: library_private_types_in_public_api, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_import

import 'dart:ui';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuapp/controllers/cadPessoaController.dart';
import 'package:meuapp/controllers/cadVeiculoController.dart';
import 'package:meuapp/models/cadPessoaModel.dart';
import 'package:meuapp/providers/lancamentoAPI.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/views/identificacaoVeiculo.dart';
import 'package:meuapp/views/lancamentoPage.dart';
import 'package:meuapp/views/widgets/CartaoTopCadPessoas.dart';
import '../../controllers/lancamentoController.dart';
import '../../utils/Estilos.dart';

class preCadastro extends StatefulWidget {
  const preCadastro(
      {Key? key,
      this.tituloLancamento,
      required this.idTipoLancamento,
      this.lancamentoFeito,
      required this.idUsuario,
      required this.complemento,
      required this.bairroEndereco,
      required this.numeroEndereco,
      required this.idEstacao})
      : super(key: key);

  final String? tituloLancamento;
  final int? idTipoLancamento;
  final Map? lancamentoFeito;
  final int? idEstacao;
  final int? idUsuario;
  final String complemento;
  final String bairroEndereco;
  final String numeroEndereco;

  @override
  _preCadastroState createState() => _preCadastroState();
}

class _preCadastroState extends State<preCadastro> {
  // Controladoras de texto e selecao
  String? radioButtonTipoCadPessoaValue;
  final textFieldCpfCnpjKey = GlobalKey();
  final textFieldIDkey = GlobalKey();

  String? textFieldCpfCnpjSelectedOption;
  //final textFieldMaterialAutocompleteKey = GlobalKey();

  // chave para validar o Formulario
  final formKeyy = GlobalKey<FormState>();
  final scaffoldKeyy = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  // *** Mais variaveis POST lancamento
  int? idCadPessoa;
  DateTime? dataLancamento;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      key: scaffoldKeyy,
      appBar: AppBar(
        backgroundColor: Estilos.branco,
        shadowColor: Estilos.cinza,
        elevation: 4,
        actions: [],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Estilos.preto,
        ),
      ),
      backgroundColor: Estilos.branco,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // loginRB7 (I586:3101;0:70)
                    margin: EdgeInsets.fromLTRB(
                        16 * fem, 26 * fem, 0 * fem, 6 * fem),
                    child: Text(
                      'Identificação',
                      style: SafeGoogleFont(
                        'Comfortaa',
                        fontSize: 36 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.115 * ffem / fem,
                        letterSpacing: -0.54 * fem,
                        color: Estilos.preto,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 10, 30, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: TextFormField(
                                key: textFieldCpfCnpjKey,
                                controller: cadPessoaController
                                    .instance.cpf_cnpjController,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                  CpfOuCnpjFormatter()
                                ],
                                readOnly: LancamentoController
                                    .instance.switchAnonimoValue,
                                obscureText: false,
                                decoration: InputDecoration(
                                  labelText: 'CPF/CNPJ',
                                  hintText: 'Informe o CPF/CNPJ',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Estilos.branco,
                                  contentPadding:
                                      EdgeInsetsDirectional.fromSTEB(
                                          5, 5, 5, 5),
                                  suffixIcon: Align(
                                    widthFactor: 1.0,
                                    heightFactor: 1.0,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: (LancamentoController.instance
                                                    .switchAnonimoValue ==
                                                true)
                                            ? Estilos.cinza
                                            : Estilos.azulClaro,
                                      ),
                                      onPressed: () async {
                                        CadPessoaModel? pessoa =
                                            await cadPessoaController.instance
                                                .pesquisaCPFCNPJ(
                                                    context,
                                                    widget.idEstacao!,
                                                    widget.idTipoLancamento!,
                                                    widget.idUsuario!,
                                                    widget.complemento,
                                                    widget.bairroEndereco,
                                                    widget.numeroEndereco);

                                        pessoa!.id_cad_pessoa.toString();
                                        setState(() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      IdentificacaoVeiculo(
                                                        idCadPessoa: int.parse(
                                                            pessoa.id_cad_pessoa
                                                                .toString()),
                                                        idUsuario:
                                                            widget.idUsuario!,
                                                        idEstacao:
                                                            widget.idEstacao!,
                                                        complemento:
                                                            widget.complemento,
                                                        bairroEndereco: widget
                                                            .bairroEndereco,
                                                        numeroEndereco: widget
                                                            .numeroEndereco,
                                                        idTipoLancamento:
                                                            int.parse(widget
                                                                .idTipoLancamento
                                                                .toString()),
                                                      )));
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                                keyboardType: TextInputType.number,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Center(
                    child: Flexible(
                        child: FutureBuilder(
                      future: LancamentoAPI.getTop10(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Erro");
                        } else if (snapshot.hasData) {
                          List<Widget> listaTop = [];
                          for (var cad_pessoa in snapshot.data) {
                            listaTop.add(CartaoTopCadPessoa(
                                widget: widget, cad_pessoa: cad_pessoa));
                          }
                          return Column(children: listaTop);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                              child: TextButton(
                                onPressed: () {
                                  cadPessoaController
                                      .instance.cpf_cnpjController.text = '';
                                  cadPessoaController.instance.nomeController
                                      .text = 'Irregular';
                                  cadPessoaController.instance
                                      .idCadPessoaController.text = '0';
                                  cadVeiculoController.instance.limparDados();

                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LancamentoPage(
                                                idEstacao: widget.idEstacao!,
                                                idUsuario: widget.idUsuario!,
                                                idTipoLancamento:
                                                    widget.idTipoLancamento!,
                                              )));
                                },
                                child: Text('Lançamento Irregular'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
