Use mydb;

CREATE ROLE Estafeta;

Grant Select
	On mydb.Encomenda
    to Estafeta;

Grant Select
	On mydb.Percurso
    to Estafeta;

Grant Select
	On mydb.EncomendaItem
    to Estafeta;

Grant Select
	On mydb.Veiculo
    to Estafeta;


-- Exemplo de um estafeta
Create User 'dantas'@'localhost'
	Identified by 'dantas';
    
Grant Estafeta to 'dantas';

-- drop user role estafeta

-- drop user 'dantas'@'localhost'

-- select * from mysql.user;
    
flush privileges;

CREATE ROLE Administrador;

Grant all privileges on mydb.* to Administrador;

-- Exemplo de um Adminsitrador
Create User 'Bernardo'@'localhost'
	identified by 'Bernardo';

Grant Administrador to 'Bernardo';

-- Drop role Administrador

-- Caso a role não esteja a funcionar após ser dado a um utilizador: set role all;