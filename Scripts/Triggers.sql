use mydb;

drop trigger if exists itemcompra_update_compra_custototal;
drop trigger if exists encomendaitem_update_encomenda_custototal;
drop trigger if exists encomenda_update_percurso_distanciatotal;
drop trigger if exists checkFuncionarioPercurso;
drop trigger if exists checkFuncionario_HabilitacaoAuto;
drop trigger if exists checkEncomenda_VeiculoOperacional_u;
drop trigger if exists checkEncomenda_VeiculoOperacional_i;
drop trigger if exists checkEncomenda_VeiculoTipoConservacao_u;
drop trigger if exists checkEncomenda_VeiculoTipoConservacao_i;
drop trigger if exists checkEncomenda_Percurso_u;
drop trigger if exists checkEncomenda_Percurso_i;
drop trigger if exists checkEncomendaItem_VeiculoTipoConservacao;

-- Se um Funcionário tiver Habilitação Automobilística, torna-se necessário saber a Data de Expiração da Habilitação. (RD31)
delimiter $$
	create trigger checkFuncionario_HabilitacaoAuto
	before insert
    on Funcionario for each row
	begin
		if (new.HabilitacaoAuto is not null and new.DataExpiracaoHabilitacao is null) or
		   (new.HabilitacaoAuto is null and new.DataExpiracaoHabilitacao is not null) then 
			signal sqlstate '45000' set Message_text = "";
		end if;
	end; $$

-- Um Veículo não pode ser utilizado se não estiver operacional (RD32)
delimiter $$
	create trigger checkPercurso_VeiculoOperacional_u
    before update
    on Percurso for each row
    begin
		declare Veiculo int;
        declare EstadoOperacional bool;
        select new.Veiculo_idVeiculo into Veiculo;
        set EstadoOperacional = isVeiculodisp(Veiculo);
        if EstadoOperacional = 0 then signal sqlstate '45000' set Message_text = "Veículo não operacional"; end if;
    end; $$ 

-- Um Veículo não pode ser utilizado se não estiver operacional (RD32)
delimiter $$
	create trigger checkPercurso_VeiculoOperacional_i
    before insert
    on Percurso for each row
    begin
		declare Veiculo int;
        declare EstadoOperacional bool;
        select new.Veiculo_idVeiculo into Veiculo;
        set EstadoOperacional = isVeiculodisp(Veiculo);
        if EstadoOperacional = 0 then signal sqlstate '45000' set Message_text = "Veículo não operacional"; end if;
    end; $$ 

-- Um Item fora de validade nunca deve ser entregue numa Encomenda (RD33);

-- Um Veículo não pode entregar um Item com Tipos de Conservação que não acomode(RD34);
delimiter $$
	create trigger checkEncomenda_VeiculoTipoConservacao_u
	before update
    on Encomenda for each row
	begin
		if new.Percurso_idPercurso is not null then
			if isVeiculoPercursoValid(new.Percurso_idPercurso) = 1
            then signal sqlstate '45000' set Message_text = "Veículo não satisfaz todos os tipos de Itens que constam do Percurso"; end if;
		end if;
	end; $$

-- Um Veículo não pode entregar um Item com Tipos de Conservação que não acomode (RD34)
delimiter $$
	create trigger checkEncomenda_VeiculoTipoConservacao_i
	before insert
    on Encomenda for each row
	begin
		if new.Percurso_idPercurso is not null then
			if isVeiculoPercursoValid(new.Percurso_idPercurso) = 1 
            then signal sqlstate '45000' set Message_text = "Veículo não satisfaz todos os tipos de Itens que constam do Percurso"; end if;
		end if;
	end; $$

-- Um Veículo não pode entregar um Item com Tipos de Conservação que não acomode(RD34);
delimiter $$
	create trigger checkEncomendaItem_VeiculoTipoConservacao
	before insert
    on EncomendaItem for each row
	begin
		declare Percurso int;
        select e.Percurso_idPercurso from Encomenda as e
			where e.idEncomenda = new.Encomenda_idEncomenda into Percurso;
		if Percurso is not null then
			if isVeiculoPercursoValid(Percurso) = 1 
            then signal sqlstate '45000' set Message_text = "Veículo atribuído ao Percurso não satisfaz o Item adicionado"; end if;
		end if;
	end; $$
    
-- atualizar automaticamente o custo total de uma encomenda sempre que se introduzir um novo item (RD35)
-- colocar round(e.CustoTotal,2) para ficar com valores mais simpáticos? :D
delimiter $$
	create trigger encomendaitem_update_encomenda_custototal
    after insert
    on EncomendaItem for each row
    begin
		update Encomenda as e set e.CustoTotal = e.CustoTotal + new.CustoParcial * new.Quantidade where e.idEncomenda = new.Encomenda_idEncomenda;
	end; $$

