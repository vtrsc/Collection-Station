import 'package:flutter/material.dart';
import 'package:meuapp/controllers/lancamentoController.dart';
import 'package:meuapp/models/escalaUsuarioModel.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/views/menuLancamentosPage.dart';
import '../../utils/Estilos.dart';

class CardEstacao extends StatelessWidget {
  const CardEstacao({Key? key, required this.info, required this.idUsuario})
      : super(key: key);

  final EscalaUsuarioModel info;
  final int idUsuario;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return Padding(
      padding: const EdgeInsets.fromLTRB(23,20,23,0),
      child: Container(
        // estaao1ivd (407:5641)
        child: TextButton(
          onPressed: () async {
            LancamentoController.instance.idEstacaoController.text = info.id_estacao.toString();
            LancamentoController.instance.idUsuarioController.text = this.idUsuario.toString();
            print(LancamentoController.instance.idUsuarioController.text);
            await Navigator.push(
              context,
              MaterialPageRoute(
                settings: RouteSettings(name: "/menu-acoes"),
                builder: (context) => LancamentosEstacaoPage(
                  idEstacao: info.id_estacao,
                  idUsuario: idUsuario,
                  complemento: info.complemento!,
                  bairroEndereco: info.bairro!,
                  numeroEndereco: info.numero!,
                ),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Container(
            padding:
                EdgeInsets.fromLTRB(13 * fem, 13 * fem, 50 * fem, 12 * fem),
            width: double.infinity,
            height: 70 * fem,
            decoration: BoxDecoration(
              color: Estilos.branco,
              borderRadius: BorderRadius.circular(20 * fem),
              boxShadow: [
                BoxShadow(
                  color: Estilos.preto,
                  offset: Offset(0 * fem, 1.8899999857 * fem),
                  blurRadius: 4.7350001335 * fem,
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    // recycleicontyX (407:5645)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 0 * fem, 20 * fem, 0 * fem),
                    width: 45 * fem,
                    height: 45 * fem,
                    child: Image.asset(
                      'assets/mobile/images/recycleicon.png',
                      width: 45 * fem,
                      height: 45 * fem,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Container(
                    // autogroupzmpdmnR (UDmNnjSYLzJYTwrChxZMpd)
                    margin:
                        EdgeInsets.fromLTRB(0 * fem, 8 * fem, 0 * fem, 3.5 * fem),
                    height: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // estaoerechimGz5 (407:5644)
                          margin: EdgeInsets.fromLTRB(
                              0 * fem, 0 * fem, 0 * fem, 3.5 * fem),
                          child: Text(
                            info.nome!,
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 12.3067655563 * ffem,
                              fontWeight: FontWeight.w900,
                              height: 1.1725 * ffem / fem,
                              letterSpacing: 0.4922706223 * fem,
                              color: Estilos.preto,
                            ),
                          ),
                        ),
                        Text(
                          // ruaerechim635parqueerasmoXv1 (407:5643)
                          '${info.complemento}, ${info.numero} - ${info.bairro}.',
                          style: SafeGoogleFont(
                            'Roboto',
                            fontSize: 12 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 1.1725 * ffem / fem,
                            color: Estilos.preto,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
