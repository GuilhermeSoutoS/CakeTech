-- Arquivo de apoio, caso você queira criar tabelas como as aqui criadas para a API funcionar.
-- Você precisa executar os comandos no banco de dados para criar as tabelas,
-- ter este arquivo aqui não significa que a tabela em seu BD estará como abaixo!

/*
comandos para mysql server
*/

CREATE DATABASE caketech;

USE caketech;

CREATE TABLE empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
razao_social VARCHAR(50),
cnpj CHAR(14),
codigo_ativacao VARCHAR(50)
);

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50),
email VARCHAR(50),
senha VARCHAR(50),
fk_empresa INT,
FOREIGN KEY (fk_empresa) REFERENCES empresa(idEmpresa)
);

create table armazem (
/* em nossa regra de negócio, um armazem tem apenas um sensor */
	idArmazem INT PRIMARY KEY AUTO_INCREMENT,
	fk_empresa INT,
    cep CHAR(8),
	numCep INT,
    complemento CHAR(50),
	FOREIGN KEY (fk_empresa) REFERENCES empresa(idEmpresa)
);


CREATE TABLE produto (
	idProduto INT PRIMARY KEY AUTO_INCREMENT,
	preco DECIMAL(5,2),
	sabor VARCHAR(150),
	qtdProdutos INT,
    fk_armazem INT,
	FOREIGN KEY (fk_armazem) REFERENCES armazem(idArmazem)
);

-- ALTER TABLE produto MODIFY COLUMN preco DECIMAL(5,2);

create table medida (
	idMedida INT PRIMARY KEY AUTO_INCREMENT,
	fk_produto INT,
    dht11_umidade DECIMAL(3,2),
	dht11_temperatura DECIMAL(3,2),
	registro DATETIME,
	FOREIGN KEY (fk_produto) REFERENCES produto(idProduto)
);

create table pedido (
idPedido INT,
pk_usuario INT,
pk_pedido INT,
titulo VARCHAR(70),
hrPedido DATETIME default current_timestamp,
hrEntrega DATETIME,
statuss TINYINT(2),
nomeCliente VARCHAR(45),
	CONSTRAINT chkStatus CHECK (statuss IN (0,1)),
    PRIMARY KEY (idPedido,pk_usuario, pk_pedido),
    FOREIGN KEY (pk_usuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (pk_pedido) REFERENCES pedido(idPedido)
);

