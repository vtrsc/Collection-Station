import 'package:flutter/material.dart';
import 'package:meuapp/controllers/cadVeiculoController.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/controllers/cadPessoaController.dart';
import 'package:meuapp/views/lancamentoPage.dart';

class addVeiculosPage extends StatefulWidget {
  addVeiculosPage(
      {required this.idCadPessoa,
      required this.idTipoLancamento,
      required this.idUsuario,
      required this.idEstacao,
      Key? key})
      : super(key: key);

  final int idUsuario;
  final int idEstacao;
  final int idTipoLancamento;

  final int idCadPessoa;

  @override
  State<addVeiculosPage> createState() => _addVeiculosPageState();
}

class _addVeiculosPageState extends State<addVeiculosPage> {
  PostPlacas() async {
    await cadVeiculoController.instance
        .btnAddPlaca(context, widget.idCadPessoa);

       if(cadVeiculoController.instance.placa_veiculo.text == '' || cadVeiculoController.instance.placa_veiculo.text == ''){
      showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('ATENÇÃO'),
        content: Text('Placa ou prefixo não podem ser vazios!'),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
    }

    showDialog(
      barrierColor: Estilos.preto,
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('ATENÇÃO'),
        content: Text('Placa cadastrada com sucesso!'),
        actions: [
          TextButton(
            child: Text("Ok"),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LancamentoPage(
                    idTipoLancamento: widget.idTipoLancamento,
                    idUsuario: widget.idUsuario,
                    idEstacao: widget.idEstacao,
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
          color: Estilos.preto,
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.fromLTRB(16 * fem, 26 * fem, 0 * fem, 14 * fem),
                  child: Text(
                    "Cadastro de veículo",
                    style: SafeGoogleFont(
                      'Comfortaa',
                      fontSize: 34 * ffem,
                      fontWeight: FontWeight.w400,
                      height: 1.115 * ffem / fem,
                      letterSpacing: -0.54 * fem,
                      color: Estilos.preto,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Nome: ' + cadPessoaController.instance.nomeController.text,
                      style: SafeGoogleFont(
                        'Roboto',
                        fontSize: 12.3067655563 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.1725 * ffem / fem,
                        letterSpacing: 0.4922706223 * fem,
                        color: Estilos.preto,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'CPF/CNPJ: ' +
                          cadPessoaController.instance.cpf_cnpjController.text,
                      style: SafeGoogleFont(
                        'Roboto',
                        fontSize: 12.3067655563 * ffem,
                        fontWeight: FontWeight.w600,
                        height: 1.1725 * ffem / fem,
                        letterSpacing: 0.4922706223 * fem,
                        color: Estilos.preto,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextFormField(
                        controller: cadVeiculoController.instance.placa_veiculo,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Placa',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Estilos.branco,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller:
                            cadVeiculoController.instance.prefixo_caminhao,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Prefixo',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Estilos.branco,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cadVeiculoController.instance.marca,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Marca',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Estilos.branco,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cadVeiculoController.instance.modelo,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Modelo',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Estilos.branco,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cadVeiculoController.instance.cor,
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Cor',
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: Estilos.branco,
                          contentPadding:
                              EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                        ),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                        ),
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Estilos.azulClaro,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10 * fem),
                          ),
                          minimumSize: Size(double.infinity, 40),
                          shadowColor: Estilos.cinzaClaro),
                      onPressed: () {
                        PostPlacas();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Adicionar veículo"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
