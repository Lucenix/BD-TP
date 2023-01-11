use mydb;
    
drop procedure if exists habilitacaoauto;    
-- verificar a habilitacao automibilistica de um estafeta e quando deve ser renovada
delimiter $$
create procedure habilitacaoauto(in idFuncionario INT, out habilitacao varchar(3))
	begin
    select f.HabilitacaoAuto into habilitacao from Funcionario as f
		where f.idFuncionario = idFuncionario;
	end; $$

drop procedure if exists dataexpir;
delimiter $$
create procedure dataexpir(in idFuncionario INT, out dataexp DATE)
	begin
    select f.DataExpiracaoHabilitacao into dataexp from Funcionario as f
		where f.idFuncionario = idFuncionario;
	end; $$
    
call habilitacaoauto(1, @hab);
call dataexpir(1, @dataexp);
select @hab;
select @dataexp
drop procedure if exists isVeiculodisp;
delimiter $$
create procedure isVeiculodisp(in idVeiculo INT, out est TINYINT)
	begin
    select v.EstadoOperacional into est from Veiculo as v
		where v.idVeiculo = idVeiculo;
	end; $$
call isVeiculodisp(1, @est);
select @est;
