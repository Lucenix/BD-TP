use mydb;

-- Deve ser possivel mostrar todas as Encomendas que não foram pagas (RM1)
select * from Encomenda as e where e.EstadoPagamento = 0;

-- Deve ser possivel mostrar todas as Encomendas sem Percurso (RM2)
select * from Encomenda as e where e.Percurso = null;

-- Visualizar todos os percursos de um dado Funcionário (RM26)
select f.Nome,fp.percurso_idpercurso as NrPercurso from (funcionario as f 
	inner join funcionariopercurso as fp on f.idFuncionario = fp.funcionario_idFuncionario)
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


-- verificar qual o proximo lote a expirar (RM5)
select ic.* from ItemCompra as ic
	inner join Item as i on i.idItem = ic.Item_iditem
	where ic.PrazoDeValidade is not null and datediff(ic.PrazoDeValidade, CURDATE()) >= 0
    order by ic.PrazoDeValidade ASC
    limit 1;
    
-- Deve ser possivel verificar qual o item mais vendido (RM8)
select i.idItem, i.Nome SUM(ei.Quantidade) from EncomendaItem as ei
inner join Item as i on i.idItem = ei.Item_idItem
	group by ei.Item_idItem
    order by SUM(ei.Quantidade) DESC
    limit 1;

-- Conseguir ver o top 3 clientes que mais gastaram (RM21)
select C.idCliente, C.Nome, round(SUM(E.CustoTotal),2) as "Dinheiro Gasto"
	from EncomendaItem as EI inner join Encomenda as E
		on EI.Encomenda_idEncomenda = E.idEncomenda
			inner join Cliente as C
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
select f.Nome, count(fp.funcionario_idFuncionario) as "num percursos" from Funcionario as f
    inner join FuncionarioPercurso as fp on f.idFuncionario = fp.funcionario_idFuncionario;

