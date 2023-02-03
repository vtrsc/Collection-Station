// ignore_for_file: public_member_api_docs, sort_constructors_first, slash_for_doc_comments, unnecessary_getters_setters, avoid_print
import 'dart:convert';

UsuarioModel usuarioFromJson(String str) => UsuarioModel.fromJson(json.decode(str));

String usuarioToJson(UsuarioModel data) => json.encode(data.toJson());

/**
 * id_usuario	N	NUMBER	N			
 * NOME	N	VARCHAR2(100)	N			
 * TELEFONE	N	NUMBER	Y			
 * EMAIL	N	VARCHAR2(100)	Y			
 * TIPO_USUARIO	N	VARCHAR2(1)	N		E-Encarregado, F-Fiscal, Z-Zelador
 * ORIGEM	N	VARCHAR2(50)	Y			
 * RE	N	VARCHAR2(10)	Y			
 */
class UsuarioModel {
  int? id_usuario;
  String? nome;
  int? telefone;
  String? email;
  String? tipoUsuario;
  String? origem;
  String? re;

  UsuarioModel({
    this.id_usuario,
    this.nome,
    this.telefone,
    this.email,
    this.tipoUsuario,
    this.origem,
    this.re,
  });

  void testeUsuarioModel() {
    String jsonString = jsonEncode(UsuarioModel);
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    var usuarioModel = UsuarioModel.fromJson(userMap);

    print('ID da Usuario: ${usuarioModel.id_usuario.toString()}.');
    print('Nome: ${usuarioModel.nome.toString()}.');
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> parsedJson) => UsuarioModel(
      id_usuario: parsedJson['id_usuario'],
      nome: parsedJson['nome'],
      telefone: parsedJson['telefone'],
      email: parsedJson['email'],
      tipoUsuario: parsedJson['tipo_usuario'],
      origem: parsedJson['origem'],
      re: parsedJson['re']
  ); 

  Map<String, dynamic> toJson() => 
  {
    'id_usuario': id_usuario,
    'nome': nome,
    'telefone': telefone,
    'email': email,
    'tipo_Usuario': tipoUsuario,
    'origem': origem,
    're': re
  };

}
