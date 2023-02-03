// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/lancamentoMaterialPage.dart';

class CartaoLancamentoMaterial extends StatefulWidget {
  CartaoLancamentoMaterial(
      {Key? key,
      required this.item,
      required this.listaMateriais,
      required this.index,
      required this.idEstacao})
      : super(key: key);

  final Map item;
  Map<int, Map<dynamic, dynamic>> listaMateriais;
  int index;
  int idEstacao;

  @override
  State<CartaoLancamentoMaterial> createState() =>
      _CartaoLancamentoMaterialState();
}

class _CartaoLancamentoMaterialState extends State<CartaoLancamentoMaterial> {
  bool selecionado = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: Estilos.azulClaro,
          boxShadow: const [
            BoxShadow(
              blurRadius: 3,
              color: Estilos.preto,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            Checkbox(
                value: selecionado,
                onChanged: (bool? value) async {
                  if (value == true && selecionado == false) {
                    widget.listaMateriais = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LancamentoMaterialPage(
                          dadosMaterial: widget.item,
                          lista: widget.listaMateriais,
                        ),
                      ),
                    );
                  }
                  if (value == false && selecionado == true) {
                    widget.listaMateriais.remove(widget.index);
                  }
                  setState(() {
                    selecionado = value!;
                    widget.listaMateriais;
                  });
                }),
            InkWell(
              onTap: () async {
                int len = widget.listaMateriais.length;

                if (selecionado == false) {
                  widget.listaMateriais = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LancamentoMaterialPage(
                        dadosMaterial: widget.item,
                        lista: widget.listaMateriais,
                      ),
                    ),
                  );
                } else {
                  widget.listaMateriais = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LancamentoMaterialPage(
                          dadosMaterial: widget.item,
                          lista: widget.listaMateriais,
                          indexLancamento: widget.index),
                    ),
                  );
                  print(widget.listaMateriais.toString());
                  if (len > widget.listaMateriais.length) {
                    print('excluiu');
                  }
                }
                setState(() {
                  if (selecionado == false) {
                    selecionado = true;
                  }
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      widget.item['nome'],
                      style: TextStyle(color: Estilos.branco),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
