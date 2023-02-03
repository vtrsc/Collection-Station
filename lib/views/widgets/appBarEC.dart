// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable, prefer_const_constructors
import 'package:flutter/material.dart';
import '../../utils/Estilos.dart';

class AppBarEC extends StatelessWidget {
  String nomeUsuarioLogado;

  AppBarEC({
    super.key,
    required this.nomeUsuarioLogado,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Estilos.azulClaro,
      automaticallyImplyLeading: false,
    );
  }
}
