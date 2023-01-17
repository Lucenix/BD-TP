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

-- Um Cliente deve ser inserido no Sistema no momento em que faz a sua primeira Encomenda. (RM9)
-- Sempre que um Cliente fizer uma Encomenda para um certo Endereço, esse Endereço é inserido no sistema (RM10)
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
    -- in HoraPrevista DATETIME,
    -- in HoraEnvio DATETIME,
    in idEndereco INT,
    in NumeroPorta INT,
    in Rua VARCHAR(45),
    in Localidade VARCHAR(45),
    in CodPostal VARCHAR(45),
    -- Mensagem de erro
    OUT pResultado VARCHAR(150))

    insere:begin
        
    DECLARE ErroTransacao BOOL DEFAULT 0;
    DECLARE existsclient TINYINT;
    DECLARE existsendereco TINYINT;
    DECLARE existsClienteEndereco TINYINT;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET ErroTransacao = 1;
    
    start transaction;
    set existsendereco = exists(select e.idEndereco from Endereco as e where e.idEndereco = idEndereco);
    if not existsendereco then
		insert into `Endereco`(`idEndereco`,`NumeroPorta`,`Rua`,`Localidade`,`CodPostal`)
        values(idEndereco,NumeroPorta,Rua,Localidade,CodPostal);
        if ErroTransacao = 1 then rollback; 
			SET pResultado = 'Transação abortada - Inserir Novo Endereco.';
			LEAVE insere;
		end if;
	end if;
    set existsclient = exists(select c.idCliente from Cliente as c where c.idCliente = idCliente);
    if not existsclient then
        insert into `Cliente`(`idCliente`,`Nome`,`NIF`,`DataNascimento`,`Genero`)
        values(idCliente,Nome,NIF,DataNascimento,Genero);
        if ErroTransacao = 1 then rollback; 
			SET pResultado = 'Transação abortada - Inserir Novo Cliente.';
			LEAVE insere;
		end if;
    end if;
    set existsClienteEndereco = exists(select ec.Cliente_idCliente from EnderecoCliente as ec 
    where ec.Endereco_idEndereco = idEndereco and ec.Cliente_idCliente = idCliente);
    if not existsClienteEndereco then
    insert into `EnderecoCliente`(`Cliente_idCliente`,`Endereco_idEndereco`)
        values(idCliente,idEnderco);
        if ErroTransacao = 1 then rollback; 
			SET pResultado = 'Transação abortada - Inserir Novo Endereço relacionado com Cliente.';
			LEAVE insere;
		end if;
	end if;
    insert into `Encomenda`(`idEncomenda`, `EstadoPagamento`, `DataRegisto`, `Percurso_idPercurso`, `Cliente_idCliente`, `Endereco_idEndereco`)
    values(idEncomenda, EstadoPagamento, CURDATE(), null, idCliente, idEndereco);

    if ErroTransacao = 1 then rollback; 
		SET pResultado = 'Transação abortada - Inserir Encomenda.';
		LEAVE insere;
    else commit;
    end if;

end; $$

-- Um Item fora de validade nunca deve ser entregue numa Encomenda (RD33);
-- Todos os dias os lotes devem ser verificados. Qualquer fora de validade deve ser considerado indisponível (RM4).
drop procedure if exists checkValidadeItensDiario;
delimiter $$
create procedure checkValidadeItensDiario ()
begin
	update ItemCompra as ic, Item as i
    SET IC.Disponiveis = 0, I.Quantidade = I.Quantidade - IC.Disponiveis 
    where datediff(curdate(), ic.PrazoDeValidade) >= 31 and i.idItem = ic.Item_idItem;
end; $$
