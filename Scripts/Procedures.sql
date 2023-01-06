use mydb;

drop procedure if exists insertEncomenda;    
drop procedure if exists insertFuncionarioPercurso;    
-- inserir uma encomenda no sistema
delimiter $$
	create procedure insertEncomenda()
    begin
		
	end; $$
    
-- inserir um funcionário num percurso
-- Um Funcionário não pode conduzir um veículo que não está habilitado (RD39)
-- Um Funcionário não pode estar simultaneamente em dois Percursos (RD40)
delimiter $$
	create procedure insertFuncionarioPercurso(in Funcionario_idFuncionario int, in Percurso_idPercurso int, in Condutor tinyint)
    begin
		declare Habilitacao varchar(3);
        declare Categoria varchar(3);
        declare Atual int;
		select f.HabilitacaoAuto from Funcionario as f where f.idFuncionario = Funcionario_idFuncionario into Habilitacao;
        select v.Categoria from Veiculo as v inner join Percurso as p 
			on p.idPercurso = Percurso_idPercurso and v.idVeiculo = p.Veiculo_idVeiculo into Categoria;
		if Habilitacao < Categoria then signal sqlstate '45000' set Message_text = "Funcionário não habilitado para o Veículo"; end if;
        select p.idPercurso from Percurso as p inner join FuncionarioPercurso as fp on fp.Percurso_idPercurso = p.idPercurso
        where p.HoraChegada = '1000-01-01 00:00:00';
        select p.idPercurso from Percurso as p inner join FuncionarioPercurso as fp on fp.Percurso_idPercurso = p.idPercurso
        where p.HoraChegada = '1000-01-01 00:00:00' into Atual;
        if Atual then signal sqlstate '45000' set Message_text = "Funcionário já em percurso atual"; end if;
		INSERT INTO `funcionariopercurso` (`Funcionario_idFuncionario`,`Percurso_idpercurso`, `Condutor`)
		VALUES (Funcionario_idFuncionario, Percurso_idPercurso, Condutor);
	end; $$