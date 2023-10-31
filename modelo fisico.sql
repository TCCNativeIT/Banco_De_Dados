CREATE DATABASE db_Barbearia;
USE db_Barbearia;

CREATE TABLE tbl_Categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nm_categoria VARCHAR(80) NOT NULL
);

CREATE TABLE tbl_Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    id_categoria INT,
    nm_produto VARCHAR(80) NOT NULL,
    descricao VARCHAR(100),
    vl_preco decimal(6,2),
    FOREIGN KEY (id_categoria) REFERENCES tbl_Categoria(id_categoria)
);

CREATE TABLE tbl_Barbearia (
    id_barbearia INT PRIMARY KEY AUTO_INCREMENT,
    nm_barbearia VARCHAR(80) NOT NULL,
    endereco VARCHAR(80) NOT NULL,
    tel_barbearia CHAR(11)
);

CREATE TABLE tbl_Cliente (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nm_cliente VARCHAR(80) NOT NULL,
    email_cliente VARCHAR(100) NOT NULL,
    tel_cliente CHAR(11)
);

CREATE TABLE tbl_Funcionario (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nm_funcionario VARCHAR(80) NOT NULL,
    email_funcionario VARCHAR(100) NOT NULL,
    tel_funcionario CHAR(11)
);

CREATE TABLE tbl_Agendamento (
    id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
    id_funcionario INT,
    id_cliente INT,
    data_agendamento DATE,
    servico VARCHAR(80),
    FOREIGN KEY (id_funcionario) REFERENCES tbl_Funcionario(id_funcionario),
    FOREIGN KEY (id_cliente) REFERENCES tbl_Cliente(id_cliente)
);

---------------------------------------------------------------------------------- procedure para inserir clientes ----------------------------------------------------------------------------------------------------------------- 
drop procedure if exists InserirCliente;
delimiter $$
create procedure InserirCliente(
    in p_nm_cliente varchar(80),
    in p_email varchar(80),
    in p_no_telefone char(11)
)
begin 
	declare erro_SQL tinyint default false;
	declare continue handler for sqlexception set erro_SQL = true;
    
	start transaction;
		insert into tbl_Cliente (nm_cliente, email_cliente, tel_cliente) 
			values (p_nm_cliente, p_email, p_no_telefone);
                
	if(erro_SQL = false) then 
		commit;
			select 'Operação executada com sucesso !!';
	else 
		rollback;
			select 'Ocorreu algum erro ao enviar os registros!';
	end if;
end $$
delimiter ; 

call InserirCliente ('Kayque', 'kayque@gmail.com', '950381606');

select * from tbl_Cliente;
---------------------------------------------------------------------------------- fim da procedure para inserir clientes ----------------------------------------------------------------------------------------------------------------- 


---------------------------------------------------------------------------------- procedure para inserir funcionarios ----------------------------------------------------------------------------------------------------------------- 
drop procedure if exists InserirFuncionario;
delimiter $$
create procedure InserirFuncionario(
	in p_nm_funcionario varchar(80),
    in p_email_funcionario varchar(100),
    in p_tel_funcionario char(11)
)
begin 
	declare erro_SQL tinyint default false;
	declare continue handler for sqlexception set erro_SQL = true;
    
    start transaction; 
		insert into tbl_Funcionario (nm_funcionario, email_funcionario, tel_funcionario) 
			values (p_nm_funcionario, p_email_funcionario, p_tel_funcionario);
            
	if(erro_SQL = false) then 
			commit;
				select 'Operação executada com sucesso !!';
	else 
			rollback;
				select 'Ocorreu algum erro ao enviar os registros!';
	end if;
end $$
delimiter ;

call InserirFuncionario ('Rafael', 'Rafael@gmail.com', '14523678945');

select * from tbl_Funcionario;
---------------------------------------------------------------------------------- fim da procedure para inserir funcionarios ----------------------------------------------------------------------------------------------------------------- 


