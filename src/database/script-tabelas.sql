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

INSERT INTO empresa (razao_social,cnpj,codigo_ativacao) VALUES 
	('Casa dos Doces ltda',29882547000140,'MAP18'),
    ('Haddock Doces ltda',45238216000128,'HDK23'),
    ('Pane Dolce ltd',37154250000196,'TKS24');

CREATE TABLE usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50),
email VARCHAR(50),
senha VARCHAR(50),
fk_empresa INT,
FOREIGN KEY (fk_empresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO usuario (nome,email,senha,fk_empresa) VALUES
	('Geraldo Marcelo','geraldo.marcelo@casadoces.com','!Geraldo123',1),
    ('Marcela Torres','marcela.torres@casadoces.com','!Marcela123',1),
    ('Rebeca Monteiro','rebeca.monteiro@haddockdoces.com','!Rebeca123',2),
    ('Jorge Henrique','jorge.henrique@haddockdoces.com','!Jorge123',2),
    ('Alê Santana','ale.santana@panedolce.com','!Ale123',3),
    ('Gisele Pontes','gisele.pontes@panedolce.com','!Gisele123',3);

create table armazem (
/* em nossa regra de negócio, um armazem tem apenas um sensor */
	idArmazem INT PRIMARY KEY AUTO_INCREMENT,
	fk_empresa INT,
    cep CHAR(8),
	numCep INT,
    complemento CHAR(50),
	FOREIGN KEY (fk_empresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO armazem (fk_empresa,cep,numCep,complemento) VALUES
    (1,38705354,925,'3º andar'),
    (2,20260142,255,'Terraço - Torre 1'),
    (2,20260142,950,''),
    (3,26088005,12,''),
    (3,22041030,56,'1º andar'),
    (3,25675321,19,'');

CREATE TABLE produto (
	idProduto INT PRIMARY KEY AUTO_INCREMENT,
	preco DECIMAL(5,2),
	sabor VARCHAR(150),
	qtdProdutos INT,
    fk_armazem INT,
	FOREIGN KEY (fk_armazem) REFERENCES armazem(idArmazem)
);

CREATE TABLE medida (
	idMedida INT PRIMARY KEY AUTO_INCREMENT,
	fk_produto INT,
    dht11_umidade DECIMAL(5,2),
	dht11_temperatura DECIMAL(5,2),
	registro DATETIME,
	FOREIGN KEY (fk_produto) REFERENCES produto(idProduto)
);

CREATE TABLE pedido (
idPedido INT,
pk_usuario INT,
pk_produto INT,
titulo VARCHAR(70),
hrPedido DATETIME default current_timestamp,
hrEntrega DATETIME,
statuss TINYINT(2),
nomeCliente VARCHAR(45),
	CONSTRAINT chkStatus CHECK (statuss IN (0,1)),
    PRIMARY KEY (idPedido,pk_usuario, pk_produto),
    FOREIGN KEY (pk_usuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (pk_produto) REFERENCES produto(idProduto)
);

