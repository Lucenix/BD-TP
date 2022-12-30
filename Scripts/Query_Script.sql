use mydb;
select * from cliente;


-- Visualizar todos os percursos de um dado funcionário 
select f.Nome,fp.percurso_idpercurso as NrPercurso from (funcionario as f 
	inner join funcionariopercurso as fp on f.idFuncionario = fp.funcionario_idFuncionario)
    where f.idFuncionario = 1;

-- Visualizar todos os relatórios de um dado Veículo
select r.descricao,r.gravidade,v.idVeiculo,v.Matricula from relatorio as r 
	inner join veiculo as v on r.Veiculo_idVeiculo = v.idVeiculo
	where r.veiculo_idveiculo = 2 or r.Veiculo_idVeiculo = "20-BD-23";
    
-- Deve ser possível verificar quanto tempo uma Encomenda esteve em trânsito
