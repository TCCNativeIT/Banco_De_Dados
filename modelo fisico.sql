---------------------------------------------------------------------------------- criando o banco de dados ----------------------------------------------------------------------------------------------------------------
CREATE DATABASE db_Barbearia;
USE db_Barbearia;
---------------------------------------------------------------------------------- banco de dados criado ----------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------- criando tabelas ----------------------------------------------------------------------------------------------------------------
CREATE TABLE tbl_Categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nm_categoria VARCHAR(80) NOT NULL
);

CREATE TABLE tbl_Produto (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    id_categoria INT,
    nm_produto VARCHAR(80) NOT NULL,
    qte_estoque int, 
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

create table tbl_Venda(
	id_venda int primary key auto_increment,
	id_cli int,
	vl_total decimal(10,2),
	foreign key(id_cli) references tbl_Cliente(id_cliente)
);

create table tbl_itensVenda(
	id_itensVenda int primary key auto_increment,
	id_venda int not null,
	id_produto int not null,
	qtde_vendida int,
	vl_venda decimal(10,2),
	foreign key(id_venda) references tbl_Venda(id_venda),
	foreign key(id_produto) references tbl_Produto(id_produto)
);
---------------------------------------------------------------------------------- tabelas criadas com sucesso ----------------------------------------------------------------------------------------------------------------



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
    in p_qte_estoque int,
    in p_vl_preco decimal(6,2)
)
begin 
	declare erro_SQL tinyint default false;
	declare continue handler for sqlexception set erro_SQL = true;
    
    start transaction;
		insert into tbl_produto (id_categoria, nm_produto, descricao, qte_estoque, vl_preco)
			values (p_id_categoria, p_nm_produto, p_descrição, p_qte_estoque, p_vl_preco);
            
	if(erro_SQL = false) then 
			commit;
				select 'Operação executada com sucesso !!';
	else 
			rollback;
				select 'Ocorreu algum erro ao enviar os registros!';
	end if;
end $$
delimiter ;

call InserirProduto (1, 'Corte Americano', 'Corte bonito e simples', '80', '50.00');

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


---------------------------------------------------------------------------------- procedure para inserir venda ----------------------------------------------------------------------------------------------------------------
drop procedure if exists InserirVenda;
delimiter $$ 
create procedure InserirVenda (
	in p_id_cliente int, 
    in p_vl_total decimal(10,2)
)
begin 
	declare erro_SQL tinyint default false;
	declare continue handler for sqlexception set erro_SQL = true;
    
    start transaction; 
		insert into tbl_Venda (id_cli, vl_total)
			values (p_id_cliente, p_vl_total);
	
    if(erro_SQL = false) then 
			commit;
				select 'Operação executada com sucesso !!';
	else 
			rollback;
				select 'Ocorreu algum erro ao enviar os registros!';
	end if;
end $$
delimiter ;

call InserirVenda (1, '50.00');

select * from tbl_Venda;
---------------------------------------------------------------------------------- fim da procedure InserirVenda ----------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------- procedure para inserir intens da venda ----------------------------------------------------------------------------------------------------------------
drop procedure if exists InserirItens;
delimiter $$
create procedure InserirItens(
	in p_id_venda int,
    in p_id_produto int,
    in p_qtde_vendida int,
    in p_vl_venda decimal(10,2)
)
begin 
	declare erro_SQL tinyint default false;
	declare continue handler for sqlexception set erro_SQL = true;
    
	start transaction;
		insert into tbl_itensVenda (id_venda, id_produto, qtde_vendida, vl_venda)
			values (p_id_venda, p_id_produto, p_qtde_vendida, p_vl_venda);
            
	if(erro_SQL = false) then 
			commit;
				select 'Operação executada com sucesso !!';
	else 
			rollback;
				select 'Ocorreu algum erro ao enviar os registros!';
	end if;
end $$
delimiter ;

call InserirItens (1, 1, '45', '50.00' );

select * from tbl_itensVenda;
---------------------------------------------------------------------------------- fim procedure InserirItens ----------------------------------------------------------------------------------------------------------------


---------------------------------------------------------------------------------- trigger para dar baixa no estoque ----------------------------------------------------------------------------------------------------------------

drop trigger if exists tgi_BaixaProd;
delimiter $$
create trigger tgi_BaixaProd after insert 
	on tbl_itensVenda for each row 
begin 
	update tbl_Produto set qte_estoque = (qte_estoque - new.qtde_vendida)
		where id_produto = new.id_produto;
end $$
delimiter ; 

select * from tbl_produto;
---------------------------------------------------------------------------------- fim trigger ----------------------------------------------------------------------------------------------------------------
