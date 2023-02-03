import 'dart:io';

import 'package:meuapp/models/cadVeiculoModel.dart';
import 'package:meuapp/utils/Configuracoes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class cadPessoaVeiculoAPI {
  //METODO PARA CONSULTAR UM ENDERECO POR ID (GET)

  static Future deleteVeiculo(
    int id_cad_pessoa_veiculo,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    Uri url =
        Uri.parse('${Configuracoes.urlDeleteVeiculo}${id_cad_pessoa_veiculo}');

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var response = await http.delete(url, headers: headers);
  }

  static Future cadVeiculoPost(
    int id_cad_pessoa,
    String placa_veiculo,
    String prefixo_caminhao,
  ) async {
    Uri url = Uri.parse(Configuracoes.urlAddVeiculo);

    Map dados = {
      "id_cad_pessoa": id_cad_pessoa,
      "placa_veiculo": placa_veiculo,
      "prefixo_caminhao": prefixo_caminhao,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var bodyMateriais = jsonEncode(dados);
    var response = await http.post(url, headers: headers, body: bodyMateriais);
  }

  static Future<cadVeiculoModel?> getPlaca(int id_cad_veiculo) async {
    Uri url = Uri.parse('${Configuracoes.urlCadVeiculo}${id_cad_veiculo}');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var response = await http.get(url, headers: headers);
    var dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return cadVeiculoModel(
        id_cad_pessoa_veic: dadosRetorno["id_cad_pessoa_veic"],
        id_cad_pessoa: dadosRetorno["id_cad_pessoa"],
        placa_veiculo: dadosRetorno["placa_veiculo"],
        prefixo_caminhao: dadosRetorno["prefixo_caminhao"],
        cor: dadosRetorno['cor'],
        marca: dadosRetorno['marca'],
        modelo: dadosRetorno['modelo'],
      );
    }
  }

  static Future<List> getPlacas(
    int id_cad_pessoa,
  ) async {
    Uri url = Uri.parse('${Configuracoes.urlCadVeiculoPessoa}${id_cad_pessoa}');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      HttpHeaders.authorizationHeader: 'Bearer ${token}'
    };

    var response = await http.get(url, headers: headers);
    List dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (response.statusCode == 200) {
      return dadosRetorno;
    } else {
      return [];
    }
  }
}
