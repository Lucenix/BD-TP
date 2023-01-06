Use mydb;

delete from Contacto;
delete from Relatorio;
delete from Cliente;
delete from FuncionarioPercurso;
delete from DataInspecaoPassada;
delete from VeiculoTipo;
delete from ItemTipo;
delete from TiposConservacao;
delete from ItemCompra;
delete from Item;
delete from Compra;
delete from Endereco;
delete from Fornecedor;
delete from EnderecoCliente;
delete from Funcionario;
delete from Percurso;
delete from Veiculo;

-- Tipos de Conservacao

Insert into `TiposConservacao`(`idTiposConservacao`,`Tipo`,`Descricao`)
Values(0,"Temperatura","Conservar à temperatura ambiente.");

Insert into `TiposConservacao`(`idTiposConservacao`,`Tipo`,`Descricao`)
Values(1,"Temperatura","Conservar a uma temperatura abaixo de 0 graus.");

Insert into `TiposConservacao`(`idTiposConservacao`,`Tipo`,`Descricao`)
Values(2,"Temperatura","Conservar a temperatura refrigerada não negativa.");

Insert into `TiposConservacao`(`idTiposConservacao`,`Tipo`,`Descricao`)
Values(3,"Humidade","Manter em ambiente seco.");

Select * from TiposConservacao;


-- Funcionário

Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`,`DataNascimento`)
Values(0,"Bernardo Esteves",5000.0,"BE","2020-03-02","2023-01-19","CEO","1965-08-19");

Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`,`DataNascimento`)
Values(1,"Júlio Dantas",830.0,"CE","2020-03-02","2025-09-18","Estafeta","1976-05-19");

Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`,`DataNascimento`)
Values(2,"Almada Negreiros",2000.0,"B1","2020-03-02","2029-01-12","Gestor de Inventário","1993-04-07");

Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`,`DataNascimento`)
Values(3,"Gil Vicente",890.0,"C1E","2020-03-02","2030-05-21","Estafeta","1965-04-03");

Insert into `Funcionario`(`idFuncionario`,`Nome`,`Salario`,`HabilitacaoAuto`,`DataEntrada`,`DataExpiracaoHabilitacao`,`Posicao`,`DataNascimento`)
Values(4,"Florbela Espanca",900.0,null,"2020-03-02",null,"Técnico Farmacêutico","1994-12-08");

Select * from Funcionario;


-- Contacto (dos funcionários):

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(926735428,null,"BernardoEstevesCEO@gmail.com",null,null,0);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(929844339,null,"JulioDantas@outlook.com",null,null,1);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(924424531,null,"AntiDantas@gmail.com",null,null,2);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(941110988,252036489,"GilVicente1465@hotmail.com",null,null,3);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(966345009,null,"FlorBelaLobo@gmail.com",null,null,4);


-- Veiculo

Insert into `Veiculo`(`idVeiculo`,`Categoria`,`Kilometragem`,`TipoCombustivel`,`DataProximaInspecao`,`EstadoOperacional`,`IUC`,`Matricula`)
Values(0,"CE",12,"Diesel","2023-05-02",1,130.33,"12-AB-34");

Insert into `Veiculo`(`idVeiculo`,`Categoria`,`Kilometragem`,`TipoCombustivel`,`DataProximaInspecao`,`EstadoOperacional`,`IUC`,`Matricula`)
Values(1,"B1",100,"Gasolina","2026-03-19",1,91.23,"20-BD-20");

Insert into `Veiculo`(`idVeiculo`,`Categoria`,`Kilometragem`,`TipoCombustivel`,`DataProximaInspecao`,`EstadoOperacional`,`IUC`,`Matricula`)
Values(2,"A1",29,"Gasolina","2024-07-29",1,58.31,"20-BD-23");

Select * from Veiculo;


-- DataInspecaoPassada

INSERT INTO `datainspecaopassada`(`DataInspecaoPassada`, `Veiculo_idVeiculo`)
VALUES('2023-01-06', 0);
INSERT INTO `datainspecaopassada`(`DataInspecaoPassada`, `Veiculo_idVeiculo`)
VALUES('2022-01-06', 0);
INSERT INTO `datainspecaopassada`(`DataInspecaoPassada`, `Veiculo_idVeiculo`)
VALUES('2021-05-15', 1);
INSERT INTO `datainspecaopassada`(`DataInspecaoPassada`, `Veiculo_idVeiculo`)
VALUES('2022-05-15', 1);

