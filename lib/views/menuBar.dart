// ignore_for_file: prefer_const_constructors, file_names, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuBarAppEC extends StatelessWidget {

  static const  List<String> list = <String>['sair',];
  static const dropdownValue = list;
  final int iconeIndice;
  final String label ;

  MenuBarAppEC
  (
    {
      Key? key,
      required this.iconeIndice,
      required this.label,
    }
  ) : super(key: key);
  
  final iconeList = [
    const Icon(Icons.settings, color: Estilos.preto,),
    const Icon(Icons.logout, color: Estilos.preto),
    const Icon(Icons.person, color: Estilos.preto,),  
  ];

  @override
  Widget build(BuildContext context) {
    return Container
    (
      margin: EdgeInsets.fromLTRB(0, 2, 30, 2),
      child: DropdownButton<String>
      (
        icon: Padding(
          padding: const EdgeInsets.only(right: 20),
          child: const Icon(Icons.person_outline, color: Estilos.preto,),
        ),
        elevation: 16,
        style: const TextStyle(color: Estilos.azulClaro),
        
        onChanged: (String? value) async 
        {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('loginUsuario', "");
          prefs.setString('senhaUsuario', "");
          prefs.setString('accessToken', "");
          prefs.setBool('isLoggedIn', false);
          prefs.setString('dtaUltimoLogin', "");

          Navigator.pushReplacementNamed(context, "/");
        },
        
        items: list.map<DropdownMenuItem<String>>((String value) 
          {
            return DropdownMenuItem<String>
            (
              value: value,
              child: Text(value),
            );
          }
        ).toList(),
      )
    );
  }
}

