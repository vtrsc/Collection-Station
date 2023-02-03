import 'package:meuapp/controllers/cadPessoaController.dart';
import 'package:meuapp/controllers/cepController.dart';
import 'package:meuapp/models/enderecoModel.dart';
import 'package:meuapp/models/estacaoModel.dart';
import 'package:meuapp/providers/estacaoAPI.dart';
import 'package:meuapp/utils.dart';

import 'package:meuapp/views/homeEstacaoPage.dart';
import 'package:meuapp/views/ultimosLancamentos.dart';

import 'package:meuapp/views/widgets/CartaoLancamento.dart';
import '../utils/Estilos.dart';
import 'package:flutter/material.dart';

class LancamentosEstacaoPage extends StatefulWidget {
  const LancamentosEstacaoPage(
      {Key? key,
      required this.idEstacao,
      required this.idUsuario,
      required this.complemento, //Logradouro
      required this.bairroEndereco,
      required this.numeroEndereco})
      : super(key: key);

  final int idEstacao;
  final int idUsuario;
  final String complemento;
  final String numeroEndereco;
  final String bairroEndereco;

  @override
  _LancamentoEstacaoWidgetState createState() =>
      _LancamentoEstacaoWidgetState();
}

class _LancamentoEstacaoWidgetState extends State<LancamentosEstacaoPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  // Lista de lançamentos feitos
  EnderecoModel? endereco;
  String salvaDadosCadastroCPF =
      cadPessoaController.instance.cpf_cnpjController.text;
  String salvaDadosCadastroNome =
      cadPessoaController.instance.nomeController.text;
  String salvarDadosTelefone =
      cadPessoaController.instance.telefoneController.text;
  String salvarCEP = cepController.instance.CepController.text;
  String salvaNumero = cepController.instance.numeroController.text;
  String salvarComplemento = cepController.instance.complementoController.text;
  String salvarlogradouro = cepController.instance.logradouroController.text;
  String salvarBairro = cepController.instance.BairroController.text;
  String salvarCidade = cepController.instance.CidadeController.text;
  String salvarUF = cepController.instance.ufController.text;

  // Função para pegar lançamentos feitos e cada lançamento tem a seguinte estrutura

  // {id_lancamento: int,
  //  id_cad_pessoa: int,
  //  id_usuario: int,
  //  id_estacao: int,
  //  tipo_lancamento: int,
  //  data_lancamento: String {yyyy-MM-dd},
  //  ds_observacao: String}

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Estilos.branco,
        shadowColor: Estilos.cinza,
        automaticallyImplyLeading: false,
        title: Text(
          "Lançamentos",
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: Estilos.branco,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              onPressed: () {
                salvaDadosCadastroCPF =
                    cadPessoaController.instance.cpf_cnpjController.text;
                cadPessoaController.instance.cpf_cnpjController.clear();

                salvaDadosCadastroNome =
                    cadPessoaController.instance.nomeController.text;
                cadPessoaController.instance.nomeController.clear();

                salvarDadosTelefone =
                    cadPessoaController.instance.telefoneController.text;
                cadPessoaController.instance.telefoneController.clear();

                salvarCEP = cepController.instance.CepController.text;
                cepController.instance.CepController.clear();

                salvaNumero = cepController.instance.numeroController.text;
                cepController.instance.numeroController.clear();

                salvarlogradouro =
                    cepController.instance.logradouroController.text;
                cepController.instance.logradouroController.clear();

                salvarBairro = cepController.instance.BairroController.text;
                cepController.instance.BairroController.clear();

                salvarCidade = cepController.instance.CidadeController.text;
                cepController.instance.CidadeController.clear();

                salvarUF = cepController.instance.ufController.text;
                cepController.instance.ufController.clear();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomeEstacaoPage()),
                    (r) => false);
              },
              icon: Icon(
                Icons.home,
                color: Estilos.preto,
                size: 30,
              ),
              iconSize: 30,
            ),
          ),
        ],
        centerTitle: false,
        elevation: 4,
      ),
      backgroundColor: Estilos.branco,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: FutureBuilder(
              future: estacaoAPi.get_estacao(widget.idEstacao),
              builder: (context, AsyncSnapshot<EstacaoModel> snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.zero,
                        primary: false,
                        scrollDirection: Axis.vertical,
                        children: [
                          Container(
                            // group48095537J1w (408:5283)
                            margin: EdgeInsets.fromLTRB(
                                0 * fem, 20 * fem, 1 * fem, 14 * fem),
                            width: 212 * fem,
                            height: 201.06 * fem,
                            child: Image.asset(
                              'assets/mobile/images/group-48095537.png',
                              width: 212 * fem,
                              height: 201.06 * fem,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                20, 15, 20, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  snapshot.data!.nome!,
                                  style: SafeGoogleFont(
                                    'Comfortaa',
                                    fontSize: 36 * ffem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.115 * ffem / fem,
                                    letterSpacing: -0.54 * fem,
                                    color: Estilos.preto,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                            child: Text(
                              snapshot.data!.horario!,
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3846153846 * ffem / fem,
                                color: Estilos.preto,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 10, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0, 0, 10, 0),
                                  child: Text(
                                    '${widget.complemento}, ${widget.numeroEndereco} - ${widget.bairroEndereco}',
                                    style: SafeGoogleFont(
                                      'Roboto',
                                      fontSize: 13 * ffem,
                                      fontWeight: FontWeight.w400,
                                      height: 1.3846153846 * ffem / fem,
                                      color: Estilos.preto,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.map,
                                  color: Estilos.azulClaro,
                                  size: 24,
                                ),
                              ],
                            ),
                          ),
                          CartaoLancamento(
                            idTipoLancamento: 1,
                            dados: widget,
                          ),
                          CartaoLancamento(
                            idTipoLancamento: 2,
                            dados: widget,
                          ),
                          CartaoLancamento(
                            idTipoLancamento: 3,
                            dados: widget,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: TextButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          UltimosLancamentosPage(
                                              idEstacao: widget.idEstacao,
                                              idUsuario: widget.idUsuario)))),
                              child: Text(
                                "Consultar últimos lançamentos",
                                style: SafeGoogleFont(
                                  'Roboto',
                                  fontSize: 14 * ffem,
                                  fontWeight: FontWeight.w900,
                                  height: 1.1725 * ffem / fem,
                                  letterSpacing: 0.52 * fem,
                                  decoration: TextDecoration.underline,
                                  color: Estilos.azulClaro,
                                  decorationColor: Estilos.azulClaro,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ),
      ),
    );
  }
}
