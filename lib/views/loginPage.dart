// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, prefer_final_fields, use_key_in_widget_constructors, unused_import, use_build_context_synchronously, library_private_types_in_public_api, unused_local_variable, unnecessary_null_comparison, unused_element
import 'package:flutter/material.dart';
import 'package:meuapp/controllers/loginController.dart';
import 'package:meuapp/models/areaModel.dart';
import 'package:meuapp/models/usuarioModel.dart';
import 'package:meuapp/utils.dart';
import 'package:meuapp/utils/Estilos.dart';
import 'package:meuapp/utils/Configuracoes.dart';
import 'package:meuapp/views/homeEstacaoPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _validaLogin(String? texto) {
    if (texto!.isEmpty) {
      return "Digite o Login";
    }
    return null;
  }

  String? _validaSenha(String? texto) {
    if (texto!.isEmpty) {
      return "Digite a Senha";
    }

    return null;
  }

  @override
  void initState() {
    _verificarUsuarioLogado();
    super.initState();
  }

  Future _verificarUsuarioLogado() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var login = prefs.getString('login');
    //var isLoggedIn = false;
    var isLoggedIn = prefs.getBool('isLoggedIn');
    String dtaUltimoLogin = prefs.getString('dtaUltimoLogin').toString();

    // Verificar como guardar as informações do usuário numa variável global

    //se estiver isLoggedIn verifica se dtaultUltimoLogin tem mais de 15 dias
    //logou dia 14/05 ao entrar dia 28/05 (15 dias) renovar login
    if ((isLoggedIn != null &&
        isLoggedIn == true &&
        DateTime.now().difference(DateTime.parse(dtaUltimoLogin)).inDays <
            15)) {
      // if ((isLoggedIn != null && isLoggedIn == true)){
      Navigator.pushReplacementNamed(context, "/home-estacao");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(Configuracoes.nomeApp, style: SafeGoogleFont (
                      'Roboto',
                      color: Estilos.preto,
                    ),),
        centerTitle: true,
        backgroundColor: Estilos.branco,
        shadowColor: Estilos.cinza,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Form(
            key: LoginController.instance.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(8, 100, 8, 20),
                  child: Text(
                    'Acessar',
                    style: SafeGoogleFont(
                      'Comfortaa',
                      fontSize: 36,
                      fontWeight: FontWeight.w400,
                      color: Estilos.preto,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 20, bottom: 10),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    controller:
                        LoginController.instance.textFieldLoginEmailController,
                    validator: _validaLogin,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Login',
                      hintText: 'Digite o Login',
                    ),
                    style: SafeGoogleFont(
                      'Roboto',
                      fontWeight: FontWeight.w400,
                      color: Estilos.preto,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 15, bottom: 0),
                  child: TextFormField(
                    //  textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller:
                        LoginController.instance.textFieldLoginSenhaController,
                    validator: _validaSenha,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Senha',
                        hintText: 'Digite a Senha'),
                    style: SafeGoogleFont(
                      'Roboto',
                      fontWeight: FontWeight.w400,
                      color: Estilos.preto,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 60, 8, 20),
                  child: Center(
                    child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          border: Border.all(color: Estilos.cinzaClaro),
                          color: Estilos.azulClaro,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Estilos.azulClaro),
                            icon: LoginController.instance.isLoading
                                ? CircularProgressIndicator()
                                : Icon(Icons.login),
                            label: Text(
                              LoginController.instance.isLoading
                                  ? 'Processando...'
                                  : 'Entrar',
                              style: TextStyle(
                                  color: Estilos.branco, fontSize: 25),
                            ),
                            onPressed: () {
                              LoginController.instance.btnLogar(context);
                            })),
                  ),
                ),
                SizedBox(
                  height: 130,
                ),
              ],
            )),
      ),
    );
  }
}
