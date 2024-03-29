use mydb;

drop procedure if exists TempoTransitoEncomenda;

-- Deve ser possivel mostrar todas as Encomendas que não foram pagas (RM1)
select * from Encomenda as e where e.EstadoPagamento = 0;

-- Deve ser possivel mostrar todas as Encomendas sem Percurso (RM2)
select * from Encomenda as e where e.Percurso_idPercurso is null;

-- Visualizar todos os percursos de um dado Funcionário (RM26)
select f.Nome,fp.Percurso_idPercurso as NrPercurso from (Funcionario as f 
	inner join FuncionarioPercurso as fp on f.idFuncionario = fp.Funcionario_idFuncionario)
    where f.idFuncionario = 1;

drop procedure if exists SelectPercursoFuncionario;
delimiter $$
create procedure SelectPercursoFuncionario (in idFuncionario int)
	begin
    select f.Nome,fp.percurso_idpercurso as NrPercurso from (funcionario as f 
	inner join funcionariopercurso as fp on f.idFuncionario = fp.funcionario_idFuncionario)
    where f.idFuncionario = idFuncionario;
    end; $$

-- Visualizar todos os relatórios de um dado Veículo 
select r.descricao,r.gravidade,v.idVeiculo,v.Matricula from relatorio as r 
	inner join veiculo as v on r.Veiculo_idVeiculo = v.idVeiculo
	where r.veiculo_idveiculo = 2 or r.Veiculo_idVeiculo = "20-BD-23";
    
-- Deve ser possível verificar quanto tempo uma Encomenda esteve em trânsito (RM4)
select timestampdiff(hour, e.horaenvio, e.horaentrega) as "Tempo de trânsito (horas)" from encomenda as e
	where e.idEncomenda = 4;

delimiter $$
create procedure TempoTransitoEncomenda(in idEncomenda int)
	begin
	select timestampdiff(hour, e.HoraEnvio,e.HoraEntrega) as "Tempo de Trânsito (horas)" from Encomenda as e
		where e.idEncomenda = idEncomenda;
	end; $$

call TempoTransitoEncomenda(4);


-- verificar qual o proximo lote a expirar (RM5)
select ic.* from ItemCompra as ic
	inner join Item as i on i.idItem = ic.Item_idItem
	where ic.PrazoDeValidade is not null and datediff(ic.PrazoDeValidade, CURDATE()) >= 0
    order by ic.PrazoDeValidade ASC
    limit 1;
    
-- Deve ser possivel verificar qual o item mais vendido (RM8)
select i.idItem, i.Nome, SUM(ei.Quantidade) as "Quantidade Comprada" from EncomendaItem as ei
inner join Item as i on i.idItem = ei.Item_idItem
	group by ei.Item_idItem
    order by SUM(ei.Quantidade) DESC
    limit 1;

-- Conseguir ver o top 3 clientes que mais gastaram (RM21)
select C.idCliente, C.Nome, round(SUM(E.CustoTotal),2) as "Dinheiro Gasto"
	from Encomenda as E inner join Cliente as C
	on E.Cliente_idCliente = C.idCliente
	group by C.idCliente
    order by SUM(E.CustoTotal) DESC
	LIMIT 3;

-- Localidade com maior registo de entregas (RM15)
select E.Localidade, Count(Enco.idEncomenda) as "Número de Encomendas"
	from Encomenda as Enco inner join Endereco as E
    on Enco.Endereco_idEndereco = E.idEndereco
    group by E.Localidade
    order by Count(Enco.idEncomenda) DESC
    LIMIT 1;
    

-- Ver o número de percursos feitos pelos estafetas
select f.Nome, count(fp.funcionario_idFuncionario) as "Número Percursos" from Funcionario as f
    inner join FuncionarioPercurso as fp on f.idFuncionario = fp.funcionario_idFuncionario
    group by f.Nome;

select * from ItemCompra;

-- Ver o stock contra o total dos encomendados
select i.idItem as "id", i.Nome, i.Quantidade, sum(ic.Quantidade) as "Soma Quantidades Lotes", sum(ic.Disponiveis) as "Soma Disponíveis Lotes", n.`Encomendados`
	from (select ei.Item_idItem, ifnull(sum(ei.quantidade), "Indisponível") as "Encomendados" 
		  from EncomendaItem as ei
          group by ei.Item_idItem) as n right outer join 
	(ItemCompra as ic inner join Item as i on i.idItem = ic.Item_idItem)
	on n.Item_idItem = ic.Item_idItem
	group by i.idItem;