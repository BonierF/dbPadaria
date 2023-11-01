show databases;

create database dbPadaria;

use dbPadaria;

create table fornecedores (
    idFornecedor int auto_increment primary key,
    nomeFornecedor varchar (60) not null,
    cnpjFornecedor varchar(20),
    telefoneFornecedor varchar(15),
    emailFornecedor varchar(50) unique not null,
    cep varchar(8),
    enderecoFornecedor varchar(100),
    numeroEndereco int,
    bairro varchar(65),
    cidade varchar(40),
    estado varchar(40)
);

insert into fornecedores (nomeFornecedor, cnpjFornecedor, telefoneFornecedor, emailFornecedor, cep, enderecoFornecedor, numeroEndereco, bairro, cidade, estado) 
values ('DBPAES', '20.460.964/0001-20', '(11) 93756-8381', 'DBPAES@contato.com', 03383-070, 'Rua Inácio Gomes', '216', 'Jardim dos Ipês', 'São Paulo', 'SP');

select * from fornecedores;

create table produtos (
    idProduto int auto_increment primary key,
    nomeProduto varchar(20) NOT NULL,
    descricaoProduto text,
    precoProduto decimal(10,2) not null,
    estoqueProduto int not null,
    categoriaProduto enum('Pães', 'Bolos', 'bebidas', 'Salgados'),
    idFornecedor int,
    foreign key(idFornecedor) references fornecedores(idFornecedor)
);

insert into produtos (nomeProduto, descricaoProduto, precoProduto, estoqueProduto, categoriaProduto, idFornecedor)
VALUES 
    ('Pão Francês', 'Pão tradicional francês', 0.50, 1000, 'Pães', 1),
    ('Bolo de Chocolate', 'Bolo de chocolate delicioso', 5.00, 100, 'Bolos', 1);

select * from produtos where categoriaProduto = 'Pães';

select * from produtos where precoProduto < 50.00 order by precoProduto asc;
drop table clientes;
create table clientes (
    idCliente int auto_increment primary key,
    nomeCliente varchar (20),
    cpfCliente varchar(20) unique not null,
    telefoneCliente varchar(15),
    emailCliente varchar(70) unique,
    cep varchar(20),
    enderecoCliente varchar(40),
    numeroEndereco int,
    bairro varchar(20),
    cidade varchar(20),
    estado varchar(15)
);

insert into clientes (nomeCliente, cpfCliente, telefoneCliente, emailCliente, cep, enderecoCliente, numeroEndereco, bairro, cidade, estado) 
values ('Ester Lima', '668.205.648-64', '(11) 95784-6388', 'ester-lima81@jsagromecanica.com.br', '04124-180', 'Rua Nicolau de Sousa', '319', 'Vila Firmiano Pinto', 'São Paulo', 'SP');

select * from clientes;

create table pedidos (
    idPedido int auto_increment primary key,
    dataPedido timestamp default current_timestamp,
    statusPedido enum('Pendente', 'Finalizado', 'Cancelado'),
    idCliente int,
    foreign key(idCliente) references clientes(idCliente)
);

insert into pedidos (statusPedido, idCliente)
values ('Pendente', 1);

select * from pedidos inner join clientes on pedidos.idCliente = clientes.idCliente;

create table itensPedidos (
	idItensPedidos int primary key auto_increment,
    idPedido int not null,
    idProduto int not null,
    foreign key (idPedido) references pedidos (idPedido),
    foreign key (idProduto) references produtos (idProduto),
	quantidade int not null
);

select idPedido from pedidos;
insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 1, 3);
insert into itensPedidos (idPedido, idProduto, quantidade) values (1, 2, 5);

select * from pedidos inner join clientes on pedidos.idCliente = clientes.idCliente;
select * from itensPedidos inner join pedidos on itensPedidos.idPedido = pedidos.idPedido;
select * from itensPedidos inner join produtos on itensPedidos.idProduto = produtos.idProduto;

select clientes.nomeCliente, pedidos.idPedido, pedidos.dataPedido, itensPedidos.quantidade, produtos.nomeProduto, produtos.precoProduto
from clientes inner join pedidos on clientes.idCliente = pedidos.idCliente inner join
itensPedidos on pedidos.idPedido = itensPedidos.idPedido inner join
produtos on produtos.idProduto = itensPedidos.idProduto;














