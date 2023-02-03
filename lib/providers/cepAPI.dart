import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:meuapp/models/cepCorreiosModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/Configuracoes.dart';

class cepAPI 
{

static Future<CepCorreiosModel?> buscaEndereco(String cep ) async 
{
    Uri url           = Configuracoes.urlCEP;
    CepCorreiosModel ?objEndereco;
    Map dadosMateriais = 
    {
      "pagina" : "/app/endereco/index.php",
      "endereco": cep,
       "tipoCEP" : "ALL"
    };

    var response       = await http.post(url, body: dadosMateriais);
    var v_status_code  = response.statusCode;

    if (v_status_code == 200) 
    {
      var RetornoInteiro = jsonDecode(Utf8Codec().decode(response.bodyBytes)); 
      List Dados = RetornoInteiro['dados'];
      
      objEndereco = CepCorreiosModel(uf: Dados[0]['uf'], 
                                     localidade: Dados[0]['localidade'], 
                                     logradouroDNEC: Dados[0]['logradouroDNEC'], 
                                     complemento : "",
                                     bairro: Dados[0]['bairro'], 
                                     cep: Dados[0]['cep']);
    } 

    return objEndereco;

  }


} 