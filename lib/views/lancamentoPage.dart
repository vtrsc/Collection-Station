import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:meuapp/controllers/cadPessoaController.dart';
import 'package:meuapp/controllers/cadVeiculoController.dart';
import 'package:meuapp/models/cadPessoaModel.dart';
import 'package:meuapp/providers/autoCompleteAPI.dart';
import 'package:meuapp/providers/cadPessoaAPI.dart';
import 'package:meuapp/providers/lancamentoItemAPI.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/views/lancamentoMaterialPage.dart';
import 'package:meuapp/views/widgets/CardMaterial.dart';
import 'package:meuapp/views/widgets/radioGroupCadPessoa.dart';
import '../controllers/lancamentoController.dart';
import '../utils/Estilos.dart';

class LancamentoPage extends StatefulWidget {
  const LancamentoPage({
    Key? key,
    this.tituloLancamento,
    required this.idTipoLancamento,
    this.lancamentoFeito,
    required this.idUsuario,
    required this.idEstacao,
  }) : super(key: key);

  final String? tituloLancamento;
  final int idTipoLancamento;
  final Map? lancamentoFeito;
  final int idEstacao;
  final int idUsuario;

  @override
  _LancamentoPageState createState() => _LancamentoPageState();
}

Map<int, Map> listaMateriais = {};
Map<int, Map> listaVeiculos = {};

class _LancamentoPageState extends State<LancamentoPage> {
  // Controladoras de texto e selecao
  String? radioButtonTipoCadPessoaValue;

  final textFieldMaterialAutocompleteKey = GlobalKey();
  TextEditingController? textFielAutocompletePlacaController;
  TextEditingController? textFieldMaterialAutocompleteController;
  String? textFieldMaterialAutocompleteSelectedOption;
  String? textFielPlacasAutocompleteSelectedOption;
  final textfieldPlacasAutocompleteKey = GlobalKey();

  // chave para validar o Formulario
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    print(widget.lancamentoFeito);
    _materiais = [];
    listaMateriais = {};
    textFieldMaterialAutocompleteController = TextEditingController();
    textFielAutocompletePlacaController = TextEditingController();
    RadioGroupCadPessoa.instance.tipoCadPessoa = 'F';

    LancamentoController.instance.dsObservacaoController.clear();
    // *** Variaveis para endpoint lancamento
    LancamentoController.instance.idEstacaoController.text =
        widget.idEstacao.toString();
    LancamentoController.instance.idTipoLancamentoController.text =
        widget.idTipoLancamento.toString();
    LancamentoController.instance.idUsuarioController.text =
        widget.idUsuario.toString();
    LancamentoController.instance.idCadPessoaController.text =
        cadPessoaController.instance.idCadPessoaController.text;

