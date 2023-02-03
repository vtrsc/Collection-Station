import 'package:flutter/material.dart';
import 'package:meuapp/controllers/lancamentoController.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/menuLancamentosPage.dart';
import 'package:meuapp/views/widgets/preCadastro.dart';

IconData iconevar = Icons.delete;
String textoLancamento(int idTipoLancamento) {
  switch (idTipoLancamento) {
    case 1:
      iconevar = Icons.recycling;
      return "Descarte";
    case 2:
      iconevar = Icons.fire_truck;
      return "Remoção";
    case 3:
      iconevar = Icons.volunteer_activism_outlined;
      return "Doação";
    default:
      return "Erro";
  }
}

///Tipos Lançamento:
///1 - Descarte
///2 - Remoção
///3 - Doação
class CartaoLancamento extends StatelessWidget {
  CartaoLancamento({
    Key? key,
    required this.idTipoLancamento,
    required this.dados,
  }) : super(key: key);

  final int idTipoLancamento;
  final LancamentosEstacaoPage dados;

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    String txtLancamento = textoLancamento(idTipoLancamento);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
      child: Container(
        width: 100,
        height: 50,
        decoration: const BoxDecoration(
          color: Estilos.branco,
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: ElevatedButton.icon(
            icon: Icon(iconevar),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsetsDirectional.fromSTEB(40, 12, 40, 12), backgroundColor: Estilos.azulClaro,
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () {
              LancamentoController.instance.idTipoLancamentoController.text = idTipoLancamento.toString();
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => preCadastro(
                          idUsuario: dados.idUsuario,
                          complemento: dados.complemento,
                          bairroEndereco: dados.bairroEndereco,
                          numeroEndereco: dados.numeroEndereco,
                          idEstacao: dados.idEstacao,
                          idTipoLancamento: idTipoLancamento,
                        )),
              );
            },
            label: Center(child: Text(txtLancamento, style: SafeGoogleFont (
                          'Roboto',
                          fontSize: 13*ffem,
                          fontWeight: FontWeight.w700,
                          height: 1.1725*ffem/fem,
                          letterSpacing: 0.52*fem,
                          color: Estilos.branco,
                        ),),),
          ),
        ),
      ),
    );
  }
}
