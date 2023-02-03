import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meuapp/controllers/lancamentoController.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/lancamentoPage.dart';
import 'package:meuapp/views/ultimosLancamentos.dart';

class CartaoLancado extends StatelessWidget {
  const CartaoLancado({
    Key? key,
    required this.widget,
    required this.lancamento,
  }) : super(key: key);

  final UltimosLancamentosPage widget;
  final lancamento;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Container(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 7, 20, 7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 7,
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LancamentoPage(
                        idEstacao: widget.idEstacao,
                        idTipoLancamento: lancamento['tipo_lancamento'],
                        idUsuario: 1,
                        lancamentoFeito: lancamento,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10 * fem),
                  width: double.infinity,
                  height: 45 * fem,
                  decoration: BoxDecoration(
                    color: Estilos.branco,
                    borderRadius: BorderRadius.circular(10 * fem),
                    boxShadow: [
                      BoxShadow(
                        color: Estilos.preto,
                        offset: Offset(0 * fem, 1.8899999857 * fem),
                        blurRadius: 4.7350001335 * fem,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Expanded(
                          flex: 8,
                          child: Text(
                            textAlign: TextAlign.start,
                            '${DateFormat('dd/MM/yyyy - HH:mm:ss').format(DateTime.parse(lancamento['data_lancamento'].toString()))}',
                            style: SafeGoogleFont(
                              'Roboto',
                              fontSize: 13 * ffem,
                              fontWeight: FontWeight.w400,
                              height: 1.3846153846 * ffem / fem,
                              color: Estilos.preto,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Icon(Icons.edit),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: IconButton(
                padding: EdgeInsets.only(right: 1),
                icon: Icon(
                  size: 40,
                  Icons.delete,
                  color: Estilos.vermelho,
                ),
                onPressed: () async {
                    await LancamentoController.instance
                        .btnDeleteLancamento(context, lancamento['id_lancamento']);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
