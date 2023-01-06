-- inserir uma encomenda no sistema
delimiter $$
	create procedure insertEncomenda()
    begin
		
	end; $$
    
    
-- inserir um funcionário num percurso
delimiter $$
	create procedure insertFuncionarioPercurso(in Funcionario_idFuncionario int, in Percurso_idPercurso int, in Condutor tinyint)
    begin
		declare Habilitacao varchar(3);
        declare Categoria varchar(3);
		select f.HabilitacaoAuto from Funcionario as f where f.idFuncionario = Funcionario_idFuncionario into Habilitacao;
        select v.Categoria from Veiculo as v inner join Percurso as p 
			on p.idPercurso = Percurso_idPercurso and v.idVeiculo = p.Veiculo_idVeiculo into Categoria;
		if Habilitacao < Categoria then ;
		INSERT INTO `funcionariopercurso` (`Funcionario_idFuncionario`,`Percurso_idpercurso`, `Condutor`)
		VALUES (Funcionario_idFuncionario, Percurso_idPercurso, Condutor);
	end; $$