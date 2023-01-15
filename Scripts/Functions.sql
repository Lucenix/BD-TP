use mydb;

drop function if exists isVeiculoEncomendaValid;
delimiter $$
create function isVeiculoEncomendaValid(Veiculo int, Encomenda int)
returns tinyint
deterministic
begin
declare FaltaTipos tinyint;
select exists(
	select it.TiposConservacao_idTiposConservacao 
    from EncomendaItem as ei
	inner join ItemTipo as it on it.Item_idItem = ei.Item_idItem
	where ei.Encomenda_idEncomenda = Encomenda and
	it.TiposConservacao_idTiposConservacao not in 
	(select vt.TiposConservacao_idTiposConservacao from VeiculoTipo as vt 
		where vt.Veiculo_idVeiculo = Veiculo)) into FaltaTipos;
return FaltaTipos;
end; $$

drop function if exists isVeiculodisp;
delimiter $$
create function isVeiculodisp(idVeiculo INT)
returns tinyint
DETERMINISTIC
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
    return isop and isdisp and inspec;
	end; $$
