import 'package:flutter/material.dart';
import 'package:meuapp/providers/lancamentoAPI.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/views/widgets/CartaoLancado.dart';

class UltimosLancamentosPage extends StatefulWidget {
  UltimosLancamentosPage({required this.idEstacao, required this.idUsuario});

  final int idUsuario;
  final int idEstacao;

  @override
  State<UltimosLancamentosPage> createState() => _UltimosLancamentosPageState();
}

class _UltimosLancamentosPageState extends State<UltimosLancamentosPage> {
  List lancamentos = [];

  void getLancamentos() async {
    lancamentos = (await LancamentoAPI.lancamentosUsuarioEstacao(
        widget.idUsuario, widget.idEstacao));
  }

  @override
  void initState() {
    super.initState();
    getLancamentos();
  }

  @override
  Widget build(BuildContext context) {
    double baseWidth = 400;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Estilos.branco,
        shadowColor: Estilos.cinza,
        automaticallyImplyLeading: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Estilos.preto,
        ),
        centerTitle: false,
        elevation: 4,
      ),
      backgroundColor: Estilos.branco,
      body: SafeArea(
        child: FutureBuilder(
          future: LancamentoAPI.lancamentosUsuarioEstacao(
              widget.idUsuario, widget.idEstacao),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.fromLTRB(16 * fem, 26 * fem, 0 * fem, 6 * fem),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          'Últimos Lançamentos',
                          style: SafeGoogleFont(
                            'Comfortaa',
                            fontSize: 27 * ffem,
                            fontWeight: FontWeight.w400,
                            height: 2 * ffem / fem,
                            letterSpacing: -0.54 * fem,
                            color: Estilos.preto,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (lancamentos.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child:
                            const Text('Não foi realizado nenhum lançamento.'),
                      ),
                    ),
                  if (lancamentos.isNotEmpty)
                    for (var lancamento in lancamentos)
                      CartaoLancado(
                        widget: widget,
                        lancamento: lancamento,
                      )
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Algo deu errado"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
