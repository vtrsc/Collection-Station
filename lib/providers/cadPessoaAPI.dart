import 'package:meuapp/models/cadPessoaModel.dart';
import 'package:meuapp/utils/Configuracoes.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class cadPessoaAPI {
  static Future<CadPessoaModel?> consultaPessoaPorCPFCNPJ(
      String cpf_cnpj) async {
    CadPessoaModel? objConsultaPorCPFCNPJ;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('accessToken');
    Uri url = Uri.parse("${Configuracoes.urlPesquisaCpf_Cnpj}$cpf_cnpj");

    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    var response = await http.get(url, headers: headers);
    var v_status_code = response.statusCode;

    var DadosRetornoCPF_CNPJ = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 200) {
      objConsultaPorCPFCNPJ = CadPessoaModel.fromJson(DadosRetornoCPF_CNPJ);
    } else {
      objConsultaPorCPFCNPJ = null;
    }

    return objConsultaPorCPFCNPJ;
  }

  static Future<CadPessoaModel?> consultaPessoaID(int id) async {
    CadPessoaModel? objConsultaID;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var token = prefs.getString('accessToken');
    Uri url = Uri.parse("${Configuracoes.urlPesquisaID}$id");

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token'
    };

    var response = await http.get(url, headers: headers);
    var v_status_code = response.statusCode;

    var DadosRetornoCPF_CNPJ = jsonDecode(utf8.decode(response.bodyBytes));
    if (v_status_code == 200) {
      objConsultaID = CadPessoaModel(
          id_cad_pessoa: DadosRetornoCPF_CNPJ["id_cad_pessoa"],
          id_endereco: DadosRetornoCPF_CNPJ["id_endereco"],
          cpf_cnpj: DadosRetornoCPF_CNPJ["cpf_cnpj"],
          nome: DadosRetornoCPF_CNPJ["nome"],
          tpo_cadastro: DadosRetornoCPF_CNPJ["tpo_cadastro"],
          telefone: DadosRetornoCPF_CNPJ["telefone"]);
    }

    return objConsultaID;
  }

  static Future<CadPessoaModel?> cadastrarPessoa(String id_endereco,
      String cpf_cnpj, String nome, String tpo_cadastro, int telefone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('accessToken');
    CadPessoaModel? objCadastroPessoa;

    Uri url = Uri.parse(Configuracoes.CadPessoa);
    Map dadosMateriais = {
      'id_endereco': id_endereco,
      'cpf_cnpj': cpf_cnpj,
      'nome': nome,
      'tpo_cadastro': tpo_cadastro,
      'telefone': telefone
    };
    var bodyLmateriais = jsonEncode(dadosMateriais);

    //ENVIA A REQUISIÇÃO
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
        body: bodyLmateriais);

    var v_status_code = response.statusCode;

    var DadosRetornocadastrar = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (v_status_code == 201) {
      objCadastroPessoa = CadPessoaModel(
          id_cad_pessoa: DadosRetornocadastrar["id_cad_pessoa"],
          id_endereco: DadosRetornocadastrar["id_endereco"],
          cpf_cnpj: DadosRetornocadastrar["cpf_cnpj"],
          nome: DadosRetornocadastrar["nome"],
          tpo_cadastro: DadosRetornocadastrar["tpo_cadastro"],
          telefone: DadosRetornocadastrar["telefone"]);
    }
    return objCadastroPessoa;
  }

  static Future atualizarCadPessoa(String idCadPessoa, String id_endereco,
      String cpf_cnpj, String nome, int telefone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    Uri url = Uri.parse(Configuracoes.CadPessoa + idCadPessoa);
    Map body = {
      'id_endereco': id_endereco,
      'cpf_cnpj': cpf_cnpj,
      'nome': nome,
      'telefone': telefone
    };


    var response = await http.put(
      url,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body)
    );

    int statusCode = response.statusCode;
    var dadosRetorno = jsonDecode(Utf8Codec().decode(response.bodyBytes));

    if (statusCode == 200) {
      return dadosRetorno.toString();
    }

    return null;
  }
}
