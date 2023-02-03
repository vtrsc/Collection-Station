// ignore_for_file: public_member_api_docs, sort_constructors_first, slash_for_doc_comments, unnecessary_getters_setters
import 'dart:convert';

EscalaModel escalaFromJson(String str) => EscalaModel.fromJson(json.decode(str));

String escalaToJson(EscalaModel data) => json.encode(data.toJson());

/**
   * ID_ESCALA	N	NUMBER	N			
   * ID_FUNCIONARIO	N	NUMBER	N			
   * ID_ESTACAO	N	NUMBER	N			
   * SEGUNDA	N	NUMBER(1)	Y			
   * TERCA	N	NUMBER(1)	Y			
   * QUARTA	N	NUMBER(1)	Y			
   * QUINTA	N	NUMBER(1)	Y			
   * SEXTA	N	NUMBER(1)	Y			
   * SABADO	N	NUMBER(1)	Y			
   * DOMINGO	N	NUMBER(1)	Y			
   * HORARIO_TRABALHO	N	VARCHAR2(20)	Y			
   */
class EscalaModel {
  late int _idEscala;
  late int _idEstacao;
  late int _idUsuario;
  late int _segunda;
  late int _terca;
  late int _quarta;
  late int _quinta;
  late int _sexta;
  late int _sabado;
  late int _domingo;
  late String _horarioTrabalho;

  EscalaModel({
    idEscala,
    idEstacao,
    idUsuario,
    segunda,
    terca,
    quarta,
    quinta,
    sexta,
    sabado,
    domingo,
    horarioTrabalho,
  });

  void testeEscalaModel() {
    String jsonString = jsonEncode(EscalaModel);
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    var escalaModel = EscalaModel.fromJson(userMap);

    print('ID da Escala: ${escalaModel.idEscala.toString()}.');
    print('ID Funcionario: ${escalaModel.idUsuario.toString()}.');
  }

  factory EscalaModel.fromJson(Map<String, dynamic> parsedJson) 
  {
    return EscalaModel(
        idEscala: parsedJson['ID_ESCALA'],
        idEstacao: parsedJson['ID_ESTACAO'],
        idUsuario: parsedJson['ID_FUNCIONARIO'],
        segunda: parsedJson['SEGUNDA'],
        terca: parsedJson['TERCA'],
        quarta: parsedJson['QUARTA'],
        quinta: parsedJson['QUINTA'],
        sexta: parsedJson['SEXTA'],
        sabado: parsedJson['SABADO'],
        domingo: parsedJson['DOMINGO'],
        horarioTrabalho: parsedJson['HORARIO_TRABALHO']);
  }

  Map<String, dynamic> toJson() => 
  {
    'ID_ESCALA': idEscala,
    'ID_ESTACAO': idEstacao,
    'ID_FUNCIONARIO': idUsuario,
    'SEGUNDA': segunda,
    'TERCA': terca,
    'QUARTA': quarta,
    'QUINTA': quinta,
    'SEXTA': sexta,
    'SABADO': sabado,
    'DOMINGO': domingo,
    'HORARIO_TRABALHO': horarioTrabalho,
  };

  Map<String, dynamic> toMap() 
  {
    Map<String, dynamic> map = {
      'ID_ESCALA': idEscala,
      'ID_ESTACAO': idEstacao,
      'ID_FUNCIONARIO': idUsuario,
      'SEGUNDA': segunda,
      'TERCA': terca,
      'QUARTA': quarta,
      'QUINTA': quinta,
      'SEXTA': sexta,
      'SABADO': sabado,
      'DOMINGO': domingo,
      'HORARIO_TRABALHO': horarioTrabalho,
    };
    return map;
  }

  @override
  String toString() {
    return 'EscalaModel(_idEscala: $_idEscala, _idEstacao: $_idEstacao, _idUsuario: $_idUsuario, _segunda: $_segunda, _terca: $_terca, _quarta: $_quarta, _quinta: $_quinta, _sexta: $_sexta, _sabado: $_sabado, _domingo: $_domingo)';
  }

  @override
  bool operator ==(covariant EscalaModel other) {
    if (identical(this, other)) return true;

    return other._idEscala == _idEscala &&
        other._idEstacao == _idEstacao &&
        other._idUsuario == _idUsuario &&
        other._horarioTrabalho == _horarioTrabalho &&
        other._segunda == _segunda &&
        other._terca == _terca &&
        other._quarta == _quarta &&
        other._quinta == _quinta &&
        other._sexta == _sexta &&
        other._sabado == _sabado &&
        other._domingo == _domingo;
  }

  @override
  int get hashCode {
    return _idEscala.hashCode ^
        _idEstacao.hashCode ^
        _idUsuario.hashCode ^
        _segunda.hashCode ^
        _terca.hashCode ^
        _quarta.hashCode ^
        _quinta.hashCode ^
        _sexta.hashCode ^
        _sabado.hashCode ^
        _domingo.hashCode ^
        _horarioTrabalho.hashCode;
  }

  int get idEscala => _idEscala;

  set idEscala(int idEscala) {
    _idEscala = idEscala;
  }

  int get idEstacao => _idEstacao;

  set idEstacao(int idEstacao) {
    _idEstacao = idEstacao;
  }

  int get idUsuario => _idUsuario;

  set idUsuario(int idUsuario) {
    _idUsuario = idUsuario;
  }

  int get segunda => _segunda;

  set segunda(int segunda) {
    _segunda = segunda;
  }

  int get terca => _terca;

  set terca(int terca) {
    _terca = terca;
  }

  int get quarta => _quarta;

  set quarta(int quarta) {
    _quarta = quarta;
  }

  int get quinta => _quinta;

  set quinta(int quinta) {
    _quinta = quinta;
  }

  int get sexta => _sexta;

  set sexta(int sexta) {
    _sexta = sexta;
  }

  int get sabado => _sabado;

  set sabado(int sabado) {
    _sabado = sabado;
  }

  int get domingo => _domingo;

  set domingo(int domingo) {
    _domingo = domingo;
  }

  String get horarioTrabalho => _horarioTrabalho;

  set horarioTrabalho(String horarioTrabalho) {
    _horarioTrabalho = horarioTrabalho;
  }
}