-- atualizar automaticamente o custo total de uma compra sempre que se introduzir um novo item (RD36)
delimiter $$
	create trigger itemcompra_update_compra_custototal
    after insert
    on ItemCompra for each row
    begin
		update Compra as c set c.CustoTotal = c.CustoTotal + new.CustoParcial where c.idCompra = new.Compra_idCompra;
	end; $$
    
-- A Quantidade Disponível de um Item nunca pode ultrapassar a Quantidade Total, 
-- para cada entrada no relacionamento entre Item e Compra. (RD37)
alter table ItemCompra
add check (Quantidade >= Disponiveis);
    
-- atualizar automaticamente a distância total de um percurso quando uma nova encomenda é adicionada (RD38)
delimiter $$
	create trigger encomenda_update_percurso_distanciatotal
    after insert
    on Encomenda for each row
    begin
		update Percurso as p set p.DistanciaTotal = p.DistanciaTotal + new.DistanciaParcial where new.Percurso_idPercurso = p.idPercurso;
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
		if Habilitacao < Categoria and new.Condutor then signal sqlstate '45000' set Message_text = "Funcionário não habilitado para o Veículo"; end if;
        select p.idPercurso from Percurso as p inner join FuncionarioPercurso as fp on fp.Percurso_idPercurso = p.idPercurso
        where p.HoraChegada = '1000-01-01 00:00:00' into Atual;
        if Atual then signal sqlstate '45000' set Message_text = "Funcionário já em percurso atual"; end if;
    end; $$

-- Quando uma Encomenda está associada a um Percurso, no registo dessa Encomenda passa a ser obrigatória 
-- a Distância Parcial (double), e a Hora Prevista (datetime) se a Hora de Envio estiver registada.(RD41)
delimiter $$
	create trigger checkEncomenda_Percurso_u
	before update
    on Encomenda for each row
	begin
		if new.Percurso_idPercurso is not null and (
			new.HoraEnvio != "1000-01-01 00:00" and new.HoraPrevista = "1000-01-01 00:00" or
			new.DistanciaParcial = "0.0")
		then 
        signal sqlstate '45000' set Message_text = "Veículo não satisfaz todos os tipos de Itens que constam do Percurso"; end if;
	end; $$

-- Quando uma Encomenda está associada a um Percurso, no registo dessa Encomenda passa a ser obrigatória 
-- a Distância Parcial (double), e a Hora Prevista (datetime) se a Hora de Envio estiver registada.(RD41)
delimiter $$
	create trigger checkEncomenda_Percurso_i
	before insert
    on Encomenda for each row
	begin
		if new.Percurso_idPercurso is not null and (
			new.HoraEnvio != "1000-01-01 00:00" and new.HoraPrevista = "1000-01-01 00:00" or
			new.DistanciaParcial = "0.0")
		then 
        signal sqlstate '45000' set Message_text = "Veículo não satisfaz todos os tipos de Itens que constam do Percurso"; end if;
	end; $$
    

-- Trigger que faz o calculo dos disponiveis (RD37 e RD44) 
delimiter $$
	create trigger atualizaDisponiveisInicial
    before insert
    on ItemCompra for each row
    begin
		if new.PrazoDeValidade != null
        then
        set new.Disponiveis = new.Quantidade * (DateDiff(new.PrazoDeValidade,curdate()) > 31);
		else
        set new.Disponiveis = new.Quantidade;
        end if;
end; $$

-- Trigger que verifica se uma compra pode ser efetuada verificando se há stock e se for possível altera o stock de acordo com o pedido
delimiter $$
	create trigger checkEAtualizaQuantidade
    before insert
    on EncomendaItem for each row
    begin
		declare quantidadeAtual INT;
        select SUM(IC.Disponiveis)
        from ItemCompra as IC inner join Item as I
        on IC.Item_idItem = I.idItem
			inner join EncomendaItem as EI
            on EI.Item_idItem = I.idItem
        where I.idItem = new.Item_idItem
        into quantidadeAtual;
        
        if quantidadeAtual < new.Quantidade
        then
        signal sqlstate '45000' set Message_text = "Não Existe stock disponível para esta compra";
        else 
        -- Os triggers são atómicos então respeitam o ACID
        Update ItemCompra as IC SET IC.Disponiveis = IC.Disponiveis - new.Quantidade where IC.Item_idItem = new.Item_idItem;
        Update Item as I set I.Quantidade = I.Quantidade - new.Quantidade where I.idItem = new.Item_idItem;
        end if;
        
	end; $$
    
    