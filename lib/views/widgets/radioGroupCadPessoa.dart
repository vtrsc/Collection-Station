// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors, unnecessary_string_interpolations, prefer_adjacent_string_concatenation, unnecessary_new, slash_for_doc_comments, must_be_immutable

import 'package:flutter/material.dart';

/**
 * Fonte: https://flutter-examples.com/align-radio-button-in-horizontal-format-in-flutter/
 */
class RadioGroupCadPessoa extends StatefulWidget {
  @override
  RadioGroupCadPessoaWidget createState() => RadioGroupCadPessoaWidget();

  static final RadioGroupCadPessoa instance = RadioGroupCadPessoa._();

  RadioGroupCadPessoa._();


   // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'Pessoa Física';

  // Group Value for Radio Button.
  String tipoCadPessoa = '';
  
}

class RadioGroupCadPessoaWidget extends State {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Radio(
              value: 'F',
              groupValue: RadioGroupCadPessoa.instance.tipoCadPessoa,
              onChanged: (val) {
                setState(() {
                  RadioGroupCadPessoa.instance.radioButtonItem = 'Pessoa Física';
                  RadioGroupCadPessoa.instance.tipoCadPessoa = 'F';
                });
              },
            ),
            Text(
              'Pessoa Física',
              style: new TextStyle(fontSize: 14.0),
            ),

            Radio(
              value: 'J',
              groupValue: RadioGroupCadPessoa.instance.tipoCadPessoa,
              onChanged: (val) {
                setState(() {
                  RadioGroupCadPessoa.instance.radioButtonItem  = 'Pessoa Jurídica';
                  RadioGroupCadPessoa.instance.tipoCadPessoa = 'J';
                });
              },
            ),
            Text(
              'Pessoa Jurídica',
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),

          ],
        ),
      ],
    );
  }
}
