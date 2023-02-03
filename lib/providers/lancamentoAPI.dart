// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages, unused_local_variable
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meuapp/controllers/cadVeiculoController.dart';
import 'package:meuapp/utils/Configuracoes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class LancamentoAPI {
  static Future<Map> postLancamento(

      String id_cad_pessoa,
      String id_usuario,
      String id_estacao,
      String tipoLancamento,
      String data_lancamento,
      String ds_observacao,
      List<Map> lista_lancamento_item) async {
    
    Uri url = Configuracoes.urlLancamento;
    Map dadosMateriais = {
      "id_cad_pessoa": int.parse(id_cad_pessoa),
      "id_cad_veiculo": cadVeiculoController.instance.id_cad_veiculo,
      "id_usuario": int.parse(id_usuario),
      "id_estacao": int.parse(id_estacao),
      "tipo_lancamento": int.parse(tipoLancamento),
      "data_lancamento": DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(DateTime.now()), // formato UTC para mandar na API
      "ds_observacao": ds_observacao,
      "lista_lancamento_item": lista_lancamento_item
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var bodyMateriais = jsonEncode(dadosMateriais);
    var response = await http.post(url, headers: headers, body: bodyMateriais);
    var v_status_code = response.statusCode;

    var dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 201) {
      return dadosRetorno;
    } else {
      return {"status": "NOK"};
    }
  }

  static Future<Map> putLancamento(int id_lancamento,
      String id_cad_pessoa,
      String id_usuario,
      String id_estacao,
      String tipoLancamento,
      String data_lancamento,
      String ds_observacao,
      List<Map> lista_lancamento_item
      ) async {

    Map dadosMateriais = {
      "id_cad_pessoa": int.parse(id_cad_pessoa),
      "id_cad_veiculo": cadVeiculoController.instance.id_cad_veiculo,
      "id_usuario": int.parse(id_usuario),
      "id_estacao": int.parse(id_estacao),
      "tipo_lancamento": int.parse(tipoLancamento),
      "data_lancamento": (DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS").format(DateTime.now())), // formato UTC para mandar na API
      "ds_observacao": ds_observacao,
      "lista_lancamento_item" : lista_lancamento_item
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    Uri url = Uri.parse('${Configuracoes.urlLancamento}$id_lancamento');

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var bodyMateriais = jsonEncode(dadosMateriais);
    var response = await http.put(url, headers: headers, body: bodyMateriais);
    var v_status_code = response.statusCode;

    var dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 202) {
      return dadosRetorno;
    } else {
      return {"status": "NOK"};
    }
  }

  static Future<void> deleteLancamento(int id_lancamento) async{

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    Uri url = Uri.parse('${Configuracoes.urlLancamento}$id_lancamento');

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var response = await http.delete(url, headers: headers);

  }

  static Future<List> lancamentosUsuarioEstacao(
      int idUsuario, int idEstacao) async {
    Uri url = Uri.parse(Configuracoes.urlGetLancamentosUsuarioEstacao +
        "$idUsuario/$idEstacao");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var response = await http.get(url, headers: headers);
    var dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return dadosRetorno;
    } else {
      return [];
    }
  }

  static Future<List> getTop10() async{
    Uri url = Configuracoes.urlTop10Utilizadores;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var response = await http.get(url, headers: headers);
    var dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return dadosRetorno;
    } else {
      return [];
    }    
  }
}
