use mydb;

-- atualizar automaticamente o custo total de uma compra sempre que se introduzir um novo item
drop trigger if exists compra_update_custototal;
delimiter $$
	create trigger compra_update_custototal
    after insert
    on ItemCompra for each row
    begin
		update compra as c set c.custototal = c.custototal + new.custoparcial where c.idCompra = new.Compra_idCompra;
	end; $$

-- atualizar automaticamente o custo total de uma encomenda sempre que se introduzir um novo item
drop trigger if exists encomenda_update_custototal;
delimiter $$
	create trigger encomenda_update_custototal
    after insert
    on EncomendaItem for each row
    begin
		update encomenda as e set e.custototal = e.custototal + EncomendaItem.custoparcial where e.idEncomenda = EncomendaItem.idEncomenda;
	end; $$
    
-- 