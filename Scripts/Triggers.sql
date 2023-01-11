use mydb;

drop trigger if exists itemcompra_update_compra_custototal;
drop trigger if exists encomendaitem_update_encomenda_custototal;
drop trigger if exists encomenda_update_percurso_distanciatotal;
drop trigger if exists checkFuncionarioPercurso;

-- atualizar automaticamente o custo total de uma compra sempre que se introduzir um novo item
delimiter $$
	create trigger itemcompra_update_compra_custototal
    after insert
    on ItemCompra for each row
    begin
		update compra as c set c.custototal = c.custototal + new.custoparcial where c.idCompra = new.Compra_idCompra;
	end; $$

-- atualizar automaticamente o custo total de uma encomenda sempre que se introduzir um novo item
delimiter $$
	create trigger encomendaitem_update_encomenda_custototal
    after insert
    on EncomendaItem for each row
    begin
		update encomenda as e set e.custototal = e.custototal + EncomendaItem.custoparcial where e.idEncomenda = EncomendaItem.idEncomenda;
	end; $$
    
-- atualizar automaticamente a distância total de um percurso quando uma nova encomenda é adicionada
delimiter $$
	create trigger encomenda_update_percurso_distanciatotal
    after insert
    on Encomenda for each row
    begin
		update percurso as p set p.distanciatotal = p.distanciatotal + Encomenda.distanciaparcial where e.Percurso_idPercurso = p.idPercurso;
	end; $$
    
-- Um Funcionário não pode conduzir um veículo que não está habilitado (RD39)
-- Um Funcionário não pode estar simultaneamente em dois Percursos (RD40)
delimiter $$
	create trigger checkFuncionarioPercurso
    before insert
    on FuncionarioPercurso for each row
    begin
		declare Habilitacao varchar(3);
        declare Categoria varchar(3);
        declare Atual int;
		select f.HabilitacaoAuto from Funcionario as f where f.idFuncionario = new.Funcionario_idFuncionario into Habilitacao;
        select v.Categoria from Veiculo as v inner join Percurso as p 
			on p.idPercurso = new.Percurso_idPercurso and v.idVeiculo = p.Veiculo_idVeiculo into Categoria;
		if Habilitacao < Categoria then signal sqlstate '45000' set Message_text = "Funcionário não habilitado para o Veículo"; end if;
        select p.idPercurso from Percurso as p inner join FuncionarioPercurso as fp on fp.Percurso_idPercurso = p.idPercurso
        where p.HoraChegada = '1000-01-01 00:00:00' into Atual;
        if Atual then signal sqlstate '45000' set Message_text = "Funcionário já em percurso atual"; end if;
    end; $$
    
-- Um Veículo não pode ser utilizado se não estiver operacional (RD32)
-- Um Veículo não pode entregar um Item com Tipos de Conservação que não acomode (RD34)
delimiter $$
	create trigger checkEncomendaVeiculo
    before update
    on Encomenda for each row
    begin
		declare Veiculo int;
        declare EstadoOpercional bool;
        declare FaltamTipos bool;
		if new.Percurso is not null then
		select p.Veiculo from Percurso as p where p.idPercurso = new.Percurso into Veiculo;
        select v.EstadoOperacional from Veiculo as v where v.Veiculo = Veiculo into EstadoOperacional;
        if EstadoOpercaional = 0 then signal sqlstate '45000' set Message_text = "Veículo não operacional"; end if;
        select 
			(select it.TiposConservacao_idTiposConservacao from EncomendaItem as ei 
				inner join ItemTipo as it on it.Item_idItem = ei.Item_idItem
				where ei.Encomenda_idEncomenda = new.idEncomenda and
				it.TiposConservacao_idTiposConservacao not in 
					(select vt.TiposConservacao_idTiposConservacao from VeiculoTipo as vt 
						where vt.Veiculo_idVeiculo = Veiculo)) 
			is null into FaltamTipos;
        if FaltamTipos = 1 then signal sqlstate '45000' set Message_text = "Veículo não satisfaz todos os tipos de Itens que constam do Percurso"; end if;
        end if;
    end; $$ 
