import 'package:flutter/material.dart';

class NovaSenhaController 
{
  static final NovaSenhaController instance = NovaSenhaController._();
  NovaSenhaController._();

  TextEditingController textFieldNovaSenhaEmailController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    textFieldNovaSenhaEmailController = TextEditingController();
  }
}
