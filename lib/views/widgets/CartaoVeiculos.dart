import 'package:flutter/material.dart';
import 'package:meuapp/controllers/cadVeiculoController.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/identificacaoVeiculo.dart';
import 'package:meuapp/views/lancamentoPage.dart';

class CartaoVeiculos extends StatefulWidget {
  const CartaoVeiculos({
    Key? key,
    required this.placa,
    required this.widget,
  }) : super(key: key);

  final Map placa;
  final IdentificacaoVeiculo widget;

  @override
  State<CartaoVeiculos> createState() => _CartaoVeiculosState();
}

class _CartaoVeiculosState extends State<CartaoVeiculos> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Container(
      height: 100,
      child: Flexible(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(23, 20, 23, 0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Estilos.branco,
              elevation: 6,
              shadowColor: Estilos.cinza,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10 * fem)),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => LancamentoPage(
                        idTipoLancamento: widget.widget.idTipoLancamento,
                        idUsuario: widget.widget.idUsuario,
                        idEstacao: widget.widget.idEstacao)),
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    radius: 25 * fem,
                    backgroundColor: Color.fromARGB(255, 204, 233, 255),
                    child: Icon(
                      Icons.directions_car,
                      color: Estilos.azulClaro,
                      size: 30 * fem,
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
                        widget.placa['placa_veiculo'].toString(),
                        style: SafeGoogleFont(
                          'Roboto',
                          fontSize: 12.3067655563 * ffem,
                          fontWeight: FontWeight.w600,
                          height: 1.1725 * ffem / fem,
                          letterSpacing: 0.4922706223 * fem,
                          color: Estilos.preto,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.delete,
                            color: Estilos.azulClaro),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('ATENÇÃO'),
                              content:
                                  Text('Deseja realmente excluir o veículo?'),
                              actions: [
                                TextButton(
                                  child: Text("Não"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    setState(() {});
                                  },
                                ),
                                TextButton(
                                  child: Text("Sim"),
                                  onPressed: () {
                                    setState(() async {
                                      await cadVeiculoController.instance
                                          .btnDeleteVeiculo(
                                        context,
                                        int.parse(widget
                                            .placa['id_cad_pessoa_veic']
                                            .toString()),
                                      );
                                    });
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
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
