import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meuapp/utils/Configuracoes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LancamentoItemAPI {
  static Future<String> postLancamento(Map lista_lancamento_item) async {

    Uri url = Configuracoes.urlLancamentoItem;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var bodyMateriais = jsonEncode(lista_lancamento_item);
    var response = await http.post(url, headers: headers, body: bodyMateriais);
    var v_status_code = response.statusCode;

    var dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 201) {
      return dadosRetorno.toString();
    } else {
      return "NOK";
    }
  }

  static Future<Map<int,Map>> getLancamentos(int id, String datetime) async {

    Uri url = Uri.parse('${Configuracoes.urlLancamentoItemGet}$id');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var response = await http.get(url, headers: headers);
    var v_status_code = response.statusCode;

    var dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    Map<int,Map> teste={};
    int i = 0;
    for (var item in dadosRetorno){
        teste[i] = {
          'id_lancamento_item' : item['LancamentoItemModel']['id_lancamento_item'],
          'nome': item['MaterialModel']['nome'],
          'quantidade':item['LancamentoItemModel']['quantidade'],
          'un_medida':item['MaterialModel']['un_medida'],
          'data_lancamento':datetime,
          'id_material':item['LancamentoItemModel']['id_material']
        };
        i++;
    }

    if (v_status_code == 200) {
      return teste;
    } else {
      return {0 : {"STATUS" : "NOK"}};
    }
  }

  static Future deleteLancamentosItens(int id_lancamento) async {

    Uri url = Uri.parse('${Configuracoes.urlLancamentoItemDeleteTodos}$id_lancamento');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    var headers = {
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    await http.delete(url, headers: headers);
  }
}
