use mydb;
    
drop procedure if exists habilitacaoauto;    
-- verificar a habilitacao automibilistica de um estafeta e quando deve ser renovada
delimiter $$
create procedure habilitacaoauto(in idFuncionario INT)
	begin
    select f.HabilitacaoAuto from Funcionario as f
		where f.idFuncionario = idFuncionario;
	end; $$

drop procedure if exists dataexpir;
delimiter $$
create procedure dataexpir(in idFuncionario INT)
	begin
    select f.DataExpiracaoHabilitacao from Funcionario as f
		where f.idFuncionario = idFuncionario;
	end; $$
    
call habilitacaoauto(1);
call dataexpir(1);

-- verificar se um veiculo esta operacional -- isto vou deixar com return???--fazer como funç~ao
drop procedure if exists isVeiculodisp;
delimiter $$
create procedure isVeiculodisp(in idVeiculo INT, out est TINYINT)
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
    set est = isop and isdisp and inspec;
	end; $$
call isVeiculodisp(3, @est);
select @est;

select p.Veiculo_idVeiculo from Percurso as p 
			where p.Veiculo_idVeiculo = idVeiculo and p.HoraChegada = '1000-01-01'

select p.Veiculo_idVeiculo from Percurso as p 
			where p.Veiculo_idVeiculo = 3 and (p.HoraChegada != '1000-01-01' or DATEDIFF(p.HoraPartida, CURDATE()) > 0)


-- verifica se veiculo pode levar os tipos de uma encomenda
drop procedure if exists DiferencaTiposVeiculoEncomenda;
delimiter $$
create procedure DiferencaTiposVeiculoEncomenda(in Veiculo int, in Encomenda int)
	begin
	select it.TiposConservacao_idTiposConservacao from EncomendaItem as ei 
		inner join ItemTipo as it on it.Item_idItem = ei.Item_idItem
		where ei.Encomenda_idEncomenda = new.idEncomenda and
		it.TiposConservacao_idTiposConservacao not in (
			select vt.TiposConservacao_idTiposConservacao from VeiculoTipo as vt 
			where vt.Veiculo_idVeiculo = Veiculo);
	end; $$

    
-- calcular o tempo gasto num percurso
drop procedure if exists tempoPercurso;
delimiter $$

create procedure tempoPercurso(in idPercurso INT)
	begin
    declare chegada DateTime;
    declare partida DateTime;
    select p.HoraChegada, p.HoraPartida into chegada,partida from Percurso as p
		where p.idPercurso = idPercurso;
	if chegada = '1000-01-01 00:00:00' then signal sqlstate '45000' set Message_text = "Percurso não terminado"; end if;
    select timediff(chegada,partida);
	end; $$
call tempoPercurso(2);

-- calcular quantos dias faltam para um lote expirar
drop procedure if exists diasAteExpir;
delimiter $$
create procedure diasAteExpir(in idItem INT, in idCompra INT)
	begin
    select datediff(i.PrazoDeValidade, CURDATE()) from ItemCompra as i
		where i.Item_idItem = idItem and i.Compra_idCompra = idCompra;
	end; $$

c rest all diasAteExpir(8,4);

-- dias até inspecao
drop procedure if exists diasAteInsp;
delimiter $$
create procedure diasAteInsp(in idVeiculo INT)
	begin
    select datediff(v.DataProximaInspecao, CURDATE()) from Veiculo as v
		where v.idVeiculo = idVeiculo;
	end; $$

call diasAteInsp(0);


-- Verificar quanto dinheiro foi gasto num dado periodo de tempo
drop procedure if exists dinheiroGasto;
delimiter $$
create procedure dinheiroGasto(in idate DATE, in fdate DATE)
	begin
    select SUM(c.CustoTotal) from Compra as c
		where c.DataEmissao between idate and fdate; 
    end; $$

call dinheiroGasto(date("2002-8-01 07:00:30"), date("2002-12-01 00:00:00"));

-- Verificar quanto dinheiro foi ganho num dado periodo de tempo -- testar
drop procedure if exists dinheiroGanho;
delimiter $$
create procedure dinheiroGanho(in X DATE, in Y DATE)
	begin
	select SUM(e.CustoTotal) from Encomenda as e
		where e.HoraEnvio BETWEEN X and Y; 
	end; $$

call dinheiroGanho(date("2023-01-18 09:00:00"), date("2023-01-20 09:00:02"));

select e.idEncomenda, e.CustoTotal from Encomenda as e

-- Deve ser possível saber os itens e as suas quantidades comprados por um dado Cliente.
drop procedure if exists itensCliente;
delimiter $$
create procedure itensCliente(in id INT)
	begin
    select I.idItem, I.Nome, SUM(EI.Quantidade) as "Quantidade"
		from Item as I inner join EncomendaItem as EI
		on I.idItem = EI.Item_idItem
			inner join Encomenda as E
			on E.idEncomenda = EI.Encomenda_idEncomenda
				inner join Cliente as C
					on C.idCliente = E.Cliente_idCliente
	
		where C.idCliente = id
    
		group by I.idItem
		order by I.idItem ASC;
	end; $$

call itensCliente(1);

-- Verificar todas as compras feitas noma certa altura
drop procedure if exists comprasData;
delimiter $$
create procedure comprasData(in datai DATE, in dataf DATE)
    begin 
    select * from Compra as c
        where c.DataEmissao between datai and dataf;
    end; $$

call ComprasData(date("2000-01-18 09:00:00"),date("2023-01-20 09:00:02"));


drop procedure if exists insereClienteEncomenda;

delimiter $$
create procedure insereClienteEncomenda(
    -- cliente
    in idCliente INT,
    in Nome VARCHAR(45),
    in NIF VARCHAR(9),
    in DataNascimento DATE,
    in Genero VARCHAR(40),
    -- Encomenda
    in idEncomenda INT,
    in EstadoPagamento TINYINT,
    in HoraPrevista DATETIME,
    in HoraEnvio DATETIME,
    in Percurso_idPercurso INT,
    in Endereco_idEndereco INT)

    begin
        
    DECLARE ErroTransacao BOOL DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;
    DECLARE existsclient TINYINT;
    
    start transaction;
    set existsclient = exists(select c.idCliente from Cliente as c where c.idCliente = idCliente);
    if existsclient then
        insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
        values(idCliente,Nome,NIF,DataNascimento,Genero);
    end if;
    insert into `Encomenda`(`idEncomenda`, `EstadoPagamento`, `DataRegisto`, `HoraPrevista`,`HoraEnvio`, `Percurso_idPercurso`, `Cliente_idCliente`, `Endereco_idEndereco`)
    values(idEncomenda, EstadoPagamento, CURDATE(), HoraPartida, HoraEnvio, Percurso_idPercurso, idCliente, Endereco_idEndereco);

    if ErroTransacao = 1 then rollback;
    else commit;

    end if;

end; $$








