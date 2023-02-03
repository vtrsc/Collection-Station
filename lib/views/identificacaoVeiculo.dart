// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:meuapp/controllers/cadPessoaController.dart';
import 'package:meuapp/providers/autoCompleteAPI.dart';
import 'package:meuapp/providers/cadPessoaVeiculoAPI.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/addVeiculosPage.dart';
import 'package:meuapp/views/lancamentoPage.dart';
import 'package:meuapp/views/widgets/cartaoInfoMunicipe.dart';
import 'package:meuapp/controllers/cadVeiculoController.dart';

class IdentificacaoVeiculo extends StatefulWidget {
  IdentificacaoVeiculo(
      {super.key,
      required this.idCadPessoa,
      required this.idUsuario,
      required this.idEstacao,
      required this.complemento,
      required this.bairroEndereco,
      required this.numeroEndereco,
      required this.idTipoLancamento});

  final int idCadPessoa;
  final int idUsuario;
  final int idEstacao;
  final String complemento;
  final String bairroEndereco;
  final String numeroEndereco;
  final int idTipoLancamento;

  @override
  State<IdentificacaoVeiculo> createState() => _IdentificacaoVeiculoState();
}

Map<int, Map> listaVeiculos = {};
Map<int, Map> listaPrefixo = {};

class _IdentificacaoVeiculoState extends State<IdentificacaoVeiculo> {
  int indexLista = 0;
  int indexListaVeiculos = 0;

  List<Map> lista_veiculos = [];

  static List<Map<String, dynamic>> _placas = <Map<String, dynamic>>[];
  static List<String> _nomesPlacas = [];

  static List<Map<String, dynamic>> _prefixos = <Map<String, dynamic>>[];
  static List<String> _nomesPrefixos = [];

  Future autoCompletePrefixo(String pesquisaPrefixo) async {
    _prefixos = [];
    _nomesPrefixos = [];
    var responsePrefixo = null;

    responsePrefixo = await AutoCompleteAPI.autoCompletePrefixo(
        int.parse(cadPessoaController.instance.idCadPessoaController.text));

    for (var item in responsePrefixo) {
      _nomesPrefixos.add(item['prefixo_caminhao']);
    }
  }

  Future autocompletePlacas(String pesquisaPlacas) async {
    _placas = [];
    _nomesPlacas = [];
    var responsePlaca = null;

    responsePlaca = await AutoCompleteAPI.autoCompletePlaca(
        int.parse(cadPessoaController.instance.idCadPessoaController.text));

    for (var item in responsePlaca) {
      _nomesPlacas.add(item['placa_veiculo']);
    }
  }

  String? radioButtonTipoCadPessoaValue;

  final textFieldMaterialAutocompleteKey = GlobalKey();
  TextEditingController? textFieldMaterialAutocompleteController;
  String? textFieldMaterialAutocompleteSelectedOption;

  final textfieldPlacasAutocompleteKey = GlobalKey();
  String? textFielPlacasAutocompleteSelectedOption;
  TextEditingController? textFielAutocompletePlacaController;

  final textfieldPrefixoAutocompleteKey = GlobalKey();
  String? textFielPrefixoAutocompleteSelectedOption;
  TextEditingController? textFielAutocompletePrefixoController;

  // chave para validar o Formulario
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<List> listaPlacas;
  void getVeiculos() {
    listaPlacas = cadPessoaVeiculoAPI.getPlacas(widget.idCadPessoa);
  }

  @override
  void initState() {
    super.initState();
    getVeiculos();
  }

