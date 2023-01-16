-- Ficheiro de vistas
Use mydb;
-- Vista dos Clientes
-- Vista? Conseguir ver o Nome, Nif, Idade e Género de todos os Clientes (RM25)
Create View Clientes
As
	Select C.idCliente as "id", C.Nome as "Nome Completo", C.NIF as "Nif",
			ifnull(Year(now()) - Year(C.DataNascimento)
            - (Month(now()) < Month(C.DataNascimento) or ((Month(now()) = Month(C.DataNascimento)) and (Day(now()) < Day(C.DataNascimento)))), "Indisponível")
            as "Idade",
            ifnull(C.Genero, "Indisponível") as "Género"
            from Cliente as C;

select * from Clientes;

-- Vista? Conseguir visualizar o Stock atual (RM23)
-- A soma dos disponíveis e da quantidade serve apenas para demonstrar que a Quantidade no Item está correta
drop View if exists Stock;
Create View Stock
As
	select i.idItem as "id", i.Nome, i.Quantidade as "Quantidade Total Disponível", sum(ic.Quantidade) as "Soma Quantidades Lotes", sum(ic.Disponiveis) as "Soma Disponíveis Lotes", n.`Encomendados`
	from (select ei.Item_idItem, ifnull(sum(ei.quantidade), "Indisponível") as "Encomendados" 
		  from EncomendaItem as ei
          group by ei.Item_idItem) as n right outer join 
	(ItemCompra as ic inner join Item as i on i.idItem = ic.Item_idItem)
	on n.Item_idItem = ic.Item_idItem
	group by i.idItem;
        
select * from Stock;