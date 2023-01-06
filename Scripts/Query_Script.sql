use mydb;

-- Visualizar todos os percursos de um dado funcionário 
select f.Nome,fp.percurso_idpercurso as NrPercurso from (funcionario as f 
	inner join funcionariopercurso as fp on f.idFuncionario = fp.funcionario_idFuncionario)
    where f.idFuncionario = 1;

-- Visualizar todos os relatórios de um dado Veículo
select r.descricao,r.gravidade,v.idVeiculo,v.Matricula from relatorio as r 
	inner join veiculo as v on r.Veiculo_idVeiculo = v.idVeiculo
	where r.veiculo_idveiculo = 2 or r.Veiculo_idVeiculo = "20-BD-23";
    
-- Deve ser possível verificar quanto tempo uma Encomenda esteve em trânsito
select datediff(e.horaenvio,e.horaentrega) from encomenda as e
		where e.idEncomenda = 1;

drop procedure if exists TempoTransitoEncomenda;
delimiter $$
create procedure TempoTransitoEncomenda(in idEncomenda int, out diff datetime)
	begin
	select datediff(e.horaenvio,e.horaentrega) into diff from encomenda as e
		where e.idEncomenda = idEncomenda;
	end; $$

call TempoTransitoEncomenda(1, @diff);
select @diff as diff;