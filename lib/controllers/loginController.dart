// ignore_for_file: prefer_const_constructors, unused_import, unused_element, no_leading_underscores_for_local_identifiers, unused_local_variable, slash_for_doc_comments, unnecessary_this, file_names
import 'package:flutter/material.dart';
import 'package:meuapp/models/escalaUsuarioModel.dart';
import 'package:meuapp/models/usuarioModel.dart';
import 'package:meuapp/providers/LoginAPI.dart';
import 'package:meuapp/providers/usuarioAPI.dart';
import 'package:meuapp/views/homeEstacaoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController 
{
  
  static final LoginController instance   = LoginController._();
  static final UsuarioModel usuarioGlobal = UsuarioModel();
  
  LoginController._();
  TextEditingController textFieldLoginEmailController = TextEditingController();
  TextEditingController textFieldLoginSenhaController = TextEditingController();

  // ERRO ESTÁ NA HORA DE CAREEGAR A LISTA NA HOMEESTACAOPAGE.DART.
  // OU SEJA, TEMOS A LISTA NA UsuarioAPI, MAS NÃO ESTAMOS CONSEGUINDO CARREGAR ELA NA TELA.
  // Future<List<DadosUsuarioModel>?> dadosUsuarioModel = LoginController._() as Future<List<DadosUsuarioModel>?>;
  
  bool isLoading      = false;
  dynamic formKey     = GlobalKey<FormState>();
  dynamic scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() 
  {
    textFieldLoginEmailController = TextEditingController();
    textFieldLoginSenhaController = TextEditingController();
  }

  /// Metodo para realizar login
  btnLogar(context) async 
  {   
    bool formOk = formKey.currentState!.validate();

    if (!formOk) 
    {
      return;
    }

    setState() 
    {
      isLoading = true;
    }
    
    final _formkey  = GlobalKey<FormState>();
    String login    = textFieldLoginEmailController.text.trim();
    String senha    = textFieldLoginSenhaController.text.trim();

    //Se os dados do formulario estiverem preenchidos entao verifica se o login é valido
    var accessToken = await LoginAPI.login(login, senha);

    //Login Valido - Guarda os dados de token e login no cache
    if (accessToken != "NOK") 
    {
      UsuarioModel? objUsuario = await UsuarioAPI.recuperarUsuario();

      /// Apos tentar recuperar o usuario, verifica se existe
      if (objUsuario != null)
      {
        /// Caso exista verifica o perfil do usuario
        if (objUsuario.tipoUsuario == "Z"){
          List<EscalaUsuarioModel>? dadosUsuarioModel = await UsuarioAPI.recuperarDadosVinculadosUsuario();
        }
        switch (objUsuario.tipoUsuario) 
        {
            case 'Z':
              Future<List<EscalaUsuarioModel>?> dadosUsuarioModel = UsuarioAPI.recuperarDadosVinculadosUsuario();
              Navigator.pushReplacementNamed(context, "/home-estacao");
              break;
            case 'F':
              Navigator.pushReplacementNamed(context, "/home-acoes");
              break;
            case 'E':
              Navigator.pushReplacementNamed(context, "/home-acoes");
              //Navigator.push(context, MaterialPageRoute(builder: (_) => HomeAcoesPage()));
              break;
            default:
              break;
        }
      }  
    } 
    /// Mensagem de erro quando login ou senha estao incorretos.
    else 
    {
      showDialog
      (
        context: context,
        builder: (BuildContext context) => AlertDialog
        (
          title: Text('ATENÇÃO'),
          content: Text('Senha ou Login Incorretos'),
          actions: 
          [
            TextButton
            (
              child: Text("Tentar Novamente"),
              onPressed: () => Navigator.of(context).pop(),
            )
          ],
        ),
      );

    }
  }
}