import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meuapp/controllers/cadPessoaController.dart';
import 'package:meuapp/controllers/cepController.dart';
import 'package:meuapp/utils.dart';
import '../utils/Estilos.dart';

class LancamentoCadPessoaPage extends StatefulWidget {
  const LancamentoCadPessoaPage({
    Key? key,
    required this.idEstacao,
    required this.idUsuario,
    this.idCadPessoa,
    required this.complemento, //Logradouro
    required this.bairroEndereco,
    required this.numeroEndereco,
  }) : super(key: key);

  final int idEstacao;
  final int idUsuario;
  final int? idCadPessoa;
  final String complemento;
  final String bairroEndereco;
  final String numeroEndereco;

  @override
  _LancamentoCadPessoaPageState createState() =>
      _LancamentoCadPessoaPageState();
}

class _LancamentoCadPessoaPageState extends State<LancamentoCadPessoaPage> {
  String? radioButtonTipoCadPessoaValue;
  final textFieldCadPessoaCpfCnpjKey = GlobalKey();
  TextEditingController? textFieldCadPessoaCpfCnpjController;
  String? textFieldCadPessoaCpfCnpjSelectedOption;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final formNomeKey = GlobalKey<FormState>();
 String? validaNome(String? texto) {
    if (texto!.isEmpty) {
      return "Digite a nome";
    }

    return null;
  }


  @override
  void initState() {
    if (widget.idCadPessoa != null) {
      setState(() {
        cadPessoaController.instance.getDadosCadPessoa(widget.idCadPessoa!);
      });
    }
    super.initState();
  }

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
        actions: [],
        centerTitle: false,
        elevation: 4,
      ),
      backgroundColor: Estilos.branco,
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.disabled,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(16 * fem, 26 * fem, 0 * fem, 6 * fem),
                  child: Text(
                    'Munícipe',
                    style: SafeGoogleFont(
                      'Comfortaa',
                      fontSize: 27 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.115 * ffem / fem,
                      letterSpacing: -0.54 * fem,
                      color: Estilos.preto,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextFormField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfOuCnpjFormatter(),
                        ],
                        key: textFieldCadPessoaCpfCnpjKey,
                        controller:
                            cadPessoaController.instance.cpf_cnpjController,
                        obscureText: false,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'CPF/CNPJ *',
                          hintText: 'Informe o CPF/CNPJ',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(
                            fontFamily: 'Poppins',
                            color: Estilos.preto,
                          ),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                        keyboardType: TextInputType.number,
                        maxLength: 15,
                      ))
                    ],
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
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: TextFormField(
                           validator: validaNome,
                           key: formNomeKey,
                            controller:
                                cadPessoaController.instance.nomeController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Nome Pessoa/Empresa *',
                              hintText: 'Informe o Nome da Pessoa/Empresa',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            keyboardType: TextInputType.text,
                            maxLength: 250,
                          ),
                        ),
                      ),
                    ],
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
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: TextFormField(
                            controller:
                                cadPessoaController.instance.telefoneController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Telefone',
                              hintText: 'Informe o Telefone',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: cepController.instance.CepController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'CEP *',
                              hintText: 'Informe o CEP',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Estilos.azulClaro),
                          icon: Icon(Icons.search),
                          label: Text(
                            '',
                            style:
                                TextStyle(color: Estilos.branco, fontSize: 25),
                          ),
                          onPressed: () {
                            cepController.instance.btnPesquisa(context);
                          }),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: TextFormField(
                            controller: cepController.instance.numeroController,
                            obscureText: false,
                            keyboardType: TextInputType.number,
                            maxLength: 5,
                            decoration: InputDecoration(
                              labelText: 'Número *',
                              hintText: 'Informe o número',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                          child: TextFormField(
                            controller:
                                cepController.instance.complementoController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Complemento',
                              hintText: 'Informe o complemento',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            maxLength: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                          child: TextFormField(
                            controller:
                                cepController.instance.logradouroController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Logradouro',
                              hintText: 'Informe o Logradouro',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            maxLength: 200,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: TextFormField(
                            controller: cepController.instance.BairroController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Bairro',
                              hintText: 'Bairro',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            maxLength: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: TextFormField(
                            controller: cepController.instance.CidadeController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Cidade',
                              hintText: 'Cidade',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            maxLength: 50,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 10, 0, 0),
                          child: TextFormField(
                            controller: cepController.instance.ufController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Estado',
                              hintText: 'Estado',
                              border: OutlineInputBorder(),
                            ),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                            ),
                            maxLength: 50,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Estilos.azulClaro),
                          icon: Icon(Icons.save),
                          label: Text(
                            widget.idCadPessoa == null ? 'Salvar' : 'Atualizar',
                            style:
                                TextStyle(color: Estilos.branco, fontSize: 25),
                          ),
                          onPressed: () {
                            if (widget.idCadPessoa == null) {
                              cadPessoaController.instance.salvarPessoa(
                                context,
                                widget.idEstacao,
                                widget.idUsuario,
                                widget.complemento,
                                widget.bairroEndereco,
                                widget.numeroEndereco,
                                cadPessoaController
                                    .instance.telefoneController.text,
                              );
                            } else {
                              cadPessoaController.instance
                                  .AtualizarCadPessoa(context);
                            }
                          }
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(20, 5, 20, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),

                            /* child: FFButtonWidget(
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    duration: Duration(milliseconds: 300),
                                    reverseDuration:
                                        Duration(milliseconds: 300),
                                    child: LancamentoPage(),
                                  ),
                                );
                              },
                              text: 'Incluir Pessoa',
                              options: FFButtonOptions(
                                color: Estilos.azulClaro,
                                textStyle: FlutterFlowTheme.of(context)
                                    .subtitle2
                                    .override(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 22,
                                    ),
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ), */
                          ),
                        ),
                      ),
                    ],
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
