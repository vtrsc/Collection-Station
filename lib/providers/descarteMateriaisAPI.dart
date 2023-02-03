import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meuapp/utils/Configuracoes.dart';

class descartesMateriaisAPI {
  static Future<String> descarte(String id_estacao , String id_material) async {

    Uri url_descarte   = Configuracoes.urlApiRecuperarToken;
    Map dadosDescarte  = {"id_estacao" : id_estacao , "id_material": id_material};
    var response      =  await http.post(url_descarte, body: dadosDescarte);
    var v_status_code = response.statusCode;


      var headers = 
    {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${response.body}'
    };
     var DadosRetornoAutenticacao = jsonDecode(Utf8Codec().decode(response.bodyBytes));

      if (v_status_code == 200) 
    {
    
      return DadosRetornoAutenticacao['access_token'].toString();
    } 
    else 
    {
      return "NOK";
    }




  }
}