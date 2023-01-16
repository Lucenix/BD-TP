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