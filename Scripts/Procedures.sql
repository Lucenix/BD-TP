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
    declare isop TINYINT;
    declare isdisp TINYINT;
    declare inspec TINYINT;
    select v.EstadoOperacional, DATEDIFF(v.DataProximaInspecao,CURDATE()) > 0 into isop, inspec from Veiculo as v
		where v.idVeiculo = idVeiculo;
	select 
		not exists(select p.Veiculo_idVeiculo from Percurso as p 
			where p.Veiculo_idVeiculo = idVeiculo and p.HoraChegada = '1000-01-01')
	into isdisp;
    set est = isop and isdisp and inspec;
	end; $$
call isVeiculodisp(3, @est);
select @est;

select p.Veiculo_idVeiculo from Percurso as p 
			where p.Veiculo_idVeiculo = idVeiculo and p.HoraChegada = '1000-01-01'

select p.Veiculo_idVeiculo from Percurso as p 
			where p.Veiculo_idVeiculo = 3 and (p.HoraChegada != '1000-01-01' or DATEDIFF(p.HoraPartida, CURDATE()) > 0)

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
-- calcular o tempo gasto num percurso
drop procedure if exists tempoPercurso;
delimiter $$


create procedure tempoPercurso(in idPercurso INT, out restime TIME)
	begin
    declare chegada DateTime;
    declare partida DateTime;
    select p.HoraChegada, p.HoraPartida into chegada,partida from Percurso as p
		where p.idPercurso = idPercurso;
	if chegada = '1000-01-01 00:00:00' then signal sqlstate '45000' set Message_text = "Percurso não terminado"; end if;
    set restime = timediff(chegada,partida);
	end; $$
call tempoPercurso(2, @res);
select @res;

-- calcular quantos dias faltam para um lote expirar
drop procedure if exists diasAteExpir;
delimiter $$
create procedure diasAteExpir(in idItem INT, in idCompra INT, out dias INT)
	begin
    select datediff(i.PrazoDeValidade, CURDATE()) into dias from ItemCompra as i
		where i.Item_idItem = idItem and i.Compra_idCompra = idCompra;
	end; $$

call diasAteExpir(8,4, @dias);
select @dias;

-- dias até inspecao
drop procedure if exists diasAteInsp;
delimiter $$
create procedure diasAteInsp(in idVeiculo INT, out dias INT)
	begin
    select datediff(v.DataProximaInspecao, CURDATE()) into dias from Veiculo as v
		where v.idVeiculo = idVeiculo;
	end; $$

call diasAteInsp(0, @dias);
select @dias;

drop procedure if exists dinheiroGasto;
delimiter $$
create procedure dinheiroGasto(in idate DATE, in fdate DATE, out gasto DOUBLE)
	begin
    select SUM(c.CustoTotal) into gasto from Compra as c
		where c.DataEmissao between idate and fdate; 
    end; $$

call dinheiroGasto(date("2002-8-01 07:00:30"), date("2002-12-01 00:00:00"), @money);
select @money;



