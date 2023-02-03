import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meuapp/models/escalaUsuarioModel.dart';
import 'package:meuapp/models/usuarioModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/Configuracoes.dart';

/**
 * Classe para recuperar os dados do usuário.
 */
class UsuarioAPI 
{

  /**
   * Método para recuperar os dados do Usuário Zelador. Cria o objeto UsuarioModel.
   */
  static Future<UsuarioModel?> recuperarUsuario() async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    String? loginUsuario = prefs.getString('loginUsuario');

    Uri url = Uri.parse(Configuracoes.urlApiRecuperarUsuario + loginUsuario.toString());
    UsuarioModel ?objUsuario;

    var headersEnvio = 
    {
      'Content-Type': 'application/json; charset=UTF-8'
      ,'Accept': 'application/json'
      ,HttpHeaders.authorizationHeader: 'Bearer ' + accessToken.toString()
    };

    var response = await http.get(url, headers: headersEnvio);

    if (response.statusCode == 200)
    {
      objUsuario = usuarioFromJson(Utf8Codec().decode(response.bodyBytes));
    }
    
    return objUsuario;
  }

  /**
   * Método para recuperar os dados de Escala e Estação que estão vinculados ao Usuário Zelador. Cria o objeto EscalaUsuarioModel.
   */
  static Future<List<EscalaUsuarioModel>?> recuperarDadosVinculadosUsuario() async 
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken     = prefs.getString('accessToken');
    String? loginUsuario    = prefs.getString('loginUsuario');
    Uri url                 = Uri.parse( Configuracoes.urlApiRecuperarDadosUsuario + loginUsuario.toString());
    List<EscalaUsuarioModel>? listDadosUsuario;

    var headersEnvio = 
    {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + accessToken.toString(),
    };

    var response = await http.get(url, headers: headersEnvio);
    
    if (response.statusCode == 200)
    {
      listDadosUsuario = parseEscalaUsuario(Utf8Codec().decode(response.bodyBytes));
    }
    
    return listDadosUsuario;
  }

}
