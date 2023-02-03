// ignore_for_file: public_member_api_docs, sort_constructors_first, slash_for_doc_comments, avoid_print, unnecessary_getters_setters
import 'dart:convert';

CepCorreiosModel enderecoFromJson(String str) => CepCorreiosModel.fromJson(json.decode(str));

String enderecoToJson(CepCorreiosModel data) => json.encode(data.toJson());

/**
 * ID_ENDERECO	N	NUMBER	N			
 * CEP	N	VARCHAR2(11)	N			
 * NUMERO	N	VARCHAR2(10)	N			
 * COMPLEMENTO	N	VARCHAR2(50)	Y			
 * BAIRRO	N	VARCHAR2(50)	Y			
 * MUNICIPIO	N	VARCHAR2(50)	Y			
 * UF	N	VARCHAR2(50)	Y			
 */
class CepCorreiosModel {
   String? uf;
   String? localidade;
   String? logradouroDNEC;
   String? bairro;
   String? complemento;
   String? cep;
  CepCorreiosModel({
    this.uf,
    this.localidade,
    this.logradouroDNEC,
   this.complemento,
    this.bairro,
     this.cep,
      
    });


  factory CepCorreiosModel.fromJson(Map<String, dynamic> json) => CepCorreiosModel(
        uf: json["uf"],
        localidade: json["localidade"],
        logradouroDNEC: json["logradouro"],
        complemento: json["complemento"],
        bairro: json["bairro"],
        cep: json["cep"],
      );




  Map<String, dynamic> toJson() => {
        "uf": uf,
        "localidade": localidade,
        "logradouro": logradouroDNEC,
        "complemento": complemento,
        "bairro": bairro,
        "cep": cep,
      };


      Map<String, dynamic> toMap() {

        return {
          'uf': uf,
          'localidade': localidade,
          'logradouro': logradouroDNEC,
          'complemento': complemento,
          'bairro': bairro,
          'cep': cep,
        };
      }    
}
