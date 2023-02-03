import 'dart:convert';

MaterialModel materialFromJson(String str) => MaterialModel.fromJson(json.decode(str));

// A function that converts a response body into a List<MaterialModel>
List<MaterialModel> parseMateriais(String responseBody) {
  var tagObjsJson = jsonDecode(responseBody) as List;
  List<MaterialModel> tagObjs = tagObjsJson.map((tagJson) => MaterialModel.fromJson(tagJson)).toList();
  return tagObjs;
}

String materialToJson(MaterialModel data) => json.encode(data.toJson());


class MaterialModel {
  late int _idMaterial;
  late String _nome;
  late bool _isDescarte;
  late bool _isRemocao;
  late bool _isVolumoso;
  late bool _isdoacao;
  late String _un_medida;
  late int  preferencial ;
  
  MaterialModel({
    idMaterial,
    nome,
    isDescarte,
    isRemocao,
    isVolumoso,
    isdoacao,
    un_medida,
    preferencial
  });

  int get idMaterial => _idMaterial;

  set idMaterial(int idMaterial) {
    _idMaterial = idMaterial;
  }

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  bool get isDescarte => _isDescarte;

  set isDescarte(bool isDescarte) {
    _isDescarte = isDescarte;
  }

  bool get isRemocao => _isRemocao;

  set isRemocao(bool isRemocao) {
    _isRemocao = isRemocao;
  }

  bool get isVolumoso => _isVolumoso;

  set isVolumoso(bool isVolumoso) {
    _isVolumoso = isVolumoso;
  }

  bool get isdoacao => _isdoacao;

  set isdoacao(bool isdoacao) {
    _isdoacao = isdoacao;
  }


  String get un_medida => _un_medida;

  set un_medida(String un_medida) {
    _un_medida = un_medida;
  }

  @override
  String toString() {
    return 'MaterialModel(idMaterial: $idMaterial, nome: $nome, isDescarte: $isDescarte, isRemocao: $isRemocao, isVolumoso: $isVolumoso, isdoacao: ${isdoacao}, un_medida: ${_un_medida} , preferencial: ${preferencial} )';
  }

  @override
  bool operator ==(covariant MaterialModel other) {
    if (identical(this, other)) return true;

    return other.idMaterial == idMaterial &&
        other.nome == nome &&
        other.isDescarte == isDescarte &&
        other.isRemocao == isRemocao &&
        other.isVolumoso == isVolumoso && 
        other.isdoacao == isdoacao && 
        other._un_medida == un_medida &&
        other.preferencial == preferencial;
      
  }

  @override
  int get hashCode {
    return idMaterial.hashCode ^
        nome.hashCode ^
        isDescarte.hashCode ^
        isRemocao.hashCode ^
        isVolumoso.hashCode ^
        isdoacao.hashCode ^
        un_medida.hashCode ^
        preferencial.hashCode;
       
  }

  void testeLancamentoModel() {
    String jsonString = jsonEncode(MaterialModel);
    Map<String, dynamic> userMap = jsonDecode(jsonString);
    var materialModel = MaterialModel.fromJson(userMap);

    print('ID da Material: ${materialModel.idMaterial.toString()}.');
    print('Nome: ${materialModel.nome.toString()}.');
  }

  factory MaterialModel.fromJson(Map<String, dynamic> parsedJson) {
    return MaterialModel(
        idMaterial: parsedJson['id_material'],
        nome: parsedJson['nome'],
        isDescarte: parsedJson['is_descarte'],
        isRemocao: parsedJson['is_remocao'],
        isVolumoso: parsedJson['is_volumoso'],
        isdoacao: parsedJson['is_doacao'],
        un_medida: parsedJson['un_medida'],
        preferencial: parsedJson['preferencial'],
        
        ); 
      
    
  }

  Map<String, dynamic> toJson() => {
        'id_material': idMaterial,
        'nome': nome,
        'is_descarte': isDescarte,
        'is_remocao': isRemocao,
        'is_volumoso': isVolumoso,
        'is_doacao': isdoacao,
        'un_medida' : un_medida,
        'preferencial' : preferencial,

      
      };

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'id_material': idMaterial,
      'nome': nome,
      'is_descarte': isDescarte,
      'is_remocao': isRemocao,
      'is_volumoso': isVolumoso,
      'is_doacao': isdoacao,
      'un_medida' : un_medida,
      'preferencial' : preferencial,
      
    };
    return map;
  }
}
