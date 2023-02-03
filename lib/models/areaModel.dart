// ignore_for_file: public_member_api_docs, sort_constructors_first, slash_for_doc_comments, unnecessary_this, avoid_print, file_names
import 'dart:convert';

AreaModel areaFromJson(String str) => AreaModel.fromJson(json.decode(str));

String areaToJson(AreaModel data) => json.encode(data.toJson());

/**
 * ID_AREA	N	NUMBER	N			
 * NOME	N	VARCHAR2(200)	N			
 */
class AreaModel 
{
  String? idArea;
  String? nome;

  AreaModel({ this.idArea, this.nome });

  void testeAreaModel() 
  {
    String jsonString = jsonEncode(AreaModel);
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    var areaModel = AreaModel.fromJson(userMap);

    print('ID da Area: ${areaModel.idArea.toString()}.');
    print('Nome da Area: ${areaModel.nome.toString()}.');
  }

  factory AreaModel.fromJson(Map<String, dynamic> parsedJson) {
    return AreaModel
    (
      idArea: parsedJson['ID_AREA'], 
      nome: parsedJson['NOME']
    );
  }
  
  // AreaModel.fromJson(Map<String, dynamic> json) : _idArea = json['ID_AREA'], _nome = json['NOME'];

  Map<String, dynamic> toJson() => 
  {
    'ID_AREA': this.idArea,
    'NOME': this.nome,
  };

  Map<String, dynamic> toMap() 
  {
    Map<String, dynamic> map = 
    {
      "ID_AREA": idArea,
      "NOME": nome,
    };
    return map;
  }

  @override
  String toString() => 'AreaModel(_idArea: $idArea, _nome: $nome)';
}
