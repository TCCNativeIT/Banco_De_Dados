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
    tel_funcionario CHAR(11),
    disponibilidade ENUM('S', 'N') NOT NULL
);

CREATE TABLE tbl_Agendamento (
    id_agendamento INT PRIMARY KEY AUTO_INCREMENT,
    id_funcionario INT,
    id_cliente INT,
    data_agendamento DATE,
    servico VARCHAR(80),
    status_agendamento ENUM('S', 'N'),
    FOREIGN KEY (id_funcionario) REFERENCES tbl_Funcionario(id_funcionario),
    FOREIGN KEY (id_cliente) REFERENCES tbl_Cliente(id_cliente)
);

