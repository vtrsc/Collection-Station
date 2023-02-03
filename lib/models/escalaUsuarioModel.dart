// ignore_for_file: file_names, slash_for_doc_comments, non_constant_identifier_names
import 'dart:convert';

EscalaUsuarioModel escalaUsuarioFromJson(String str) => EscalaUsuarioModel.fromJson(json.decode(str));

String escalaUsuarioToJson(EscalaUsuarioModel data) => json.encode(data.toJson());

// A function that converts a response body into a List<EscalaUsuarioModel>
List<EscalaUsuarioModel> parseEscalaUsuario(String responseBody) {
  var tagObjsJson = jsonDecode(responseBody) as List;
  List<EscalaUsuarioModel> tagObjs = tagObjsJson.map((tagJson) => EscalaUsuarioModel.fromJson(tagJson)).toList();
  return tagObjs;
}

/**
 * Dados retornados da API. Não há correlação com o banco de dados. É uma junção de tabelas para facilitar a busca das informações.
 * [
 *   {
 *     "id_funcionario": 0,
 *     "id_estacao": 0,
 *     "id_escala": 0,
 *     "nome": "string",
 *     "segunda": 0,
 *     "terca": 0,
 *     "quarta": 0,
 *     "quinta": 0,
 *     "sexta": 0,
 *     "sabado": 0,
 *     "domingo": 0,
 *     "horario_trabalho": "string",
 *     "link_mapa": "string",
 *     "observacao": "string",
 *     "cep": 0,
 *     "numero": "string",
 *     "complemento": "string",
 *     "bairro": "string",
 *     "municipio": "string",
 *     "uf": "string"
 *   }
 * ]
 */
class EscalaUsuarioModel {

  int idFuncionario;
  int id_estacao;
  int id_escala;

  String? nome;
  int? segunda;
  int? terca;
  int? quarta;
  int? quinta;
  int? sexta;
  int? sabado;
  int? domingo;

  String? horario_trabalho;
  String? link_mapa;
  String? observacao;
  String? cep;
  String? numero;
  String? complemento;
  String? bairro;
  String? municipio;
  String? uf;

  EscalaUsuarioModel({
    required this.idFuncionario,
    required this.id_estacao,
    required this.id_escala,

    this.nome,
    this.segunda,
    this.terca,
    this.quarta,
    this.quinta,
    this.sexta,
    this.sabado,
    this.domingo,

    this.horario_trabalho,
    this.link_mapa,
    this.observacao,
    this.cep,
    this.numero,
    this.complemento,
    this.bairro,
    this.municipio,
    this.uf
  });

  factory EscalaUsuarioModel.fromJson(Map<String, dynamic> parsedJson) {
    return EscalaUsuarioModel(
      idFuncionario: parsedJson['id_usuario'] as int,
      id_estacao: parsedJson['id_estacao'] as int,
      id_escala: parsedJson['id_escala'] as int,

      nome: parsedJson['nome'] as String,
      segunda: parsedJson['segunda'] as int,
      terca: parsedJson['terca'] as int,
      quarta: parsedJson['quarta'] as int,
      quinta: parsedJson['quinta'] as int,
      sexta: parsedJson['sexta'] as int,
      sabado: parsedJson['sabado'] as int,
      domingo: parsedJson['domingo'] as int,

      horario_trabalho: parsedJson['horario_trabalho'] as String,
      link_mapa: "http://maps.google.com", // parsedJson['link_mapa'] as String,
      observacao: parsedJson['observacao'] as String,
      cep: parsedJson['cep'] as String,
      numero: parsedJson['numero'] as String,
      complemento: parsedJson['complemento'] as String?,
      bairro: parsedJson['bairro'] as String,
      municipio: parsedJson['municipio'] as String,
      uf: parsedJson['uf'] as String
    );
  }

  Map<String, dynamic> toJson() => 
  {
    'id_funcionario': idFuncionario,
    'id_estacao': id_estacao,
    'id_escala': id_escala,

    'nome': nome,
    'segunda': segunda,
    'terca': terca,
    'quarta': quarta,
    'quinta': quinta,
    'sexta': sexta,
    'domingo': domingo,

    'horario_trabalho': horario_trabalho,
    'link_mapa': link_mapa,
    'observacao': observacao,
    'cep': cep,
    'numero': numero,
    'complemento': complemento,
    'bairro': bairro,
    'municipio': municipio,
    'uf': uf
  };

  @override
  String toString(){
    return 'EscalaUsuarioModel{idFuncionario: $idFuncionario, id_estacao: $id_estacao, id_escala: $id_escala, nome: $nome, segunda: $segunda, terca: $terca, quarta: $quarta, quinta: $quinta, sexta: $sexta, sabado: $sabado, domingo: $domingo, horario_trabalho: $horario_trabalho, link_mapa: $link_mapa, observacao: $observacao, cep: $cep, numero: $numero, complemento: $complemento, bairro: $bairro, municipio: $municipio, uf: $uf}';
  }
}