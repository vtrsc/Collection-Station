import 'package:flutter/material.dart';
import 'package:meuapp/utils.dart';
import '../utils/Estilos.dart';

class LancamentoMaterialPage extends StatefulWidget {
  const LancamentoMaterialPage({
    Key? key,
    required this.dadosMaterial,
    required this.lista,
    this.indexLancamento,
  }) : super(key: key);

  final Map dadosMaterial;
  final Map<int, Map> lista;
  final int? indexLancamento;
  // final bool isLancado;

  @override
  _LancamentoMaterialWidgetState createState() =>
      _LancamentoMaterialWidgetState();
}

class _LancamentoMaterialWidgetState extends State<LancamentoMaterialPage> {
  TextEditingController? textFieldMaterialNomeController;
  TextEditingController? textFieldMaterialQuantidadeController;
  TextEditingController? textFieldMaterialUnidadeMedidaController;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey_quantidade = GlobalKey<FormState>();
  int quantidade = 0;

  @override
  void initState() {
    super.initState();
    quantidade = (widget.indexLancamento != null
        ? widget.lista[widget.indexLancamento]!['quantidade']
        : 0);
    textFieldMaterialNomeController = TextEditingController();
    textFieldMaterialQuantidadeController =
        TextEditingController(text: quantidade.toString());

    textFieldMaterialUnidadeMedidaController = TextEditingController();
  }

  @override
  void dispose() {
    textFieldMaterialNomeController?.dispose();
    textFieldMaterialQuantidadeController?.dispose();
    textFieldMaterialUnidadeMedidaController?.dispose();
    super.dispose();
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Estilos.preto,
        ),
        elevation: 4,
      ),
      backgroundColor: Estilos.branco,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(16 * fem, 26 * fem, 0 * fem, 6 * fem),
                  child: Text(
                    'Cadastro de Material',
                    style: SafeGoogleFont(
                      'Comfortaa',
                      fontSize: 30 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.115 * ffem / fem,
                      letterSpacing: -0.54 * fem,
                      color: Estilos.preto,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Estilos.branco,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                  color: Estilos.azulClaro,
                                  width: 0.5,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    5, 10, 5, 10),
                                child: Text(
                                  "Material: ${widget.dadosMaterial['nome']}",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                FloatingActionButton(
                                    backgroundColor: Estilos.azulClaro,
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w100),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        if (int.parse(
                                                textFieldMaterialQuantidadeController!
                                                    .text) >
                                            0) {
                                          quantidade--;
                                          textFieldMaterialQuantidadeController!
                                              .text = quantidade.toString();
                                        }
                                      });
                                    }),
                                Flexible(
                                  child: Center(
                                    child: Container(
                                      height: 50.0,
                                      child: TextField(
                                        controller:
                                            textFieldMaterialQuantidadeController,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 30,
                                        ),
                                        onChanged: (value) {
                                          quantidade = int.parse(value);
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                                FloatingActionButton(
                                    backgroundColor: Estilos.azulClaro,
                                    child: Icon(Icons.add),
                                    onPressed: () {
                                      setState(() {
                                        quantidade++;
                                        textFieldMaterialQuantidadeController!
                                            .text = quantidade.toString();
                                      });
                                    })
                              ],
                            )),
                      ),
                      SizedBox(
                        width: 10 * fem,
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFE2DEDE),
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Estilos.azulClaro,
                                width: 0.5,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
                              child: Text(
                                "${widget.dadosMaterial['un_medida'].toString()}",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 60, 8, 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Align(
                            alignment: AlignmentDirectional(0, 0),
                            child: ElevatedButton(
                              onPressed: () async {
                                // Caso novo registro de lancamento_item
                                if (widget.indexLancamento == null) {
                                  int i = (widget.lista.isNotEmpty)
                                      ? widget.lista.keys.last + 1
                                      : 0;
                                  widget.lista[i] = {
                                    'nome': widget.dadosMaterial['nome'],
                                    "quantidade": quantidade,
                                    'un_medida':
                                        widget.dadosMaterial['un_medida'],
                                    'data_lancamento':
                                        '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                    'id_material':
                                        widget.dadosMaterial['id_material'],
                                  };
                                  Navigator.pop(context, widget.lista);
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                  });
                                }
                                // Caso registro de lancamento_item já exista (update)
                                else {
                                  widget.lista[widget.indexLancamento!] = {
                                    'id_lancamento_item': widget
                                        .dadosMaterial['id_lancamento_item'],
                                    'nome': widget.dadosMaterial['nome'],
                                    "quantidade": quantidade,
                                    'un_medida':
                                        widget.dadosMaterial['un_medida'],
                                    'data_lancamento':
                                        widget.dadosMaterial['data_lancamento'],
                                    'id_material':
                                        widget.dadosMaterial['id_material'],
                                  };
                                  Navigator.pop(context, widget.lista);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 6,
                                backgroundColor: Estilos.azulClaro,
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    20, 10, 20, 10),
                                minimumSize: Size(double.infinity, 35 * fem),
                                textStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10 * fem),
                                ),
                              ),
                              child: Text(
                                (widget.indexLancamento != null
                                    ? 'Atualizar'
                                    : 'Cadastrar'),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        if(widget.indexLancamento != null)
                        SizedBox(width: 30,),
                        widget.indexLancamento != null
                            ?  Flexible(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await showDialog<bool>(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertDialog(
                                        title: const Text('Excluir lançamento'),
                                        content: Text(
                                            'Deseja exlcuir esse lançamento de material: ${widget.dadosMaterial['nome']} - ${quantidade} ${widget.dadosMaterial['un_medida']} ?'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              widget.lista.remove(
                                                  widget.indexLancamento);
                                              Navigator.pop(
                                                  context, widget.lista);
                                              setState(() {});
                                            },
                                            child: const Text('Confirmar'),
                                          ),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context, false),
                                            child: const Text('Cancelar'),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Estilos.vermelho,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 10, 20, 10),
                                    minimumSize:
                                        Size(double.infinity, 35 * fem),
                                    textStyle: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10 * fem),
                                    ),
                                  ),
                                  child: const Text(
                                    'Excluir',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                            // Container vazio caso seja um material novo a ser lançado
                            : Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
