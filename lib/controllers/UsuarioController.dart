import 'package:flutter/material.dart';
import 'package:meuapp/models/lancamentoModel.dart';

/// Controlador para utilizar os dados de Usuario que sao salvos no banco de dados
class UsuarioController {
  static final UsuarioController instance = UsuarioController._();
  static final LancamentoModel lancamentoGlobal = LancamentoModel();

  UsuarioController._();

  late int idUsuarioController;

  bool switchAnonimoValue = false;

  TextEditingController dsObservacaoController = TextEditingController();
  bool isLoading = false;
  dynamic formKey = GlobalKey<FormState>();
  dynamic scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {}
}
