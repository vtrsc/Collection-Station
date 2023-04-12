App da Estação de Coleta

Projeto responsável pelo gerenciamento dos lançamentos de Descarte e Remoção de resíduos sólidos de Santo André.

https://www.canva.com/design/DAFajLLWtzs/1uCy7-gsQzBb0IYb34AxiQ/watch?utm_content=DAFajLLWtzs&utm_campaign=designshare&utm_medium=link&utm_source=publishsharelink



## Manutenções

AREA
- ID_area
- nome_area				    (String)	# campo texto
- Lista< ESTACAO >		    (Classe)	# carrega Lista< ESTACAO > vinculadas

ESTACAO				# registra as características da estação pelo encarregado
- ID_estacao
- ID_area								# seleciona qual AREA a estação faz parte
- ID_endereco							# endereço da Estação
- nome_estacao				(String)	# campo texto
- horario				 	(String)	# ex: 08:00 às 12:00 e 13:00 às 18:00
- link_maps 				(String)	# link do google Maps
- observacao				(String)	# campo texto 

ENDERECO			# 1 Estação tem 1 endereço. 1 lançamento tem N endereços.
- ID_endereco
- cep 						(Inteiro)	# campo texto do endereço
- endereco 				    (String)	# carregado via CEP. ex: rua cesário bastos
- bairro					(String)	# carregado via CEP
- cidade					(String)	# carregado via CEP
- uf						(String)	# carregado via CEP
- num_endereco				(Inteiro)	# informado pelo usuário. ex: 456
- compl_endereco			(Inteiro)	# informado pelo usuário. 3x: Apto 563

ESTACAO_MATERIAL	# relação de materiais utilizados em determinada estação.  N:N - N materiais estarão vinculados a N estações
- ID_estacao
- ID_material
- Lista< MATERIAL >			(Classe)	# tabela ESTACAO_MATERIAL: quais materiais poderão ser descartado/removido em cada ESTACAO

MATERIAL			# registra as características do material pelo encarregado
- ID_material
- nome_material			    (String)	# campo texto - nome do material
- is_descarte				(Boolean)	# True / False se aceita descarte
- is_remocao				(Boolean)	# True / False se aceita remoção
- is_volumoso				(Boolean)	# True / False Sofá, Colchão, Espuma, Isopor, Pneus 
- is_pref_cam				(Boolean)	# True / False prefixo do caminhão
- is_nom_resp				(Boolean)	# True / False nome do responsável
- is_nom_empr				(Boolean)	# True / False nome da empresa
- is_pla_veic				(Boolean)	# True / False placa do veiculo
- is_endereco				(Boolean)	# True / False endereco
- is_observacao			    (Boolean)	# True / False observacao
- is_dois_camp_mat			(Boolean)	# True / False solicitar 2 campos materiais
- is_um_camp_mat			(Boolean)	# True / False solicitar 1 campo material
- is_quantidade			    (Boolean)	# True / False solicitar quantidade
- tipo_quantidade			(String)	# U-UNIDADE / S-SACOS/ L- LITROS.. EXIGIDO QUANDO is_quantidade=TRUE. essa informação é cadastrada pela equipe de TI.

Na tela basta ter um combo com o tipo_material tendo as opções D-Descarte / R-Remocao / A-Ambos. Quando for definido Ambos pelo Encarregado, passar True para is_descarte e is_remocao.

LANCAMENTO			# registra o descarte/remoção do material em determinada estação por um funcionário
- ID_lancamento
- ID_estacao				(Classe)	# local do lançamento (descarte/remoção)
- ID_material				(Classe)	# o MATERIAL descartado/removido. Combo com os materiais com tipo igual ao tipo de lançamento definido pelo usuário (Lançar Descarte/Lançar Remocao). Ou seja, select * from MATERIAL where (is_descarte = True) ou (is_remocao = True)
- ID_funcionario			(Classe)	# quem fez o lançamento

- tipo_lancamento			(String)	# D-Descarte / R-Remocao
- usu_nome					(String)	# nome usuário descarte
- usu_placa_veiculo		    (String)	# placa veiculo usuário descarte

- pref_cam					(String)	# campo texto - prefixo do caminhão
- nom_resp					(String)	# campo texto - nome do responsável
- quantidade				(String)	# campo texto - quantidade
- nom_empr					(String)	# campo texto - nome da empresa
- pla_veic					(String)	# campo texto - placa do veiculo
- observacao				(String)	# campo texto - observacao

- ID_primeiro_material		(Classe) 	# quando o campo IS_DOIS_CAM_MAT estiver true, carrega o ID do primeiro material. carregar num combobox para o zelador selecionar
- ID_segundo_material		(Classe) 	# quando o campo IS_DOIS_CAM_MAT estiver true, carrega o ID do segundo material. carregar num combobox para o zelador selecionar

- telefone_gesseiro		    (String)	# se for gesso, informar telefone. variável is_gesseiro pode ser usada para verificar se é gesseiro. se for, exibe o telefone como obrigatório. Logo, se telefone_gesseiro estiver preenchido, é um lançamento com gesseiro.
- data_lancamento			(Datatime)	# datatime do lançamento (data e hora)

Exemplo:
- Volumosos: Informar o prefixo do caminhão, nome do motorista, qual material retirado e a quantidade – Ter espaço para observações
- Gesso: Informar a placa do caminhão e o nome do responsável (motorista) – Ter espaço para observações 
- Uma estação tem N endereços. Tabela LANCAMENTO_HAS_ENDERECO para guarda os IDs
- usu_endereco				(String)	# endereco usuário descarte
- endereco					(String)	# campo texto - endereco

ESCALA				# 1:1 - 1 funcionário vai ter 1 escala. 
- ID_escala
- ID_estacao
- ID_funcionario
- segunda					(Boolean)	# True / False
- terca					    (Boolean)	# True / False
- quarta					(Boolean)	# True / False
- quinta					(Boolean)	# True / False
- sexta					    (Boolean)	# True / False
- sabado					(Boolean)	# True / False
- domingo					(Boolean)	# True / False
- horario_trabalho			(String)	# ex: 08:00 às 12:00 e 13:00 às 18:00

FUNCIONARIO			# características do funcionário
- ID_funcionario
- nome_funcionario 		    (String)	# campo texto
- telefone					(Inteiro)	# ex: 11 94564-7896	
- email					    (String)	# campo de login
- tipo_funcionario 		    (String)	# Z-Zelador / F-Fiscal / E-Encarregado 
- origem					(String)	# P-Peralta / S-Semasa
- re						(String)	# RE. Identificador do usuário

FERIAS				# 1:N - 1 funcionário pode ter N periodos de férias
- ID_ferias
- ID_funcionario
- data_inicio				(Datatime)
- quantidade_dias			(Inteiro)

MOVIMENTACAO		# 1:N - 1 funcionário pode ter N movimentações
- ID_movimentacao
- ID_estacao				
- ID_funcionario
- data_inicio				(Datatime)
- data_fim					(Datatime)

EVENTO				# Tabela para marcar Falta, FQ/HE [Folga quinzenal trabalhada (Hora Extra)]
- ID_evento
- ID_funcionario
- tipo_evento				(String)	# F-Falta / FQ-HE [Folga quinzenal/Hora Extra]
- data_evento				(Datatime)	# data do evento


