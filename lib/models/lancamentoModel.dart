// ignore_for_file: public_member_api_docs, sort_constructors_first, slash_for_doc_comments, unnecessary_getters_setters, avoid_print, file_names
import 'dart:convert';

LancamentoModel lancamentoFromJson(String str) => LancamentoModel.fromJson(json.decode(str));

String lancamentoToJson(LancamentoModel data) => json.encode(data.toJson());

/**
 * ID_LANCAMENTO	N	NUMBER	N			
 * ID_MATERIAL	N	NUMBER	N			
 * ID_ESTACAO	N	NUMBER	N			
 * ID_Usuario	N	NUMBER	N			
 * TIPO_LANCAMENTO	N	VARCHAR2(1)	N			
 * PREFIXO_CAMINHAO	N	VARCHAR2(10)	Y			
 * NOME_RESPONSAVEL	N	VARCHAR2(100)	Y			
 * QUANTIDADE	N	NUMBER	Y	0		
 * OBSERVACAO	N	VARCHAR2(300)	Y			
 * TELEFONE_GESSEIRO	N	NUMBER	Y			
 * DATA_LANCAMENTO	N	DATE	N					
 */
class LancamentoModel {
  late int _idLancamento;
  late int _idCadPessoa;
  late int _idEstacao;
  late int _idUsuario;
  late String _tipoLancamento;
  late String _dataLancamento;
  late String _ds_observacao;

  int get idLancamento => _idLancamento;

  set idLancamento(int idLancamento) {
    _idLancamento = idLancamento;
  }

  int get idCadPessoa => _idCadPessoa;

  set idMaterial(int idMaterial) {
    _idCadPessoa = idCadPessoa;
  }

  int get idEstacao => _idEstacao;

  set idEstacao(int idEstacao) {
    _idEstacao = idEstacao;
  }

  int get idUsuario => _idUsuario;

  set idUsuario(int idUsuario) {
    _idUsuario = idUsuario;
  }

  String get tipoLancamento => _tipoLancamento;

  set tipoLancamento(String tipoLancamento) {
    _tipoLancamento = tipoLancamento;
  }

  String get dataLancamento => _dataLancamento;

  set dataLancamento(String dataLancamento) {
    _dataLancamento = dataLancamento;
  }

  String get ds_observacao => _ds_observacao;

  set ds_observacao(String ds_observacao) {
    _ds_observacao = ds_observacao;
  }
 
  LancamentoModel({
    id_lancamento,
    id_cad_pessoa,
    id_estacao,
    id_usuario, 
    tipo_lancamento,
    data_lancamento,
    ds_observacao,
  });

  @override
  String toString() {
    return 'LancamentoModel(idLancamento: $idLancamento, idCadPessoa: $idCadPessoa, idEstacao: $idEstacao, idUsuario: $idUsuario, tipoLancamento: $tipoLancamento, dataLancamento: $dataLancamento)';
  }

  @override
  bool operator ==(covariant LancamentoModel other) {
    if (identical(this, other)) return true;

    return other.idLancamento == idLancamento &&
        other.idCadPessoa == idCadPessoa &&
        other.idEstacao == idEstacao &&
        other.idUsuario == idUsuario &&
        other.tipoLancamento == tipoLancamento &&
        other.dataLancamento == dataLancamento && 
        other.ds_observacao == ds_observacao;
  }

  @override
  int get hashCode {
    return idLancamento.hashCode ^
        idCadPessoa.hashCode ^
        idEstacao.hashCode ^
        idUsuario.hashCode ^
        tipoLancamento.hashCode ^
        dataLancamento.hashCode ^
        ds_observacao.hashCode;
  }

  void testeLancamentoModel() {
    String jsonString = jsonEncode(LancamentoModel);
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    var lancamentoModel = LancamentoModel.fromJson(userMap);

    print('ID da Lancamento: ${lancamentoModel.idLancamento.toString()}.');
  }

  factory LancamentoModel.fromJson(Map<String, dynamic> parsedJson) 
  {
    return LancamentoModel
    (
        id_lancamento: parsedJson['ID_LANCAMENTO'],
        id_cad_pessoa: parsedJson['ID_MATERIAL'],
        id_estacao: parsedJson['ID_ESTACAO'],
        id_usuario: parsedJson['ID_USUARIO'],
        tipo_lancamento: parsedJson['TIPO_LANCAMENTO'],
        data_lancamento: parsedJson['DATA_LANCAMENTO'],
        ds_observacao: parsedJson['OBSERVACAO']
    );
  }

  Map<String, dynamic> toJson() => {
    'ID_LANCAMENTO': idLancamento,
    'ID_MATERIAL': idCadPessoa,
    'ID_ESTACAO': idEstacao,
    'ID_Usuario': idUsuario,
    'TIPO_LANCAMENTO': tipoLancamento,
    'DATA_LANCAMENTO': dataLancamento,
    'OBSERVACAO': ds_observacao
  };

  Map<String, dynamic> toMap() 
  {
    Map<String, dynamic> map = 
    {
      'ID_LANCAMENTO': idLancamento,
      'ID_MATERIAL': idCadPessoa,
      'ID_ESTACAO': idEstacao,
      'ID_Usuario': idUsuario,
      'TIPO_LANCAMENTO': tipoLancamento,
      'DATA_LANCAMENTO': dataLancamento,
      'OBSERVACAO': ds_observacao
    };
    return map;
  }
}
