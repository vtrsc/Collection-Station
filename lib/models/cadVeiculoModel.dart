// ignore_for_file: public_member_api_docs, sort_constructors_first, slash_for_doc_comments, avoid_print, unnecessary_getters_setters
import 'dart:convert';

cadVeiculoModel enderecoFromJson(String str) =>
    cadVeiculoModel.fromJson(json.decode(str));

String enderecoToJson(cadVeiculoModel data) => json.encode(data.toJson());

/**
 * ID_ENDERECO	N	NUMBER	N			
 * CEP	N	VARCHAR2(11)	N			
 * NUMERO	N	VARCHAR2(10)	N			
 * COMPLEMENTO	N	VARCHAR2(50)	Y			
 * BAIRRO	N	VARCHAR2(50)	Y			
 * MUNICIPIO	N	VARCHAR2(50)	Y			
 * UF	N	VARCHAR2(50)	Y			
 */
class cadVeiculoModel {
  int? id_cad_pessoa_veic;
  int? id_cad_pessoa;
  String? placa_veiculo;
  String? prefixo_caminhao;
  String? marca;
  String? modelo;
  String? cor;

  cadVeiculoModel(
      {this.id_cad_pessoa_veic,
      this.id_cad_pessoa,
      this.placa_veiculo,
      this.prefixo_caminhao,
      this.cor,
      this.marca,
      this.modelo});

  factory cadVeiculoModel.fromJson(Map<String, dynamic> json) =>
      cadVeiculoModel(
        id_cad_pessoa_veic: json["id_cad_pessoa_veic"],
        id_cad_pessoa: json["id_cad_pessoa"],
        placa_veiculo: json["placa_veiculo"],
        prefixo_caminhao: json["prefixo_caminhao"],
        cor: json['cor'],
        marca: json['marca'],
        modelo: json['modelo']
      );

  Map<String, dynamic> toJson() => {
        "id_cad_pessoa_veic": id_cad_pessoa_veic,
        "id_cad_pessoa": id_cad_pessoa,
        "placa_veiculo": placa_veiculo,
        "prefixo_caminhao": prefixo_caminhao,
        "cor": cor,
        "marca": marca,
        "modelo": modelo
      };

  // AreaModel.fromJson(Map<String, dynamic> json) : _idArea = json['ID_AREA'], _nome = json['NOME'];

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id_cad_pessoa_veic': id_cad_pessoa_veic,
      'id_cad_pessoa': id_cad_pessoa,
      'placa_veiculo': placa_veiculo,
      'prefixo_caminhao': prefixo_caminhao,
      "cor": cor,
      "marca": marca,
      "modelo": modelo
    };
    return map;
  }
}
