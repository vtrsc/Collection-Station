// ignore_for_file: public_member_api_docs, sort_constructors_first, slash_for_doc_comments, unnecessary_getters_setters, avoid_print
import 'dart:convert';

EstacaoModel estacaoFromJson(String str) => EstacaoModel.fromJson(json.decode(str));

String estacaoToJson(EstacaoModel data) => json.encode(data.toJson());

// A function that converts a response body into a List<EstacaoModel>
List<EstacaoModel> parseEstacaoModel(String responseBody) {
  var tagObjsJson = jsonDecode(responseBody) as List;
  List<EstacaoModel> tagObjs = tagObjsJson.map((tagJson) => EstacaoModel.fromJson(tagJson)).toList();
  return tagObjs;
}

/**
 * ID_ESTACAO	N	NUMBER	N			
 * ID_ENDERECO	N	NUMBER	N			
 * ID_AREA	N	NUMBER	N			
 * NOME	N	VARCHAR2(200)	N			
 * HORARIO	N	VARCHAR2(200)	N			
 * LINK_MAPA	N	VARCHAR2(300)	Y			
 * OBSERVACAO	N	VARCHAR2(300)	Y			
 */
class EstacaoModel {
  int? idEstacao;
  int? idEndereco;
  int? idArea;
  String? nome;
  String? horario;
  String? linkMapa;
  String? observacao;

  EstacaoModel({
    this.idEstacao,
    this.idEndereco,
    this.idArea,
    this.nome,
    this.horario,
    this.linkMapa,
    this.observacao,
  });

  @override
  String toString() {
    return 'EstacaoModel(idEstacao: $idEstacao, idEndereco: $idEndereco, idArea: $idArea, nome: $nome, horario: $horario, linkMapa: $linkMapa, observacao: $observacao)';
  }

  @override
  bool operator ==(covariant EstacaoModel other) {
    if (identical(this, other)) return true;

    return other.idEstacao == idEstacao &&
        other.idEndereco == idEndereco &&
        other.idArea == idArea &&
        other.nome == nome &&
        other.horario == horario &&
        other.linkMapa == linkMapa &&
        other.observacao == observacao;
  }

  @override
  int get hashCode {
    return idEstacao.hashCode ^
        idEndereco.hashCode ^
        idArea.hashCode ^
        nome.hashCode ^
        horario.hashCode ^
        linkMapa.hashCode ^
        observacao.hashCode;
  }

  void testeEstacaoModel() {
    String jsonString = jsonEncode(EstacaoModel);
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    var estacaoModel = EstacaoModel.fromJson(userMap);

    print('ID da Estacao: ${estacaoModel.idEstacao.toString()}.');
    print('Nome: ${estacaoModel.nome.toString()}.');
  }

  factory EstacaoModel.fromJson(Map<String, dynamic> parsedJson) {
    return EstacaoModel(
        idEstacao: parsedJson['id_estacao'],
        idEndereco: parsedJson['id_endereco'],
        idArea: parsedJson['id_area'],
        nome: parsedJson['nome'],
        horario: parsedJson['horario'],
        linkMapa: parsedJson['link_mapa'],
        observacao: parsedJson['obervacao']);
  }

  Map<String, dynamic> toJson() => {
    'id_estacao': idEstacao,
    'id_endereco': idEndereco,
    'id_area': idArea,
    'nome': nome,
    'horario': horario,
    'link_mapa': linkMapa,
    'observacao': observacao
  };

  Map<String, dynamic> toMap() 
  {
    Map<String, dynamic> map = {
      'id_estacao': idEstacao,
      'id_endereco': idEndereco,
      'id_area': idArea,
      'nome': nome,
      'horario': horario,
      'link_mapa': linkMapa,
      'observacao': observacao
    };
    return map;
  }
}
