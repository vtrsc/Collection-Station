import 'package:meuapp/models/enderecoModel.dart';
import 'package:meuapp/utils/Configuracoes.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class enderecoAPI {
  //METODO PARA CONSULTAR UM ENDERECO POR ID (GET)
  static Future<EnderecoModel?> consultarEndereco_byID(int idEndereco) async {
    EnderecoModel? objEndereco;
    //INSTANCIA O SHARED PREFERENCES
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //PEGA O TOKEN DO SHARED PREFERENCES
    var token = prefs.getString('accessToken');

    //URL DA API DE ENDEREÇO
    Uri url = Uri.parse('${Configuracoes.urlApiRecuperarEndereco}$idEndereco');

    //ENVIA A REQUISIÇÃO
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    //PEGA O STATUS CODE DA REQUISIÇÃO
    var v_status_code = response.statusCode;

    //CONVERTE O RETORNO DA REQUISICAO PARA OBJETO JSON
    var DadosRetornoAutenticacao = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    //SE O STATUS CODE FOR 200 QUER DIZER QUE DEU TUDO CERTO, RETORNA O MODEL DO ENDEREÇO
    if (v_status_code == 200) {
      objEndereco = EnderecoModel(
          idEndereco: DadosRetornoAutenticacao["id_endereco"],
          cep: DadosRetornoAutenticacao["cep"],
          numero: DadosRetornoAutenticacao["numero"],
          complemento: DadosRetornoAutenticacao["complemento"],
          logradouro: DadosRetornoAutenticacao["logradouro"],
          bairro: DadosRetornoAutenticacao["bairro"],
          municipio: DadosRetornoAutenticacao["municipio"],
          uf: DadosRetornoAutenticacao["uf"]);
      return objEndereco;
    } else {
      return null;
    }
  }

  static Future<int> consultarEndereco_byInfo(
      String cep, String numero, String complemento) async {
    //INSTANCIA O SHARED PREFERENCES
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //PEGA O TOKEN DO SHARED PREFERENCES
    var token = prefs.getString('accessToken');

    //URL DA API DE ENDEREÇO
    Uri url = Uri.parse(
        '${Configuracoes.urlApiRecuperarEndereco}$cep/$numero/$complemento');

    //ENVIA A REQUISIÇÃO
    var response = await http.get(url, headers: {
      "Content-Type": "application/json",
      'Authorization': 'Bearer $token',
    });

    int statusCode = response.statusCode;
    var responseBody = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (statusCode == 200) {
      EnderecoModel objEndereco = EnderecoModel(
          idEndereco: responseBody["id_endereco"],
          cep: responseBody["cep"],
          numero: responseBody["numero"],
          complemento: responseBody["complemento"],
          logradouro: responseBody["logradouro"],
          bairro: responseBody["bairro"],
          municipio: responseBody["municipio"],
          uf: responseBody["uf"]);
      return objEndereco.idEndereco!;
    }
    return -1;
  }

  static Future atualizarEndereco(
      String idEndereco,
      String cep,
      String numero,
      String complemento,
      String logradouro,
      String bairro,
      String municipio,
      String uf) async {
        
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    Uri url = Uri.parse('${Configuracoes.urlApiRecuperarEndereco}$idEndereco');
    Map body = {
      "cep": cep,
      "numero": numero,
      "complemento": complemento,
      "logradouro": logradouro,
      "bairro": bairro,
      "municipio": municipio,
      "uf": uf
    };

    var response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(body));

    int statusCode = response.statusCode;
    var dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (statusCode == 200) {
      return dadosRetorno.toString();
    }

    return null;
  }

  //MÉTODO PARA SALVAR UM ENDEREÇO (POST)
  static Future<EnderecoModel?> cadastrarEndereco(
      String cep,
      String numero,
      String complemento,
      String logradouro,
      String bairro,
      String municipio,
      String uf) async {
    EnderecoModel? objEndereco;
    //INSTANCIA O SHARED PREFERENCES
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //PEGA O TOKEN DO SHARED PREFERENCES
    var token = prefs.getString('accessToken');

    //URL DA API DE ENDEREÇO
    Uri url = Configuracoes.urlApiRecuperarEndereco;

    //DADOS DO ENDEREÇO A SER GRAVADO
    var DadosBody = {
      "cep": cep,
      "numero": numero,
      "complemento": complemento,
      "logradouro": logradouro,
      "bairro": bairro,
      "municipio": municipio,
      "uf": uf
    };

    //TRANSFORMA OS DADOS DO BODY EM OBJETO DO TIPO JSON
    var jsonDadosBody = jsonEncode(DadosBody);

    //ENVIA A REQUISIÇÃO
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: jsonDadosBody);

    //PEGA O STATUS CODE DA REQUISIÇÃO
    var v_status_code = response.statusCode;

    //CONVERTE O RETORNO DA REQUISICAO PARA OBJETO JSON
    var DadosRetornoAutenticacao = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    //SE O STATUS CODE FOR 201 QUER DIZER QUE DEU TUDO CERTO, FOI CRIADO O REGISTRO NO BANCO E RETORNA O MODEL DO ENDEREÇO
    if (v_status_code == 201) {
      objEndereco = EnderecoModel(
          idEndereco: DadosRetornoAutenticacao["id_endereco"],
          cep: DadosRetornoAutenticacao["cep"],
          numero: DadosRetornoAutenticacao["numero"],
          complemento: DadosRetornoAutenticacao["complemento"],
          logradouro: DadosRetornoAutenticacao["logradouro"],
          bairro: DadosRetornoAutenticacao["bairro"],
          municipio: DadosRetornoAutenticacao["municipio"],
          uf: DadosRetornoAutenticacao["uf"]);
      return objEndereco;
    } else {
      return null;
    }
  }
}