---------------------------------------------------------------------------------- procedure para inserir categorias ----------------------------------------------------------------------------------------------------------------- 
drop procedure if exists InserirCategoria;
delimiter $$ 
create procedure InserirCategoria(
	in p_nm_categoria varchar(80)
)
begin 
	declare erro_SQL tinyint default false;
	declare continue handler for sqlexception set erro_SQL = true;
    
	start transaction;
		insert into tbl_Categoria (nm_categoria)
			values (p_nm_categoria);
            
	if(erro_SQL = false) then 
			commit;
				select 'Operação executada com sucesso !!';
	else 
			rollback;
				select 'Ocorreu algum erro ao enviar os registros!';
	end if;
end $$
delimiter ; 

call InserirCategoria ('Corte de Cabelo');

select * from  tbl_Categoria;
---------------------------------------------------------------------------------- fim da procedure para inserir categorias ----------------------------------------------------------------------------------------------------------------- 


---------------------------------------------------------------------------------- procedure para inserir produtos ----------------------------------------------------------------------------------------------------------------- 
drop procedure if exists InserirProduto;
delimiter $$
create procedure InserirProduto(
	in p_id_categoria int,
    in p_nm_produto varchar(80),
    in p_descrição varchar(100),
    in p_vl_preco decimal(6,2)
)
begin 
	declare erro_SQL tinyint default false;
	declare continue handler for sqlexception set erro_SQL = true;
    
    start transaction;
		insert into tbl_produto (id_categoria, nm_produto, descricao, vl_preco)
			values (p_id_categoria, p_nm_produto, p_descrição, p_vl_preco);
            
	if(erro_SQL = false) then 
			commit;
				select 'Operação executada com sucesso !!';
	else 
			rollback;
				select 'Ocorreu algum erro ao enviar os registros!';
	end if;
end $$
delimiter ;

call InserirProduto (1, 'Corte Americano', 'Corte bonito e simples', '50,00');

select * from tbl_produto;
---------------------------------------------------------------------------------- fim da procedure para inserir produtos ----------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------- procedure para inserir Barbearia ----------------------------------------------------------------------------------------------------------------
drop procedure if exists InserirBarbearia;
delimiter $$
create procedure InserirBarbearia(
	in p_nm_barbearia varchar(80),
    in p_endereco varchar(80),
    in p_tel_barbearia char(11)
)
begin
	declare erro_SQL tinyint default false;
	declare continue handler for sqlexception set erro_SQL = true;
    
    start transaction;
		insert into tbl_barbearia (nm_barbearia, endereco, tel_barbearia)
			values (p_nm_barbearia, p_endereco, p_tel_barbearia);
	
    if(erro_SQL = false) then 
			commit;
				select 'Operação executada com sucesso !!';
	else 
			rollback;
				select 'Ocorreu algum erro ao enviar os registros!';
	end if;
end $$
delimiter ;

call InserirBarbearia ('Barbearia Paulista', 'Rua Nsei, 52', '12453678945');

select * from tbl_barbearia;
---------------------------------------------------------------------------------- fim da procedure para inserir barbearia ----------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------- procedure agendamento ----------------------------------------------------------------------------------------------------------------
drop procedure if exists Agendameto;
delimiter $$ 
create procedure Agendameto(
	in p_id_funcionario int,
    in p_id_cliente int,
    in p_data date,
    in p_servico varchar(80)
)
begin 
	declare erro_SQL tinyint default false;
	declare continue handler for sqlexception set erro_SQL = true;
    
    start transaction;
		insert into tbl_agendamento (id_funcionario, id_cliente, data_agendamento, servico)
			values (p_id_funcionario, p_id_cliente, p_data, p_servico);
	
     if(erro_SQL = false) then 
			commit;
				select 'Operação executada com sucesso !!';
	else 
			rollback;
				select 'Ocorreu algum erro ao enviar os registros!';
	end if;
end $$ 
delimiter ;

call Agendameto (1, 1, '2023/1/1' , 'Corte de cabelo');

select * from tbl_Agendamento;
---------------------------------------------------------------------------------- fim da procedure agendamento ----------------------------------------------------------------------------------------------------------------
