// ignore_for_file: file_names, library_private_types_in_public_api, prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, slash_for_doc_comments, must_be_immutable, unused_import

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meuapp/controllers/loginController.dart';
import 'package:meuapp/models/areaModel.dart';
import 'package:meuapp/models/escalaUsuarioModel.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/menuBar.dart';
import 'package:meuapp/views/widgets/CardEstacao.dart';
import '../providers/usuarioAPI.dart';
import '../utils/Configuracoes.dart';

/// Classe responsável por listar as ESTAÇÕES utilizada pelo ZELADOR.
class HomeEstacaoPage extends StatefulWidget {
  HomeEstacaoPage({Key? key}) : super(key: key);

  @override
  _HomeEstacaoWidgetState createState() => _HomeEstacaoWidgetState();
}

class _HomeEstacaoWidgetState extends State<HomeEstacaoPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
        actions: [
          MenuBarAppEC(iconeIndice: 2, label: 'Perfil')
        ],
      ),
      backgroundColor: Estilos.branco,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            // loginqTX (I407:4730;0:70)
            margin: EdgeInsets.fromLTRB(16 * fem, 26 * fem, 0 * fem, 6 * fem),
            child: Text(
              'Local',
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
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 5),
            /// Recuperar os dados do usuario para construir a tela
            child: FutureBuilder(
              future: UsuarioAPI.recuperarDadosVinculadosUsuario(),
              builder: (context, AsyncSnapshot snapshot) {
                List<Widget> aux = [];

                if (snapshot.hasData) {
                  /// Caso tenha dados vinculados ao usuario itera a lista de estacoes e cria os cartoes
                  List<EscalaUsuarioModel> lista = snapshot.data;
                  for (var element in lista) {
                    aux.add(
                      CardEstacao(
                        info: element,
                        idUsuario: element.idFuncionario,
                      ),
                    );
                  }
                  return Column(children: aux);
                } else if (snapshot.hasError) {
                  /// Retorna um erro caso tenha problemas com a requisicao
                  return Center(
                      child: Text(
                    "ERRO",
                    style: TextStyle(fontSize: 30),
                  ));
                } else {
                  /// tela de carregamento enquanto nao carrega os dados
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
