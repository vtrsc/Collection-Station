// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Estilos {
  
  static const branco = Color.fromARGB(255, 238, 238, 238);
  static const azulClaro = Color.fromARGB(255, 45, 107, 223);
  static const preto = Color.fromARGB(255, 0, 0, 0);
  static const cinza = Color.fromARGB(255, 117, 117, 117);
  static const cinzaClaro = Color(0xFFE2DEDE);
  static const verde = Color.fromARGB(255, 57, 210, 192);
  static const  verde_escuro = Color.fromARGB(255, 76, 175, 80);
  static const roxo = Color.fromARGB(255, 103, 58, 183);
  static const vermelho = Color.fromARGB(255, 219, 34, 34);

  static final ThemeData temaPadrao = ThemeData(
      primaryColor: const Color(0xff37474f),
      colorScheme: ColorScheme.fromSwatch().copyWith( secondary: const Color(0xff546e7a) )
  );
}
