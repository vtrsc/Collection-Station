// ignore_for_file: use_key_in_widget_constructors, ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:meuapp/rotas.dart';
import 'package:meuapp/utils/Configuracoes.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/home.dart';

void main() => runApp(AppEC());

class AppEC extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    return MaterialApp
    (
      title: Configuracoes.nomeApp,
      theme: Estilos.temaPadrao,
      home: HomeAppPage(),
      initialRoute: "/",
      onGenerateRoute: Rotas.gerarRotas,
      debugShowCheckedModeBanner: false,
    );
  }
}