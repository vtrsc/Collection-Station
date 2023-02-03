// ignore_for_file: slash_for_doc_comments, non_constant_identifier_names, file_names

class Configuracoes {

  /**
   * Endereço da API de Login para recuperar o Token, passando usuário e senha: 
   * https://api.santoandre.sp.gov.br/estacaocoleta/v1/usuario/login/ 
   * 
   * */
   static Uri urlDeleteVeiculo = Uri.parse('https://api.santoandre.sp.gov.br/estacaocoleta/v1/cad_pessoa_veiculo/'); 
   
  static Uri urlApiRecuperarToken = Uri.parse('https://api.santoandre.sp.gov.br/estacaocoleta/v1/usuario/login/');

  static Uri urlLancamento = Uri.parse('https://api.santoandre.sp.gov.br/estacaocoleta/v1/lancamento/');

  static Uri urlTop10Utilizadores = Uri.parse('https://api.santoandre.sp.gov.br/estacaocoleta/v1/lancamento/top10/'); 

  static Uri urlLancamentoItem = Uri.parse('https://api.santoandre.sp.gov.br/estacaocoleta/v1/lancamento_item/');

  static String urlLancamentoItemGet = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/lancamento_item/';

  static String urlLancamentoItemDeleteTodos = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/lancamento_item/todos/';

  static Uri urlPesquisaCpf_Cnpj = Uri.parse('https://api.santoandre.sp.gov.br/estacaocoleta/v1/cad_pessoa/cpf_cnpj/');

  static Uri urlPesquisaID = Uri.parse('https://api.santoandre.sp.gov.br/estacaocoleta/v1/cad_pessoa/id/');

  /**
   * Endereço da API de Login para recuperar os dados do Usuário, passando o Token: 
   * https://api.santoandre.sp.gov.br/estacaocoleta/v1/usuario/{LOGIN_USUARIO}
   * */ 
  static String urlApiRecuperarUsuario = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/usuario/';

    static String urlCadVeiculoPessoa = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/cad_pessoa_veiculo/id_cad_pessoa/';
    static String urlCadVeiculo = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/cad_pessoa_veiculo/id_cad_pessoa_veic/';
    static  String urlAddVeiculo = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/cad_pessoa_veiculo/';
   static Uri  urlApiRecuperarEndereco =  Uri.parse('https://api.santoandre.sp.gov.br/estacaocoleta/v1/endereco/');
  /**
   * Endereço da API de Login para recuperar os dados da Escala e Estação do Usuário, passando o Token e login: 
   * https://api.santoandre.sp.gov.br/estacaocoleta/v1/usuario/{LOGIN_USUARIO}
   * */ 
  static String urlApiRecuperarDadosUsuario = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/escala/login/';

  static String urlApiMaterial = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/material/';

  static String urlApiAutoComplete = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/material/estacao/';

  static Uri urlCEP =  Uri.parse ('https://buscacepinter.correios.com.br/app/endereco/carrega-cep-endereco.php');

  static String urlApiGetEstacao = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/estacao/';

  static String urlGetLancamentosUsuarioEstacao = 'https://api.santoandre.sp.gov.br/estacaocoleta/v1/lancamento/usuario_estacao/';

  static String CadPessoa =  'https://api.santoandre.sp.gov.br/estacaocoleta/v1/cad_pessoa/';
  /**
   * Nome do Aplicativo utilizado por todo o código.
   */
  static String nomeApp = 'App EC';

  /**
   * Váriável de controle de acesso, chamada quando for acessar o sistema pela LoginPage
   */
  static String ACESSAR_APP = 'A';

  /**
   * Váriável de controle de acesso, chamada quando for sair do sistema por meio no menu Sair
   */
  static String SAIR_APP = 'S';
}