    if (widget.lancamentoFeito != null) {
      getLancamentoItemData();
    }
    setState(() {});
    super.initState();
  }

  // *** Mais variaveis POST lancamento
  int? idCadPessoa;
  DateTime? dataLancamento;

  void getLancamentoItemData() async {
    LancamentoController.instance.idCadPessoaController.text =
        widget.lancamentoFeito!['id_cad_pessoa'].toString();

    CadPessoaModel? dadosCadPessoa = await cadPessoaAPI
        .consultaPessoaID(widget.lancamentoFeito!['id_cad_pessoa']);

    cadPessoaController.instance.cpf_cnpjController.text =
        dadosCadPessoa!.cpf_cnpj!;

    cadPessoaController.instance.nomeController.text = dadosCadPessoa.nome!;

    cadVeiculoController.instance.id_cad_veiculo =
        widget.lancamentoFeito!['id_cad_veiculo'];

    LancamentoController.instance.dsObservacaoController.text =
        (widget.lancamentoFeito!['ds_observacao'] == null)
            ? ''
            : widget.lancamentoFeito!['ds_observacao'];

    listaMateriais = await LancamentoItemAPI.getLancamentos(
        widget.lancamentoFeito!['id_lancamento'],
        widget.lancamentoFeito!['data_lancamento']);
    {
      showDialog(
        barrierColor: Estilos.preto,
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text('ATENÇÃO'),
          content: Text('Esta página pode alterar dados de lançamentos!'),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
            )
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    textFieldMaterialAutocompleteController?.dispose();

    super.dispose();
  }

  static List<Map<String, dynamic>> _materiais = <Map<String, dynamic>>[];
  static List<String> _materiaisNomes = [];

  List<Map<String, dynamic>> materialSelecionado = [];
  List<Map> lista_lancamento_item = [];

  CadPessoaModel? pessoa;
  int indexLista = 0;
  int indexListaVeiculos = 0;
  List<Map> lista_veiculos = [];
  List<Map<String, dynamic>> PlacaSelecionada = [];
/* função openObservationDialog() que exibe um diálogo de alerta personalizado na tela. 
O diálogo contém um título "Observação" e um campo de texto multilinha com a capacidade de digitar até 3 linhas de texto.*/
  Future openObservationDialog() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Observação"),
          content: TextField(
            keyboardType: TextInputType.multiline,
            minLines: 3,
            maxLines: 3,
            controller: LancamentoController.instance.dsObservacaoController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Observação',
            ),
          ),
          actions: [
            TextButton(
              child: Text("Salvar"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      );

  Future autoComplete() async {
    _materiais = [];
    _materiaisNomes = [];
    var response;
    switch (widget.idTipoLancamento) {
      case 1:
        response =
            await AutoCompleteAPI.autoComplete(widget.idEstacao, 1, 0, 0, 0);
        break;
      case 2:
        response =
            await AutoCompleteAPI.autoComplete(widget.idEstacao, 0, 1, 0, 0);
        break;
      case 3:
        response =
            await AutoCompleteAPI.autoComplete(widget.idEstacao, 0, 0, 1, 0);
        break;
    }
    for (var item in response) {
      _materiaisNomes.add(item['nome']);
      _materiais.add({
        'nome': item['nome'],
        'id_material': item['id_material'],
        "un_medida": item['un_medida']
      });
    }
  }

  bool isMaterialInLista(String material) {
    for (var item in listaMateriais.values) {
      if (item['nome'] == material) {
        return true;
      }
    }
    return false;
  }
  /*
    O método PostLancamentos() é uma função assíncrona que envia uma lista de materiais para o controlador de lançamentos.
    Ele itera através da lista de materiais, cria um objeto auxiliar com as informações do ID do material e a quantidade e adiciona esse objeto à lista de itens de lançamento.
    Em seguida, chama o método btnLancamento no controlador de lançamentos, passando a lista de itens de lançamento e o contexto atual.
     O uso do await garante que essa chamada é feita de forma assíncrona, evitando travar a interface do usuário enquanto os dados são enviados.
    */

  PostLancamentos() async {
    Map aux_material = {};
    for (Map material in listaMateriais.values.toList()) {
      aux_material = {
        "id_material": material['id_material'],
        "quantidade": material["quantidade"]
      };
      lista_lancamento_item.add(aux_material);
    }
    await LancamentoController.instance
        .btnLancamento(context, lista_lancamento_item);

    LancamentoController.instance.limparDados();
    cadPessoaController.instance.limpaDados();
  }

  // Recriacao dos lancamentos itens para fazer update do lancamento primeiro apagando os lancamento_item
  // e realizando um update no lancamento
  UpdateLancamentos() async {
    Map aux_material = {};
    print(listaMateriais);
    for (Map material in listaMateriais.values.toList()) {
      aux_material = {
        "id_material": material['id_material'],
        "quantidade": material["quantidade"]
      };
      lista_lancamento_item.add(aux_material);
    }
    await LancamentoController.instance.btnUpdateLancamento(context,
        widget.lancamentoFeito!['id_lancamento'], lista_lancamento_item);
    
    LancamentoController.instance.limparDados();
    cadPessoaController.instance.limpaDados();

    setState(() {});
  }

  DeleteLancamento() async {
    await LancamentoController.instance
        .btnDeleteLancamento(context, widget.lancamentoFeito!['id_lancamento']);
    
    LancamentoController.instance.limparDados();
    cadPessoaController.instance.limpaDados();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            if (listaMateriais.isEmpty) {
              Navigator.pop(context);
            } else {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Confirmação"),
                  content: Text(
                      "Deseja descartar esse lançamento? Caso descarte as alterações serão perdidas."),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Manter"),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        cadVeiculoController.instance.limparDados();
                      },
                      child: Text("Descartar"),
                    ),
                  ],
                ),
              );
            }
          },
          color: Estilos.preto,
        ),
        actions: [],
        centerTitle: false,
        elevation: 4,
      ),
      backgroundColor: Estilos.branco,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(16 * fem, 26 * fem, 0 * fem, 6 * fem),
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
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 20, 0),
                child: Container(
                  height: 70,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'CPF/CNPJ: ' +
                                  cadPessoaController
                                      .instance.cpf_cnpjController.text,
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3846153846 * ffem / fem,
                                color: Estilos.preto,
                              ),
                            ),
                            Text(
                              'Nome: ' +
                                  cadPessoaController
                                      .instance.nomeController.text,
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3846153846 * ffem / fem,
                                color: Estilos.preto,
                              ),
                            ),
                            Text(
                              'Veículo: ${cadVeiculoController.instance.placa_veiculo.text}  ${cadVeiculoController.instance.prefixo_caminhao.text}',
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3846153846 * ffem / fem,
                                color: Estilos.preto,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: IconButton(
                            iconSize: 30,
                            icon: const Icon(Icons.note_alt),
                            onPressed: () {
                              openObservationDialog();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Materiais',
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3846153846 * ffem / fem,
                          color: Estilos.azulClaro,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Autocomplete<String>(
                          initialValue: TextEditingValue(),
                          optionsBuilder:
                              (TextEditingValue textEditingValue) async {
                            if (textEditingValue.text.length == 0) {
                              await autoComplete();
                              setState(() {});
                              return _materiaisNomes.where((String option) {
                                return option.contains(
                                    textEditingValue.text.toUpperCase());
                              });
                            } else {
                              setState(() {});
                              return _materiaisNomes.where((String option) {
                                return option.contains(
                                    textEditingValue.text.toUpperCase());
                              });
                            }
                          },
                          onSelected: (String selection) async {
                            setState(() =>
                                textFieldMaterialAutocompleteSelectedOption =
                                    selection);
                            var material = _materiais.where(
                              (element) {
                                return element['nome'].contains(selection);
                              },
                            );
                            if (isMaterialInLista(selection)) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  title: Text("Material já adicionado"),
                                  content: Text(
                                      "O material $selection já foi adicionado.\n\nClique no material na lista embaixo para alterar o valor ou excluir"),
                                  actions: [
                                    TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text("Ok"))
                                  ],
                                ),
                              );
                            } else {
                              listaMateriais = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LancamentoMaterialPage(
                                            dadosMaterial: material.first,
                                            lista: listaMateriais,
                                          )));
                              print(listaMateriais);
                              setState(() {
                                listaMateriais;
                                FocusScope.of(context).unfocus();
                                textFieldMaterialAutocompleteSelectedOption =
                                    '';
                              });
                            }
                            textFieldMaterialAutocompleteController!.text =
                                ''; // limpa o campo autocomplete
                          },
                          fieldViewBuilder: (
                            context,
                            textEditingController,
                            focusNode,
                            onEditingComplete,
                          ) {
                            textFieldMaterialAutocompleteController =
                                textEditingController;
                            return TextFormField(
                              key: textFieldMaterialAutocompleteKey,
                              controller: textEditingController,
                              focusNode: focusNode,
                              onEditingComplete: onEditingComplete,
                              onChanged: (_) => EasyDebounce.debounce(
                                'textFieldMaterialAutocompleteController',
                                Duration(milliseconds: 2000),
                                () => setState(() {}),
                              ),
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: 'Nome do material',
                                hintText: 'Informe mais de 3 caracteres',
                                border: OutlineInputBorder(),
                                filled: true,
                                fillColor: Estilos.branco,
                                contentPadding:
                                    EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                              ),
                              style: SafeGoogleFont(
                                'Roboto',
                                fontSize: 13 * ffem,
                                fontWeight: FontWeight.w400,
                                height: 1.3846153846 * ffem / fem,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 15, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        'Lista de Materiais',
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 13 * ffem,
                          fontWeight: FontWeight.w400,
                          height: 1.3846153846 * ffem / fem,
                          color: Estilos.azulClaro,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Flexible permite usar a ListView corretamente
              Flexible(
                child: Column(children: [
                  if (listaMateriais.isEmpty) Container(),
                  for (var index in listaMateriais.keys)
                    CardMaterial(
                      material: listaMateriais[index],
                      idEstacao: widget.idEstacao,
                      indexLista: index,
                      lista: listaMateriais,
                    )
                ]),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 60, 8, 20),
                child: Row(
                  children: [
                    Flexible(
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                elevation: 6,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 20, 10),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10 * fem),
                                ),
                                minimumSize: Size(double.infinity, 35 * fem),
                                backgroundColor: Estilos.azulClaro),
                            icon: LancamentoController.instance.isLoading
                                ? CircularProgressIndicator()
                                : Icon(Icons.upload),
                            label: Text(
                              LancamentoController.instance.isLoading
                                  ? 'Processando...'
                                  : (widget.lancamentoFeito != null
                                      ? 'Atualizar'
                                      : 'Lançar'),
                              style: TextStyle(
                                  color: Estilos.branco, fontSize: 25),
                            ),
                            onPressed: () {
                              try {
                                if (widget.lancamentoFeito == null) {
                                  PostLancamentos();
                                  _materiais = [];
                                  listaMateriais = {};
                                } else {
                                  showDialog(
                                    useRootNavigator: false,
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("ATENÇÃO"),
                                      content: Text(
                                          "Gostaria de manter as alterações feitas?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("Não")),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                            UpdateLancamentos();
                                            _materiais = [];
                                            listaMateriais = {};
                                          },
                                          child: Text("Sim"),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              } catch (e) {
                                // AlertDialog avisando que houve um erro.
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: Text('ATENÇÃO'),
                                    content: Text('Algo deu errado!'),
                                    actions: [
                                      TextButton(
                                        child: Text("Ok"),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      )
                                    ],
                                  ),
                                );
                              }
                            }),
                      ),
                    ),
                    if (widget.lancamentoFeito != null)
                      SizedBox(
                        width: 30,
                      ),
                    if (widget.lancamentoFeito != null)
                      Flexible(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10 * fem),
                                ),
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 20, 10),
                                minimumSize: Size(double.infinity, 35 * fem),
                                backgroundColor: Estilos.vermelho,
                              ),
                              icon: LancamentoController.instance.isLoading
                                  ? CircularProgressIndicator()
                                  : Icon(Icons.delete),
                              label: Text(
                                LancamentoController.instance.isLoading
                                    ? 'Processando...'
                                    : 'Deletar',
                                style: TextStyle(
                                    color: Estilos.branco, fontSize: 25),
                              ),
                              onPressed: () {
                                try {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("ATENÇÃO"),
                                      content: Text(
                                          "Gostaria de descartar este lançamento?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("Não")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              DeleteLancamento();
                                            },
                                            child: Text("Sim"))
                                      ],
                                    ),
                                  );
                                } catch (e) {
                                  // AlertDialog avisando que houve um erro.
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: Text('ATENÇÃO'),
                                      content: Text('Algo deu errado!'),
                                      actions: [
                                        TextButton(
                                          child: Text("Ok"),
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                              }),
                        ),
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
}
