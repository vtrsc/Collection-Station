// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';
import 'package:meuapp/controllers/novaSenhaController.dart';
import 'package:meuapp/utils/Estilos.dart';

class NovaSenhaPage extends StatefulWidget {
  NovaSenhaPage({Key? key}) : super(key: key);

  @override
  NovaSenhaWidgetState createState() => NovaSenhaWidgetState();
}

class NovaSenhaWidgetState extends State<NovaSenhaPage> {
  @override
  Widget build(BuildContext context) 
  {
    return Scaffold
    (
      key: NovaSenhaController.instance.scaffoldKey,
      backgroundColor: Estilos.branco,
      body: Form
      (
        key: NovaSenhaController.instance.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: Container
        (
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration( color: Estilos.branco, ),
          child: Column
          (
            mainAxisSize: MainAxisSize.max,
            children: 
            [
              Padding
              (
                padding: EdgeInsetsDirectional.fromSTEB(0, 50, 0, 0),
                child: Image.asset
                (
                  "assets/imagens/logo.png",
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  fit: BoxFit.fitHeight,
                ),
              ),
              
              Padding
              (
                padding: EdgeInsetsDirectional.fromSTEB(20, 200, 20, 0),
                child: Text
                (
                  'Insira o endereço de e-mail associado à sua conta do App EC.',
                  style: TextStyle
                  (
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    color: Estilos.azulClaro,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              
              Padding
              (
                padding: EdgeInsetsDirectional.fromSTEB(24, 30, 20, 5),
                child: Row
                (
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: 
                  [
                    Text(
                      'E-mail:',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    
                    Expanded
                    (
                      child: Padding
                      (
                        padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                        child: TextFormField
                        (
                          controller: NovaSenhaController.instance.textFieldNovaSenhaEmailController,
                          obscureText: false,
                          decoration: InputDecoration
                          (
                            enabledBorder: OutlineInputBorder
                            (
                              borderSide: BorderSide(
                                color: Estilos.azulClaro,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            focusedBorder: OutlineInputBorder
                            (
                              borderSide: BorderSide(
                                color: Estilos.azulClaro,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(0),
                            ),
                            filled: true,
                            fillColor: Estilos.branco,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                          ),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              Row
              (
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: 
                [
                  Expanded
                  (
                    child: Padding
                    (
                      padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 0),
                      child: TextButton
                      (
                        style: TextButton.styleFrom
                        (
                          foregroundColor: Estilos.azulClaro, padding: EdgeInsetsDirectional.fromSTEB(40, 12, 40, 0),
                          textStyle: TextStyle(fontSize: 20),
                        ),
                        onPressed: () 
                        {
                          Navigator.pop(context);
                        },
                        child: Text('Enviar nova senha'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
