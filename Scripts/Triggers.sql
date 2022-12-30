use mydb;

-- atualizar automaticamente o custuo total de uma compra sempre que se introduzir um novo item
delimiter $$
	create trigger compra_update_custototal
    after insert
    on CompraItem for each row
    begin
		update compra as c set c.custototal = c.custototal + CompraItem.custoparcial where c.idCompra= CompraItem.idCompra;
	end; $$

-- atualizar automaticamente o custo total de uma encomenda sempre que se introduzir um novo item
delimiter $$
	create trigger encomenda_update_custototal
    after insert
    on EncomendaItem for each row
    begin
		update encomenda as e set e.custototal = e.custototal + EncomendaItem.custoparcial where e.idEncomenda = EncomendaItem.idEncomenda;
	end; $$
    
-- 