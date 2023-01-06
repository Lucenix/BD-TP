-- inserir uma encomenda no sistema
delimiter $$
	create procedure insertEncomenda()
    begin
		
	end; $$
    
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