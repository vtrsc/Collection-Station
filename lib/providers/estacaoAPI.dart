import 'dart:convert';
import 'dart:io';
import 'package:meuapp/models/estacaoModel.dart';
import 'package:meuapp/providers/LoginAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/Configuracoes.dart';
import 'package:http/http.dart' as http;

class estacaoAPi {

  static Future<EstacaoModel> get_estacao(int id_estacao) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String accessToken = '';

    await LoginAPI.login('vsalazar', 'prefeitura');
    accessToken = prefs.getString('accessToken').toString();

    Uri url = Uri.parse('${Configuracoes.urlApiGetEstacao}$id_estacao');
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${accessToken.toString()}',
    };
    var response = await http.get(url, headers: headers);
    var v_status_code = response.statusCode;

    var response_decoded = jsonDecode(Utf8Codec().decode(response.bodyBytes));
    if (v_status_code == 200) {
      return EstacaoModel.fromJson(response_decoded);
    } else {
      throw Exception('Falha ao buscar estação, status: $v_status_code');
    }
  }
}