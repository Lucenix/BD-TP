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

-- Veiculo
Insert into `Veiculo`(`idVeiculo`,`Categoria`,`Kilometragem`,`TipoCombustivel`,`DataProximaInspecao`,`EstadoOperacional`,`IUC`)
Values(0,"CE",12,"Diesel","2023-05-02",1,130,33);

Insert into `Veiculo`(`idVeiculo`,`Categoria`,`Kilometragem`,`TipoCombustivel`,`DataProximaInspecao`,`EstadoOperacional`,`IUC`)
Values(0,"B1",100,"Gasolina","2026-03-19",1,91.23);

Insert into `Veiculo`(`idVeiculo`,`Categoria`,`Kilometragem`,`TipoCombustivel`,`DataProximaInspecao`,`EstadoOperacional`,`IUC`)
Values(0,"B1",29,"Gasolina","2024-07-29",1,58.31);

Select * from Veiculo;

-- 