  String getString(variavel) {
    if (variavel == null) {
      return 'Sem placa';
    }
    return '$variavel';
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
        automaticallyImplyLeading: true,
        actions: [],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            cadVeiculoController.instance.limparDados();
            cadPessoaController.instance.limpaDados();
            Navigator.pop(context);
          },
          color: Estilos.preto,
        ),
        centerTitle: true,
        elevation: 4,
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
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        16 * fem, 26 * fem, 0 * fem, 14 * fem),
                    child: Text(
                      "Lançamento",
                      style: SafeGoogleFont(
                        'Comfortaa',
                        fontSize: 36 * ffem,
                        fontWeight: FontWeight.w400,
                        height: 1.115 * ffem / fem,
                        letterSpacing: -0.54 * fem,
                        color: Estilos.preto,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  CartaoInfosMunicipe(widget: widget),
                  Flexible(
                    child: FutureBuilder(
                      future: listaPlacas,
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Erro");
                        } else if (snapshot.hasData) {
                          List<Widget> listaTop = [];
                          for (var placa in snapshot.data) {
                            listaTop.add(
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(23, 20, 23, 0),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Estilos.branco,
                                    elevation: 6,
                                    shadowColor: Estilos.cinza,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10 * fem)),
                                  ),
                                  onPressed: () {
                                    cadVeiculoController
                                            .instance.id_cad_veiculo =
                                        placa['id_cad_pessoa_veic'];
                                    cadVeiculoController.instance.placa_veiculo
                                        .text = placa['placa_veiculo'] ==
                                            null
                                        ? ''
                                        : placa[
                                            'placa_veiculo']; //tratando valores nulos
                                    cadVeiculoController
                                            .instance.prefixo_caminhao.text =
                                        placa['prefixo_caminhao'] == null
                                            ? ''
                                            : placa['prefixo_caminhao'];
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LancamentoPage(
                                              idTipoLancamento:
                                                  widget.idTipoLancamento,
                                              idUsuario: widget.idUsuario,
                                              idEstacao: widget.idEstacao)),
                                    );
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: CircleAvatar(
                                          radius: 25 * fem,
                                          backgroundColor: Estilos.branco,
                                          child: Icon(
                                            Icons.directions_car,
                                            color: Estilos.azulClaro,
                                            size: 30 * fem,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              getString(placa['placa_veiculo']),
                                              style: SafeGoogleFont(
                                                'Roboto',
                                                fontSize: 12.3067655563 * ffem,
                                                fontWeight: FontWeight.w600,
                                                height: 1.1725 * ffem / fem,
                                                letterSpacing:
                                                    0.4922706223 * fem,
                                                color: Estilos.preto,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.delete,
                                                  color: Estilos.vermelho),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          AlertDialog(
                                                    title: Text('ATENÇÃO'),
                                                    content: Text(
                                                        'Deseja realmente excluir o veículo?'),
                                                    actions: [
                                                      TextButton(
                                                        child: Text("Não"),
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                          setState(() {});
                                                        },
                                                      ),
                                                      TextButton(
                                                        child: Text("Sim"),
                                                        onPressed: () async {
                                                          await cadVeiculoController
                                                              .instance
                                                              .btnDeleteVeiculo(
                                                                  context,
                                                                  placa[
                                                                      'id_cad_pessoa_veic']);
                                                          setState(() {
                                                            getVeiculos();
                                                          });
                                                        },
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          return Column(children: listaTop);
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => addVeiculosPage(
                                        idCadPessoa: widget.idCadPessoa,
                                        idEstacao: widget.idEstacao,
                                        idTipoLancamento:
                                            widget.idTipoLancamento,
                                        idUsuario: widget.idUsuario,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Estilos.azulClaro,
                            shadowColor: Estilos.cinza,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10 * fem),
                            ),
                            minimumSize: Size(double.infinity, 35 * fem)),
                        child: Text(
                          'Cadastre um novo veículo',
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.1725 * ffem / fem,
                            letterSpacing: 0.4922706223 * fem,
                            color: Estilos.branco,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10 * ffem,
                  ),
                  Flexible(
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                      child: ElevatedButton(
                        onPressed: () {
                          cadVeiculoController.instance.limparDados();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LancamentoPage(
                                idTipoLancamento: widget.idTipoLancamento,
                                idUsuario: widget.idUsuario,
                                idEstacao: widget.idEstacao,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Estilos.branco,
                            shadowColor: Estilos.cinzaClaro,
                            elevation: 6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10 * fem),
                            ),
                            minimumSize: Size(double.infinity, 35 * fem)),
                        child: Text(
                          'Sem veículo',
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 14 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.1725 * ffem / fem,
                            letterSpacing: 0.4922706223 * fem,
                            color: Estilos.preto,
                          ),
                        ),
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
