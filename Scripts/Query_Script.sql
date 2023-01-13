use mydb;

-- Visualizar todos os percursos de um dado Funcionário 
select f.Nome,fp.percurso_idpercurso as NrPercurso from (funcionario as f 
	inner join funcionariopercurso as fp on f.idFuncionario = fp.funcionario_idFuncionario)
    where f.idFuncionario = 1;

-- Visualizar todos os relatórios de um dado Veículo
select r.descricao,r.gravidade,v.idVeiculo,v.Matricula from relatorio as r 
	inner join veiculo as v on r.Veiculo_idVeiculo = v.idVeiculo
	where r.veiculo_idveiculo = 2 or r.Veiculo_idVeiculo = "20-BD-23";
    
-- Deve ser possível verificar quanto tempo uma Encomenda esteve em trânsito
select datediff(e.horaenvio,e.horaentrega) from encomenda as e
		where e.idEncomenda = 1;

drop procedure if exists TempoTransitoEncomenda;

delimiter $$
create procedure TempoTransitoEncomenda(in idEncomenda int, out diff datetime)
	begin
	select datediff(e.horaenvio,e.horaentrega) into diff from encomenda as e
		where e.idEncomenda = idEncomenda;
	end; $$

call TempoTransitoEncomenda(1, @diff);
select @diff as diff;

-- 

-- verificar qual o proximo lote a expirar
select ic.* from ItemCompra as ic
	inner join Item as i on i.idItem = ic.Item_iditem
	where ic.PrazoDeValidade is not null and datediff(ic.PrazoDeValidade, CURDATE()) >= 0
    order by ic.PrazoDeValidade ASC
    limit 1;
    
-- Deve ser possivel verificar qual o item mais vendido----untested not POG
select e.Item_idItem, SUM(e.Quantidade) from EncomendaItem as e
	group by e.Item_idItem;
    order by SUM(e.Quantidade) ASC
    limit 1

-- Conseguir ver o top 3 clientes que mais gastaram
select C.idCliente, C.Nome, round(SUM(E.CustoTotal),2) as "Dinheiro Gasto"
	from EncomendaItem as EI inner join Encomenda as E
		on EI.encomenda_idEncomenda = E.idEncomenda
			inner join Cliente as C
            on E.Cliente_idCliente = C.idCliente
	group by C.idCliente
    order by SUM(E.CustoTotal) DESC
    LIMIT 3;






	
    




