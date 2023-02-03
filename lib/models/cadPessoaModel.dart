// ignore_for_file: public_member_api_docs, sort_constructors_first, slash_for_doc_comments, unnecessary_getters_setters, avoid_print, file_names
import 'dart:convert';

CadPessoaModel cadPessoaFromJson(String str) => CadPessoaModel.fromJson(json.decode(str));

String cadPessoaToJson(CadPessoaModel data) => json.encode(data.toJson());

/**
  Tabela onde será cadastrado o Municipe que está descantanto ou removendo material das estações. 
  ID_MUNICIPE INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  ENDERECO_ID_ENDERECO INTEGER UNSIGNED NOT NULL,
  CPF VARCHAR UNSIGNED NULL,
  NOME_MUNICIPE VARCHAR NULL,
  CNPJ VARCHAR UNSIGNED NULL,
  NOME_EMPRESA VARCHAR NULL,
  PLACA_VEICULO VARCHAR NULL,
  PREFIXO_CAMINHAO VARCHAR NULL,	
 */
class CadPessoaModel {
  
  int? id_cad_pessoa;
  int? id_endereco;
  
  String? cpf_cnpj;
 
  String? nome;
  String? placa_veiculo;
  String? prefixo_caminhao;
  String? tpo_cadastro;
  int? telefone;

  CadPessoaModel({
    this.id_cad_pessoa,
    this.id_endereco,
    this.cpf_cnpj,
    this.nome,
    this.placa_veiculo,
    this.prefixo_caminhao,
    this.tpo_cadastro,
    this.telefone,
  });
  

  factory CadPessoaModel.fromJson(Map<String, dynamic> parsedJson) 
  {
    return CadPessoaModel
    (
      id_cad_pessoa: parsedJson['id_cad_pessoa'],
      id_endereco: parsedJson['id_endereco'],
      cpf_cnpj: parsedJson['cpf_cnpj'],
      nome: parsedJson['nome'],
      tpo_cadastro: parsedJson['tpo_cadastro'],
      telefone: parsedJson['telefone'],
    );
    
  }

  Map<String, dynamic> toJson() => {
        "id_cad_pessoa": id_cad_pessoa,
        "id_endereco": id_endereco,
        "cpf_cnpj": cpf_cnpj,
        "nome": nome,
        "tpo_cadastro": tpo_cadastro,
        "telefone": telefone,
      };  
  

  Map<String, dynamic> toMap() 
  {
    Map<String, dynamic> map = 
    {
      'id_cad_pessoa': id_cad_pessoa,
      'id_endereco': id_endereco,
      'cpf_cnpj': cpf_cnpj,
      'nome': nome,
      'tpo_cadastro': tpo_cadastro,
      'telefone': telefone,
    
    };
    return map;
  }
}
