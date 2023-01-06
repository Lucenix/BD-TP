use mydb;

drop trigger if exists itemcompra_update_compra_custototal;
drop trigger if exists encomendaitem_update_encomenda_custototal;
drop trigger if exists percurso_update_distanciatotal;

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