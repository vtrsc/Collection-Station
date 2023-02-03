import 'package:flutter/material.dart';
import 'package:meuapp/controllers/cadPessoaController.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/identificacaoVeiculo.dart';
import 'package:meuapp/views/widgets/preCadastro.dart';

class CartaoTopCadPessoa extends StatelessWidget {
  const CartaoTopCadPessoa({
    Key? key,
    required this.widget,
    required this.cad_pessoa,
  }) : super(key: key);

  final preCadastro widget;
  final Map cad_pessoa;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Padding(
      padding: const EdgeInsets.fromLTRB(23, 20, 23, 0),
      child: Container(
        height: 80,
        child: Flexible(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Estilos.branco,
                elevation: 6,
                shadowColor: Estilos.cinza,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10 * fem)),
              ),
              onPressed: () {
                cadPessoaController.instance.nomeController.text =
                    cad_pessoa['nome'];
                cadPessoaController.instance.cpf_cnpjController.text =
                    cad_pessoa['cpf_cnpj'];
                cadPessoaController.instance.idCadPessoaController.text =
                    cad_pessoa['id_cad_pessoa'].toString();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IdentificacaoVeiculo(
                      idCadPessoa: this.cad_pessoa['id_cad_pessoa'],
                      idUsuario: widget.idUsuario!,
                      idEstacao: widget.idEstacao!,
                      complemento: widget.complemento,
                      bairroEndereco: widget.bairroEndereco,
                      numeroEndereco: widget.numeroEndereco,
                      idTipoLancamento:
                          int.parse(widget.idTipoLancamento.toString()),
                    ),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      radius: 25* fem,
                      backgroundColor: Color.fromARGB(255, 204, 233, 255),
                      child: Image.asset(
                        'assets/mobile/images/vector.png',
                        width: 19.67 * fem,
                        height: 19.67 * fem,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          cad_pessoa['nome'],
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 12.3067655563 * ffem,
                            fontWeight: FontWeight.w600,
                            height: 1.1725 * ffem / fem,
                            letterSpacing: 0.4922706223 * fem,
                            color: Estilos.preto,
                          ),
                        ),
                        Text(
                          cad_pessoa['cpf_cnpj'],
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 12.3067655563 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.1725 * ffem / fem,
                            letterSpacing: 0.4922706223 * fem,
                            color: Estilos.preto,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
