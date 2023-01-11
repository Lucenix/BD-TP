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

drop procedure if exists DiferencaTiposVeiculoEncomenda;
delimiter $$
create procedure DiferencaTiposVeiculoEncomenda(in Veiculo int, in Encomenda int)
	begin
	select it.TiposConservacao_idTiposConservacao from EncomendaItem as ei 
		inner join ItemTipo as it on it.Item_idItem = ei.Item_idItem
		where ei.Encomenda_idEncomenda = new.idEncomenda and
		it.TiposConservacao_idTiposConservacao not in (
			select vt.TiposConservacao_idTiposConservacao from VeiculoTipo as vt 
			where vt.Veiculo_idVeiculo = Veiculo);
	end; $$
