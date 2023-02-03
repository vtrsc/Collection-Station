import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meuapp/utils/Configuracoes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI 
{
  static Future<String> login(String username, String password) async 
  {
    Uri url           = Configuracoes.urlApiRecuperarToken;
    Map dadosLogin    = {"username": username, "password": password};
    var response      = await http.post(url, body: dadosLogin);
    var v_status_code = response.statusCode;

    var DadosRetornoAutenticacao = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 200) 
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('loginUsuario', username);
      prefs.setString('senhaUsuario', password);
      prefs.setString('accessToken', DadosRetornoAutenticacao['access_token'].toString());
      prefs.setBool('isLoggedIn', true);
      prefs.setString('dtaUltimoLogin', DateTime.now().toString());

      return DadosRetornoAutenticacao['access_token'].toString();
    } 
    else 
    {
      return "NOK";
    }
  }
}
