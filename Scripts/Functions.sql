use mydb;

drop function if exists isVeiculoPercursoValid;
delimiter $$
create function isVeiculoPercursoValid(Percurso int)
returns tinyint
deterministic
begin
declare FaltaTipos tinyint;
declare Veiculo int;
select p.Veiculo_idVeiculo from Percurso as p where p.idPercurso = Percurso into Veiculo;
select exists(
	select it.TiposConservacao_idTiposConservacao 
    from EncomendaItem as ei
	inner join ItemTipo as it on it.Item_idItem = ei.Item_idItem
    inner join Encomenda as e on e.Percurso_idPercurso = Percurso
	where ei.Encomenda_idEncomenda = e.idEncomenda and
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
