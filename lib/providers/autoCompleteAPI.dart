import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:meuapp/utils/Configuracoes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AutoCompleteAPI {
  static Future<dynamic> autoCompletePrefixo(
    int id_cad_pessoa,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('accessToken');

    Uri url = Uri.parse('${Configuracoes.urlCadVeiculo}$id_cad_pessoa');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });
    var v_status_code = response.statusCode;

    var listaMaterial = jsonDecode(response.body);

    if (v_status_code == 200) {
      return listaMaterial;
    } else {
      throw ('Erro ao buscar');
    }
  }

  static Future<dynamic> autoCompletePlaca(
    int id_cad_pessoa,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('accessToken');

    Uri url = Uri.parse('${Configuracoes.urlCadVeiculo}$id_cad_pessoa');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });
    var v_status_code = response.statusCode;

    var listaMaterial = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 200) {
      return listaMaterial;
    } else {
      throw ('Erro ao buscar');
    }
  }

  static Future<dynamic> autoComplete(int id_estacao, int is_descarte,
      int is_remocao, int is_doacao, int favorito) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('accessToken');
    String queryParameters =
        '?is_descarte=$is_descarte&is_remocao=$is_remocao&is_doacao=$is_doacao&favorito=$favorito';
    Uri url = Uri.parse(
        '${Configuracoes.urlApiAutoComplete}$id_estacao$queryParameters');
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });
    var v_status_code = response.statusCode;

    var listaMaterial = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 200) {
      return listaMaterial;
    } else {
      throw ('Erro ao buscar');
    }
  }
}
