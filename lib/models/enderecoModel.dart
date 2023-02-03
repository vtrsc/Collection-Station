// ignore_for_file: public_member_api_docs, sort_constructors_first, slash_for_doc_comments, avoid_print, unnecessary_getters_setters
import 'dart:convert';

EnderecoModel enderecoFromJson(String str) => EnderecoModel.fromJson(json.decode(str));

String enderecoToJson(EnderecoModel data) => json.encode(data.toJson());

/**
 * ID_ENDERECO	N	NUMBER	N			
 * CEP	N	VARCHAR2(11)	N			
 * NUMERO	N	VARCHAR2(10)	N			
 * COMPLEMENTO	N	VARCHAR2(50)	Y			
 * BAIRRO	N	VARCHAR2(50)	Y			
 * MUNICIPIO	N	VARCHAR2(50)	Y			
 * UF	N	VARCHAR2(50)	Y			
 */
class EnderecoModel {
  int? idEndereco;
   String? cep;
   String? numero;
   String? complemento;
   String? logradouro;
   String? bairro;
   String? municipio;
   String? uf;

  EnderecoModel({
    this.idEndereco,
    this.cep,
    this.numero,
    this.complemento,
    this.logradouro,
    this.bairro,
     this.municipio,
      this.uf
    });

  factory EnderecoModel.fromJson(Map<String, dynamic> json) => EnderecoModel(
        idEndereco: json["ID_ENDERECO"],
        cep: json["CEP"],
        numero: json["NUMERO"],
        complemento: json["COMPLEMENTO"],
        logradouro: json["LOGRADOURO"],
        bairro: json["BAIRRO"],
        municipio: json["MUNICIPIO"],
        uf: json["UF"],
      );

 
  Map<String, dynamic> toJson() => {
        "ID_ENDERECO": idEndereco,
        "CEP": cep,
        "NUMERO": numero,
        "COMPLEMENTO": complemento,
        "LOGRADOURO": logradouro,
        "BAIRRO": bairro,
        "MUNICIPIO": municipio,
        "UF": uf,
      };

  // AreaModel.fromJson(Map<String, dynamic> json) : _idArea = json['ID_AREA'], _nome = json['NOME'];

 
  
  Map<String, dynamic> toMap() 
  {
    Map<String, dynamic> map = 
    {
      'ID_ENDERECO': idEndereco,
      'CEP': cep,
      'NUMERO': numero,
      'COMPLEMENTO': complemento,
      'LOGRADOURO': logradouro,
      'BAIRRO': bairro,
      'MUNICIPIO': municipio,
      'UF': uf
    };
    return map;
  }

}