-- VeiculoTipo

Insert into `VeiculoTipo`(`TiposConservacao_idTiposConservacao`, `Veiculo_idVeiculo`)
values(0,0);

Insert into `VeiculoTipo`(`TiposConservacao_idTiposConservacao`, `Veiculo_idVeiculo`)
values(0,1);

Insert into `VeiculoTipo`(`TiposConservacao_idTiposConservacao`, `Veiculo_idVeiculo`)
values(1,1);

Insert into `VeiculoTipo`(`TiposConservacao_idTiposConservacao`, `Veiculo_idVeiculo`)
values(0,2);

Insert into `VeiculoTipo`(`TiposConservacao_idTiposConservacao`, `Veiculo_idVeiculo`)
values(1,2);

Insert into `VeiculoTipo`(`TiposConservacao_idTiposConservacao`, `Veiculo_idVeiculo`)
values(2,2);


-- Relatorio
Insert into `Relatorio`(`Data`,`EstadoResolucao`,`Descricao`,`Gravidade`,`Funcionario_idFuncionario`,`Veiculo_idVeiculo`)
Values("2022-11-03 13:23:44",1,"Lateral do carro com alguns riscos","0",3,0);

Insert into `Relatorio`(`Data`,`EstadoResolucao`,`Descricao`,`Gravidade`,`Funcionario_idFuncionario`,`Veiculo_idVeiculo`)
Values("2022-12-12 11:01:01",1,"Pneu frontal direito furado","3",1,2);


-- Cliente
Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
Values(0,"José Firmino Fontes",197961240,"1978-04-02",null);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
Values(1,"Camila Andreia Nogueira da Silva",156081920,null,"Feminino");

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
Values(2,"Mariana Fonseca Almada",199873267,"2001-01-17",null);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
Values(3,"David Ribeiro Bastos",164435875,"1993-09-25",null);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
Values(4,"Luís André da Mota Fraga",187174830,"1999-12-01","Masculino");

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
Values(5,"Diogo Trigueira Santos",135951690,"1968-11-11",null);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
Values(6,"Guilherme Roques Ribeiro",148035736,null,null);

Insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
Values(7,"António José Fernandes Alegre",176315683,"1958-07-03","Masculino");


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
Values(928321121,252399852,"LuisMotaPT@gmail.com",4,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(917810030,null,"DiogoTriSantos@gmail.com",5,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(916146021,245129133,"GuilhermeRR@outlook.com",6,null,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(937760678,null,"antonioJoseFA@hotmail.com",7,null,null);

delete from Endereco;


-- Endereco (dos clientes)

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (0,23,"Rua dos Lagos","Braga","4700-025",null);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (1,10,"Rua dos Rios","Braga","4700-010",null);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (2,19,"Rua dos Riachos","Braga","4700-002",null);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (3,123,"Travessa D.Henriques","Guimarães","4800-002",null);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (4,12,"Rua Brofest","Famalicão","4760-025",null);


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

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(933161978,254009936,"geral@bigmartha.com",null,0,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(929671239,241523002,"euromedicamentos@euromedica.com",null,1,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(912241139,273412665,"medi@medifeliz.com",null,2,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(931229551,275552123,"central@xaropelimitado.com",null,3,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(921152734,266533314,"gavi@gaviSA.com",null,4,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(937003936,285534218,"ben@benuten.com",null,5,null);

Insert into `Contacto`(`Telemovel`,`Telefone`,`Email`,`Cliente_idCliente`,`Fornecedor_idFornecedor`,`Funcionario_idFuncionario`)
Values(932680618,255512942,"secretaria@brofen.com",null,6,null);

-- Endereco (dos Fornecedores)

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (5,1,"Rua Martha","Famalicão","4760-005",0);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (6,122,"Rua Europeia","Braga","4700-030",1);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (7,100,"Rua Triste","Braga","4700-031",2);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (8,50,"Travessa com tosse","Famalicão","4760-019",3);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (9,32,"Rua Feliz","Braga","4700-004",4);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (10,21,"Rua Omni","Guimarães","4760-025",5);

INSERT INTO `Endereco`(`idEndereco`,`NumeroPorta`, `Rua`, `Localidade`, `CodPostal`, `Fornecedor_idFornecedor`)
VALUES (11,190,"Rua BigBru","Famalicão","4760-026",6);

-- Item

Insert into `Item`(`idItem`,`Nome`,`Imposto`,`Descricao`,`Custo`,`Quantidade`,`Comparticipacao`)
Values(0,"Voltaren",0.06,"Pomada, Bisnaga 50g",11.80,15,0);

Insert into `Item`(`idItem`,`Nome`,`Imposto`,`Descricao`,`Custo`,`Quantidade`,`Comparticipacao`)
Values(1,"Óleo de soja",0.23,"Aditivo para banho, Frasco 500 ml",17.90,20,0);

Insert into `Item`(`idItem`,`Nome`,`Imposto`,`Descricao`,`Custo`,`Quantidade`,`Comparticipacao`)
Values(2,"Bepanthene",0.23,"Creme, Bisnaga 30g",4.95,20,0);

Insert into `Item`(`idItem`,`Nome`,`Imposto`,`Descricao`,`Custo`,`Quantidade`,`Comparticipacao`)
Values(3,"Paracetamol",0.06,"Comprimido, Blister 20 unidades",2.79,50,0.37);

Insert into `Item`(`idItem`,`Nome`,`Imposto`,`Descricao`,`Custo`,`Quantidade`,`Comparticipacao`)
Values(4,"Vitaminas do complexo B",0.23,"Xarope, Frasco 100ml",5.95,6,0);

Insert into `Item`(`idItem`,`Nome`,`Imposto`,`Descricao`,`Custo`,`Quantidade`,`Comparticipacao`)
Values(5,"Noreva Reducol MD",0.06,"Cápsulas, indicado após intervenções dermocirúrgicas",20.05,5,1);

Insert into `Item`(`idItem`,`Nome`,`Imposto`,`Descricao`,`Custo`,`Quantidade`,`Comparticipacao`)
Values(6,"EMITIUM",0.06,"Cápsulas para a Síndrome do Intestino Irritável",20.35,25,0.90);

Insert into `Item`(`idItem`,`Nome`,`Imposto`,`Descricao`,`Custo`,`Quantidade`,`Comparticipacao`)
Values(7,"Tantum Verde",0.06,"Solução bucal, frasco 500ml",14.70,90,0);

Insert into `Item`(`idItem`,`Nome`,`Imposto`,`Descricao`,`Custo`,`Quantidade`,`Comparticipacao`)
Values(8,"WHEY",0.23,"Proteína em pó, isolada, 1kg",65.99,2,0);


-- ItemTipo

INSERT INTO `itemtipo` (`TiposConservacao_idTiposConservacao`, `Item_idItem`)
VALUES (0, 7);

INSERT INTO `itemtipo` (`TiposConservacao_idTiposConservacao`, `Item_idItem`)
VALUES (0, 5);

INSERT INTO `itemtipo` (`TiposConservacao_idTiposConservacao`, `Item_idItem`)
VALUES (2, 5);

INSERT INTO `itemtipo` (`TiposConservacao_idTiposConservacao`, `Item_idItem`)
VALUES (3, 5);

INSERT INTO `itemtipo` (`TiposConservacao_idTiposConservacao`, `Item_idItem`)
VALUES (3, 3);


-- Compras

INSERT INTO `Compra`(`idCompra`, `CustoTotal`, `DataEmissao`, `DataEntrega`, `Fornecedor_idFornecedor`)
VALUES (0, 0, "2018-12-21 08:32:12", "2019-1-13 16:05:50", 0);

INSERT INTO `Compra`(`idCompra`, `CustoTotal`, `DataEmissao`, `DataEntrega`, `Fornecedor_idFornecedor`)
VALUES (1, 0, "2020-05-07 16:30:04", "2012-5-23 15:56:03", 1);

INSERT INTO `Compra`(`idCompra`, `CustoTotal`, `DataEmissao`, `DataEntrega`, `Fornecedor_idFornecedor`)
VALUES (2, 0, "2009-09-30 10:00:01", "2009-10-5 11:45:01", 2);

INSERT INTO `Compra`(`idCompra`, `CustoTotal`, `DataEmissao`, `DataEntrega`, `Fornecedor_idFornecedor`)
VALUES (3, 0, "2002-09-20 17:30:00", "2002-11-01 07:00:30", 3);

INSERT INTO `Compra`(`idCompra`, `CustoTotal`, `DataEmissao`, `DataEntrega`, `Fornecedor_idFornecedor`)
VALUES (4, 0, "2018-06-14 15:15:15", "2018-06-17 16:03:20", 4);

INSERT INTO `Compra`(`idCompra`, `CustoTotal`, `DataEmissao`, `DataEntrega`, `Fornecedor_idFornecedor`)
VALUES (5, 0, "2019-07-20 05:59:50", "2019-07-29 19:30:30", 5);

INSERT INTO `Compra`(`idCompra`, `CustoTotal`, `DataEmissao`, `DataEntrega`, `Fornecedor_idFornecedor`)
VALUES (6,0, "2021-02-17 20:00:40", "2021-02-28 19:35:35", 6);

INSERT INTO `Compra`(`idCompra`, `CustoTotal`, `DataEmissao`, `DataEntrega`, `Fornecedor_idFornecedor`)
VALUES (7,0, "2017-05-04 12:04:06", "2017-05-20 14:27:50", 4);


-- ItemCompra

INSERT INTO `ItemCompra`(`PrazoDevalidade`, `CustoParcial`, `Quantidade`, `Item_iditem`, `Compra_idCompra`)
VALUES ("2023-09-01", 2.50,150 ,3 ,5);

INSERT INTO `ItemCompra`(`PrazoDevalidade`, `CustoParcial`, `Quantidade`, `Item_iditem`, `Compra_idCompra`)
VALUES (null, 17.90 ,40 ,1 ,4);

INSERT INTO `ItemCompra`(`PrazoDevalidade`, `CustoParcial`, `Quantidade`, `Item_iditem`, `Compra_idCompra`)
VALUES ("2030-12-31" ,40.55 ,4 ,8 ,4);

INSERT INTO `ItemCompra`(`PrazoDevalidade`, `CustoParcial`, `Quantidade`, `Item_iditem`, `Compra_idCompra`)
VALUES ("2037-02-02" ,15.0 ,6 ,6 ,6 );

INSERT INTO `ItemCompra`(`PrazoDevalidade`, `CustoParcial`, `Quantidade`, `Item_iditem`, `Compra_idCompra`)
VALUES ("2012-11-15" ,7.35 ,60 ,7 ,0);

select c.idCompra,c.custototal,ic.custoparcial from ItemCompra as ic inner join Compra as c on ic.Compra_idCompra = c.idCompra;


-- Percurso

INSERT INTO `Percurso`(`idPercurso`,`HoraPartida`,`Veiculo_idVeiculo`)
VALUES (0,"2023-01-19",0);

INSERT INTO `Percurso`(`idPercurso`,`HoraChegada`,`HoraPartida`,`Veiculo_idVeiculo`)
VALUES (1,"2022-12-13","2022-12-12",0);

INSERT INTO `Percurso`(`idPercurso`,`HoraChegada`,`HoraPartida`,`DistanciaTotal`,`Veiculo_idVeiculo`)
VALUES (2,"2022-12-13","2022-12-12",12.5,0);

INSERT INTO `Percurso`(`idPercurso`,`HoraPartida`,`Veiculo_idVeiculo`)
VALUES (3,"2023-01-18",1);

INSERT INTO `Percurso`(`idPercurso`,`HoraChegada`,`HoraPartida`,`DistanciaTotal`,`Veiculo_idVeiculo`)
VALUES (4,"2022-05-25","2022-05-19",50.9,1);

INSERT INTO `Percurso`(`idPercurso`,`HoraPartida`,`Veiculo_idVeiculo`)
VALUES (5,"2023-01-19",2);

INSERT INTO `Percurso`(`idPercurso`,`HoraChegada`,`HoraPartida`,`DistanciaTotal`,`Veiculo_idVeiculo`)
VALUES (6,"2022-12-23","2022-11-11",150.6,2);

select * from percurso;


-- FuncionarioPercurso

call insertFuncionarioPercurso(1,3,1);
call insertFuncionarioPercurso(1,5,1);

select * from FuncionarioPercurso;