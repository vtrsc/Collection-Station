import 'package:flutter/material.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/lancamentoMaterialPage.dart';

class CardMaterial extends StatelessWidget {
  const CardMaterial({
    Key? key,
    required this.material,
    required this.lista,
    required this.idEstacao,
    this.indexLista
  }) : super(key: key);

  final int idEstacao;
  final material;
  final lista;
  final indexLista;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LancamentoMaterialPage(
              dadosMaterial: material,
              lista: lista,
              indexLancamento: indexLista,
            ),
          ),
        );
      },
      child: ListTile(
        title: Text(
          '${material['nome']} - ${material['quantidade']} ${material['un_medida']}',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        subtitle: Text(
          '${material['data_lancamento'].toString().replaceAll('-', '/')}',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Estilos.preto,
          size: 20,
        ),
        tileColor: Estilos.branco,
        dense: false,
      ),
    );
  }
}
