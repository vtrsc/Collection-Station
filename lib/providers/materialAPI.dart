import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meuapp/models/materialModel.dart';
import 'package:meuapp/utils/Configuracoes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class materialAPI {
  static Future<String> material_post(
      String id_material,
      String nome,
      String descarte,
      String remocao,
      String volumoso,
      String prefixo_caminhao,
      String nome_responsalvel,
      String quantidade,
      String nome_empresa,
      String placa_veiculo,
      String endereco,
      String observacao,
      String cpf,
      String cnpj,
      String tefefone_gesseiro,
      String doacao,
      String medida) async {

    Uri url = Configuracoes.urlApiRecuperarToken;
    Map dadosMateriais = {
      "id_material": id_material,
      "nome ": nome,
      "descarte": descarte,
      "remocao": remocao,
      "volumoso": volumoso,
      "prefixo_caminhao": prefixo_caminhao,
      "nome_responsalvel": nome_responsalvel,
      "quantidade": quantidade,
      "nome_empresa": nome_empresa,
      "placa_veiculo": placa_veiculo,
      "endereco": endereco,
      "observacao": observacao,
      "cpf": cpf,
      "cnpj": cnpj,
      "tefefone_gesseiro": tefefone_gesseiro,
      "doacao": doacao,
      "medida": medida
    };
    
    var response = await http.post(url, body: dadosMateriais);
    var v_status_code = response.statusCode;

    var DadosRetornoAutenticacao = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString(
          'accessToken', DadosRetornoAutenticacao['access_token'].toString());
      prefs.setBool('isLoggedIn', true);
      prefs.setString('dtaUltimoLogin', DateTime.now().toString());

      return DadosRetornoAutenticacao['access_token'].toString();
    } else {
      return "NOK";
    }
  }

  static Future<List<MaterialModel>> material_pesquisa(String pesquisa) async {
    Uri url = Uri.parse('${Configuracoes.urlApiMaterial}$pesquisa');
    var response = await http.get(url);
    var v_status_code = response.statusCode;

    var DadosRetornoAutenticacao = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 200) {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString(
          'accessToken', DadosRetornoAutenticacao['access_token'].toString());
      prefs.setBool('isLoggedIn', true);
      prefs.setString('dtaUltimoLogin', DateTime.now().toString());

      return parseMateriais(response.body.toString());
    } else {
      throw Exception('return error');
    }
  }
}
