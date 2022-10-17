CREATE SCHEMA IF NOT EXISTS `avaliacao_banco_de_dados_17102022`;

/*
Tema livre, modele uma aplicação contendo entre 8 e 10 tabelas, disponibilize a imagem da modelagem e 
a estrutura SQL de criação das tabelas. Também será necessário implementar e disponibilizar os 
seguintes códigos SQL:
Tabelas: 
- produto (id, marca(fk), nome, categoria(fk), quantidade, preco)
- categoria (id, nome)
- marca (id, nome)
- cliente (id, nome, email)
- carrinho (id, cliente_id(fk))
- itensCarrinho (id_carrinho(fk), produto_id(fk), quantidade)
- metodoDePagamento (id, descricao)
- venda (id, id_carrinho(fk), metodo_de_pagamento(fk), data_e_hora)
*/

CREATE TABLE IF NOT EXISTS categoria (
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
	nome_categoria VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS marca (
	id_marca INT PRIMARY KEY AUTO_INCREMENT,
	nome_marca VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS produto (
	id_produto INT PRIMARY KEY AUTO_INCREMENT,
	id_marca INT,
		CONSTRAINT id_marca
		FOREIGN KEY (id_marca) REFERENCES marca(id_marca),
	nome_produto VARCHAR(50),
	id_categoria INT,
		CONSTRAINT id_categoria
		FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria),
	estoque INT,
	preco FLOAT
);

CREATE TABLE IF NOT EXISTS cliente (
	id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome_cliente VARCHAR(100),
    email VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS carrinho (
	id_carrinho INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
		CONSTRAINT id_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
	venda_realizada BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS itensCarrinho (
	id_carrinho INT,
		CONSTRAINT fk_id_carrinho
        FOREIGN KEY (id_carrinho) REFERENCES carrinho(id_carrinho),
    id_produto INT,
		CONSTRAINT id_produto
        FOREIGN KEY (id_produto) REFERENCES produto(id_produto),
	quantidade INT,
    valor FLOAT
);

CREATE TABLE IF NOT EXISTS metodoDePagamento (
	id_pagamento INT PRIMARY KEY AUTO_INCREMENT,
    nome_pagamento VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS venda (
	id_venda INT PRIMARY KEY AUTO_INCREMENT,
    id_carrinho INT UNIQUE,
		CONSTRAINT id_carrinho
        FOREIGN KEY (id_carrinho) REFERENCES carrinho(id_carrinho),
    id_pagamento INT,
		CONSTRAINT id_pagamento
        FOREIGN KEY (id_pagamento) REFERENCES metodoDePagamento(id_pagamento),
	total FLOAT,
    data_e_hora DATETIME
);

