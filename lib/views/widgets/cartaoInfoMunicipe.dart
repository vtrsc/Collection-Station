import 'package:flutter/material.dart';
import 'package:meuapp/controllers/cadPessoaController.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/views/identificacaoVeiculo.dart';
import 'package:meuapp/views/lancamentoCadPessoaPage.dart';

import '../../utils/Estilos.dart';

class CartaoInfosMunicipe extends StatelessWidget {
  const CartaoInfosMunicipe({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final IdentificacaoVeiculo widget;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              size: 50,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(15,8,15,0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${cadPessoaController.instance.nomeController.text}",
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 13 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3846153846 * ffem / fem,
                      color: Estilos.preto,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    " CPF/CNPJ: ${cadPessoaController.instance.cpf_cnpjController.text}",
                    style: SafeGoogleFont(
                      'Roboto',
                      fontSize: 13 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.3846153846 * ffem / fem,
                      color: Estilos.preto,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    onPressed: (() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LancamentoCadPessoaPage(
                            bairroEndereco: widget.bairroEndereco,
                            complemento: widget.complemento,
                            idEstacao: widget.idEstacao,
                            idUsuario: widget.idUsuario,
                            idCadPessoa: widget.idCadPessoa,
                            numeroEndereco: widget.numeroEndereco,
                          ),
                        ),
                      );
                    }),
                    icon: Icon(Icons.edit_sharp)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
