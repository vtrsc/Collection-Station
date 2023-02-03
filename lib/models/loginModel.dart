// ignore_for_file: unnecessary_this, unused_local_variable, unnecessary_getters_setters

import 'dart:convert';
/*import 'package:flutter/material.dart';

import 'package:meuapp/views/homeAcoesPage.dart';
import 'package:meuapp/views/homeEstacaoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginModel {
  final Set<String> tipoUsuario = {'zelador'};

  void logandoAPP(login, token) async {
    SharedPreferences prefstoken = await SharedPreferences.getInstance();
    prefstoken.setString('token', token);
    SharedPreferences prefsTipoFuncinario = await SharedPreferences.getInstance();
    prefsTipoFuncinario.setString('tipoUsuario', tipoUsuario.first);
    if (tipoUsuario == 'zelador') {
      MaterialPageRoute(builder: (_) => const HomeEstacaoPage());
    } else if (tipoUsuario == 'fiscal') {
      MaterialPageRoute(builder: (_) => const HomeEstacaoPage());
    } else if (tipoUsuario == 'encarregado') {
      MaterialPageRoute(builder: (_) => const HomeEstacaoPage());
    }
  }
}
*/



class LoginModel {

  LoginModel loginFromJson(String str) => LoginModel.fromJson(json.decode(str));

  String loginToJson(LoginModel data) => json.encode(data.toJson());
  
  late String _login;
  late String _senha;
  late String _token;
  late String _tipoUsuario;

  String get login => _login;
  set login(String login) {
    _login = login;
  }

  String get senha => _senha;
  set senha(String senha) {
    _senha = senha;
  }

  String get token => _token;
  set token(String token) {
    _token = token;
  }

  String get tipoUsuario => _tipoUsuario;
  set tipoUsuario(String tipoUsuario) {
    _tipoUsuario = tipoUsuario;
  }

  LoginModel({
    login,
    senha,
    token,
    tipoUsuario,
  });

  void testelogarModel() {
    String jsonString = jsonEncode(LoginModel);
    Map<String, dynamic> apiLogin = jsonDecode(jsonString);
    var loginModel = LoginModel.fromJson(apiLogin);
  }

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    login: json["login"],
    senha: json["senha"],
    token: json["token"],
    tipoUsuario: json["tipoUsuario"],
  );

  Map<String, dynamic> toJson() => 
  {
    'login': this.login,
    'senha': this.senha,
    'token': this.token,
    'tipoUsuario': this.tipoUsuario,
  };
}
