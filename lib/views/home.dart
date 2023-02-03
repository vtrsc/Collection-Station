// ignore_for_file: body_might_complete_normally_nullable, unused_local_variable, prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/utils.dart';

class HomeAppPage extends StatelessWidget {
  HomeAppPage({Key? key}) : super(key: key);

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //ICONE DE LOGOUT

      key: scaffoldKey,
      backgroundColor: Estilos.branco,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                flex: 10,
                child: Container(
                  // group48095618igy (595:3409)
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // group480955473DT (406:3048)
                        child: Image.asset( 'assets/mobile/images/homepessoaspraca.png',),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          // estaocoleta6Sd (465:1062)
                          child: Container(
                            child: Text(
                              'ESTAÇÃO DE COLETA',
                              textAlign: TextAlign.center,
                              style: SafeGoogleFont(
                                'Comfortaa',
                                fontSize: 24 * MediaQuery.of(context).size.width * 0.7/350,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.96 * MediaQuery.of(context).size.width * 0.7/350,
                                color: Color(0xff0b4870),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  // autogroupttdffPF (UDm63oAhPnhy5MiUGDttDF)
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        // buttonwbf (1:669)
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(arguments: "Acesso", context, "/login");
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          child: Container(
                            width: double.infinity,
                            height: 52,
                            decoration: BoxDecoration(
                              border: Border.all(color: Estilos.cinzaClaro),
                              color: Estilos.azulClaro,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: Center(
                                child: Text(
                                  'ACESSAR',
                                  textAlign: TextAlign.center,
                                  style: SafeGoogleFont(
                                    'Roboto',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w900,
                                    height: 1.1725,
                                    letterSpacing: 0.55,
                                    color: Color(0xffffffff),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
