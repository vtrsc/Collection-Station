// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:meuapp/views/home.dart';
import 'package:meuapp/views/homeEstacaoPage.dart';
import 'package:meuapp/views/loginPage.dart';
import 'package:meuapp/views/novaSenhaPage.dart';

class Rotas 
{
  static Route<dynamic>? gerarRotas(RouteSettings settings) 
  {
    final args = settings.arguments;

    switch (settings.name) 
    {
      case "/":
        return MaterialPageRoute(builder: (_) => HomeAppPage());
      case "/login":
        return MaterialPageRoute(builder: (_) => LoginPage());
      case "/nova-senha":
        return MaterialPageRoute(builder: (_) => NovaSenhaPage());
      case "/home-estacao":
        return MaterialPageRoute(builder: (_) => HomeEstacaoPage());
        
      default:
        _erroRota();
    }
  }

  static Route<dynamic> _erroRota() 
  {
    return MaterialPageRoute(builder: (_) 
    {
      return Scaffold
      (
        appBar: AppBar(title: const Text("Tela não encontrada!"),),
        body: const Center(child: Text("Tela não encontrada!"),),
      );
    });
  }
}