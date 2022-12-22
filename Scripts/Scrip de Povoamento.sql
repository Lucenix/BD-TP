Use mydb;

-- Tipos de Conservacao
Insert into `TiposConservacao`(`idTiposConservacao`,`Tipo`,`Descrição`)
Values(0,"Temperatura","Conservar à temperatura ambiente");

Insert into `TiposConservacao`(`idTiposConservacao`,`Tipo`,`Descrição`)
Values(1,"Temperatura","Conservar a uma temperatura abaxio de 0 graus");

Insert into `TiposConservacao`(`idTiposConservacao`,`Tipo`,`Descrição`)
Values(2,"Humidade","Manter em ambiente seco");

Select * from TiposConservacao;

-- Funcionário
Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`)
Values(0,"Bernardo Esteves",5000.0,"BE","2020-03-02","2023-01-19","CEO");

Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`)
Values(1,"Júlio Dantas",830.0,"CE","2020-03-02","2025-09-18","Estafeta");

Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`)
Values(2,"Almada Negreiros",2000.0,"B1","2020-03-02","2029-01-12","Gestor de Inventário");

Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`)
Values(3,"Gil Vicente",890.0,"C1E","2020-03-02","2030-05-21","Estafeta");

Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`)
Values(4,"Florbela Espanca",900.0,null,"2020-03-02",null,"Técnico Farmacêutico");

Select * from Funcionario;

-- Contacto (dos funcionários):


-- Veiculo
Insert into `Veiculo`(`idVeiculo`,`Categoria`,`Kilometragem`,`TipoCombustivel`,`DataProximaInspecao`,`EstadoOperacional`,`IUC`)
Values(0,"CE",12,"Diesel","2023-05-02",1,130,33);

Insert into `Veiculo`(`idVeiculo`,`Categoria`,`Kilometragem`,`TipoCombustivel`,`DataProximaInspecao`,`EstadoOperacional`,`IUC`)
Values(1,"B1",100,"Gasolina","2026-03-19",1,91.23);

Insert into `Veiculo`(`idVeiculo`,`Categoria`,`Kilometragem`,`TipoCombustivel`,`DataProximaInspecao`,`EstadoOperacional`,`IUC`)
Values(2,"A1",29,"Gasolina","2024-07-29",1,58.31);

Select * from Veiculo;

-- Relatorio
Insert into `Relatorio`(`Data`,`EstadoResolucao`,`Descricao`,`Gravidade`,`Funcionario_idFuncionario`,`Veiculo_idVeiculo`)
Values("2022-11-03 13:23:44",1,"Lateral do carro com alguns riscos","0",3,0);

Insert into `Relatorio`(`Data`,`EstadoResolucao`,`Descricao`,`Gravidade`,`Funcionario_idFuncionario`,`Veiculo_idVeiculo`)
Values("2022-12-12 11:01:01",1,"Pneu frontal furado","3",1,2);

-- Cliente
Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`Idade`)
Values(0,"José Firmino Fontes",197961240,45);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`Idade`)
Values(1,"Camila Andreia Nogueira da Silva",156081920,null);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`Idade`)
Values(2,"Mariana Fonseca Almada",199873267,22);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`Idade`)
Values(3,"David Ribeiro Bastos",164435875,30);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`Idade`)
Values(4,"Luís André da Mota Fraga",187174830,24);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`Idade`)
Values(5,"Diogo Trigueira Santos",135951690,55);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`Idade`)
Values(6,"Guilherme Roques Ribeiro",148035736,null);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`Idade`)
Values(7,"António José Fernandes Alegre",176315683,65);

-- Contacto (dos clientes):
Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(938795478,null,"JFF32@gmail.com",0,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(929793279,255056491,"CSilva23@hotmail.com",1,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(918483488,null,"MarianaFAlmada@gmail.com",2,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(939925121,null,"DavidBastinho@outlook.com",3,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(928321121,752399852,"LuisMotaPT@gmail.com",4,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(928321121,752399852,"LuisMotaPT@gmail.com",5,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(917810030,null,"DiogoTriSantos@gmail.com",6,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(916146021,447129133,"GuilhermeRR@outlook.com",7,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(937760678,null,"antonioJoseFA@hotmail.com",8,null,null);

-- Fornecedor
Insert into `Fornecedor`(`idFornecedor`,`Designacao`,`Contribuinte`)
Values(0,"BigMartha","578871061");

Insert into `Fornecedor`(`idFornecedor`,`Designacao`,`Contribuinte`)
Values(1,"EuropaMedicamentos","586475615");

Insert into `Fornecedor`(`idFornecedor`,`Designacao`,`Contribuinte`)
Values(2,"MediFeliz","517093686");

Insert into `Fornecedor`(`idFornecedor`,`Designacao`,`Contribuinte`)
Values(3,"XaropeLimitado","518011080");

Insert into `Fornecedor`(`idFornecedor`,`Designacao`,`Contribuinte`)
Values(4,"GaviSA","595387704");

Insert into `Fornecedor`(`idFornecedor`,`Designacao`,`Contribuinte`)
Values(5,"BenU10","571346321");

Insert into `Fornecedor`(`idFornecedor`,`Designacao`,`Contribuinte`)
Values(6,"BroFen","535180007");

-- Contacto (dos fornecedores):

-- Compra

