/*
PROCEDURES
Implementar o uso de pelo menos dez procedures:
	Pelo menos três para realizar cadastros;
		# Todas as tabelas tem procedures de criação de linhas
    Pelo menos três para alterar;
		# Alterar email de cliente
        # Alterar preco do produto
		# Alterar quantidade de um produto no carrinho que ainda não virou venda
    Pelo menos três para remover.
        # Remover carrinho
		# Remover item de um carrinho que ainda não virou venda
        # Remover produto do estoque (mas não do carrinho que ainda não virou venda)
*/

DELIMITER $$        
CREATE PROCEDURE cadastroCategoria(IN nome VARCHAR(50))
BEGIN
DECLARE mensagem VARCHAR(50);
DECLARE contagem INT; 
SET contagem = (SELECT COUNT(nome_categoria) FROM categoria WHERE nome = categoria.nome_categoria);
IF contagem = 0 THEN
	INSERT INTO categoria(nome_categoria) VALUES (UPPER(nome));
ELSE 
	SET mensagem = 'A categoria já existe.';
    SELECT mensagem;
END IF;
END $$
DELIMITER ;

CALL cadastroCategoria('perfumaria'); # 1
CALL cadastroCategoria('maquiagem'); # 2
CALL cadastroCategoria('manicure & pedicure'); # 3
CALL cadastroCategoria('skincare'); # 4
CALL cadastroCategoria('cabelo'); # 5
CALL cadastroCategoria('depilação'); # 6
CALL cadastroCategoria('moda íntima'); # 7
CALL cadastroCategoria('bolsas & carteiras'); # 8
CALL cadastroCategoria('acessórios'); # 9
CALL cadastroCategoria('relógios'); # 10

SELECT * FROM categoria;

# ===================================================================

DELIMITER $$        
CREATE PROCEDURE cadastroMarca(IN nome VARCHAR(50))
BEGIN
DECLARE mensagem VARCHAR(50);
DECLARE contagem INT; 
SET contagem = (SELECT COUNT(nome_marca) FROM marca WHERE nome = marca.nome_marca);
IF contagem = 0 THEN
	INSERT INTO marca(nome_marca) VALUES (UPPER(nome));
ELSE 
	SET mensagem = 'A marca já existe.';
    SELECT mensagem;
END IF;
END $$
DELIMITER ;

CALL cadastroMarca('maybelline'); # 1
CALL cadastroMarca('lancôme'); # 2
CALL cadastroMarca('paco rabanne'); # 3
CALL cadastroMarca('alchemia'); # 4
CALL cadastroMarca('dailus'); # 5
CALL cadastroMarca('satinatto'); # 6
CALL cadastroMarca('melissa'); # 7
CALL cadastroMarca('payot'); # 8
CALL cadastroMarca('mary kay'); # 9
CALL cadastroMarca('casio'); # 10
SELECT * FROM marca;

/*
1 PERFUMARIA
	1 PERFUME 2 LANCÔME LA VIE EST BELLE FEMININO EAU DE PARFUM 30ML R$ 369,90
    2 PERFUME 3 PACO RABANNE ONE MILLION MASCULINO EAU DE TOILETTE 200ML R$ 699,90
2 MAQUIAGEM
	3 MÁSCARA DE CÍLIOS THE FALSIES A PROVA D ÁGUA 1 MAYBELLINE R$ 65,90
    4 BATOM LIQUIDO LIFTER GLOSS 1 MAYBELLINE MOON R$ 79,90
3 MANICURE & PEDICURE
	5 CREME DE MÃOS JASMIM 4 ALCHEMIA 45GR R$ 19,90
    6 ESMALTE BASE NUTRITIVA 5 DAILUS BRANCO R$ 13,90
4 SKINCARE
5 CABELO
6 DEPILAÇÃO
7 MODA ÍNTIMA
8 BOLSAS & CARTEIRA
	7 CARTEIRA COM MINI LAPELA E BORDADO DE CORAÇÃO OFF WHITE 6 SATINATTO R$ 59,90
    8 CARTEIRA PEQUENA COM ZÍPER E PUXADOR ROSA 6 SATINATTO R$ 59,90
    9 BOLSA TRANSVERSAL CAMERA BAG COM ALÇA AJUSTÁVEL MARROM 6 SATINATTO R$ 179,90
    10 BOLSA PORTA CELULAR COM BOLSO FRONTAL OFF WHITE 6 SATINATTO R$ 119,90
9 ACESSÓRIOS
10 RELÓGIOS

Outras marcas:
7 MELISSA
8 PAYOT
9 MARY KAY
10 CASIO
*/

# ===================================================================

DELIMITER $$        
CREATE PROCEDURE cadastroProduto(IN marca INT, nome VARCHAR(50), categoria INT, estoque INT, preco FLOAT)
BEGIN
DECLARE mensagem VARCHAR(100);
DECLARE contagem INT; 
SET contagem = (SELECT COUNT(nome_produto) FROM produto WHERE (nome = produto.nome_produto AND marca = produto.id_marca));
IF contagem = 0 AND estoque > 0 AND preco > 0 THEN
	INSERT INTO produto(id_marca, nome_produto, id_categoria, estoque, preco) VALUES (marca, UPPER(nome), categoria, estoque, preco);
ELSE 
	SET mensagem = 'O produto já existe ou você inseriu dados inválidos de estoque e preço';
    SELECT mensagem;
END IF;
END $$
DELIMITER ;
# marca, nome, categoria, estoque, preco
CALL cadastroProduto(2, 'PERFUME LA VIE EST BELLE FEMININO', 1, 30, 369.00);
CALL cadastroProduto(3, 'PERFUME ONE MILLION EAU DE TOILETTE', 1, 15, 699.00);
CALL cadastroProduto(1, 'MÁSCARA DE CÍLIOSA PROVA D ÁGUA', 2, 100, 65.90);
CALL cadastroProduto(1, 'BATOM LIQUIDO LIFTER GLOSS MOON', 2, 80, 79.90);
CALL cadastroProduto(4, 'CREME DE MÃOS JASMIM 45GR', 3, 500, 19.90);
CALL cadastroProduto(5, 'ESMALTE BASE NUTRITIVA BRANCO', 3, 500, 13.90);
CALL cadastroProduto(6, 'CARTEIRA COM BORDADO DE CORAÇÃO', 8, 100, 59.90);
CALL cadastroProduto(6, 'CARTEIRA PEQUENA COM ZÍPER ROSA', 8, 200, 59.90);
CALL cadastroProduto(6, 'BOLSA TRANSVERSAL COM ALÇA AJUSTÁVEL', 8, 70, 179.90);
CALL cadastroProduto(6, 'BOLSA PORTA CELULAR COM BOLSO FRONTAL', 8, 120, 119.90);
SELECT * FROM produto; 

# ===================================================================

DELIMITER $$        
CREATE PROCEDURE cadastroCliente(IN nome VARCHAR(100), email VARCHAR(50))
BEGIN
DECLARE mensagem VARCHAR(100);
DECLARE contagem INT;  
SET contagem = (SELECT COUNT(email) FROM cliente WHERE email = cliente.email);
IF contagem = 0 AND email LIKE '%@%' AND LENGTH(nome) > 5 THEN
	INSERT INTO cliente(nome_cliente, email) VALUES (UPPER(nome), UPPER(email));
ELSE 
	SET mensagem = 'O cliente já existe ou você inseriu dados inválidos';
    SELECT mensagem;
END IF;
END $$
DELIMITER ;

CALL cadastroCliente('ana carolina', 'ana@email.com');
CALL cadastroCliente('Beatriz Almeida', 'bea@email.com');
CALL cadastroCliente('Camila de Souza', 'cami@email.com');
CALL cadastroCliente('Diana Prince', 'diana@email.com');
CALL cadastroCliente('Ester Oliveira', 'ester@email.com');
CALL cadastroCliente('Fernanda Coelho', 'coelho@email.com');
CALL cadastroCliente('Gabriela Mendes', 'gabriela@email.com');
CALL cadastroCliente('Helena Souza', 'helena@email.com');
CALL cadastroCliente('ISADORA PEIXOTO', 'isa@email.com');

SELECT * FROM cliente; 

# ===================================================================

DELIMITER $$        
CREATE PROCEDURE cadastroCarrinho(IN cliente INT)
BEGIN
	INSERT INTO carrinho(id_cliente) VALUES (cliente);
END $$
DELIMITER ;

CALL cadastroCarrinho(1);
CALL cadastroCarrinho(2);
CALL cadastroCarrinho(3);
CALL cadastroCarrinho(3);
CALL cadastroCarrinho(1);
CALL cadastroCarrinho(1);
CALL cadastroCarrinho(4);
CALL cadastroCarrinho(5);
CALL cadastroCarrinho(6);
CALL cadastroCarrinho(1);
# Cliente 1: 4 carrinhos
# Cliente 2: 1 carrinho
# Cliente 3: 2 carrinhos
# Cliente 4: 1 carrinho
# Cliente 5: 1 carrinho
# Cliente 6: 1 carrinho
SELECT * FROM carrinho;
SELECT * FROM clientesCarrinhos;

# ===================================================================

DELIMITER $$        
CREATE PROCEDURE cadastroItensCarrinho(IN cod_carrinho INT, cod_produto INT, quantidade INT)
BEGIN
	DECLARE total FLOAT;
    SET total = quantidade * (SELECT preco FROM produto WHERE produto.id_produto = cod_produto);
	INSERT INTO itensCarrinho(id_carrinho, id_produto, quantidade, valor) VALUES (cod_carrinho, cod_produto, quantidade, total);
END $$
DELIMITER ;
#						   c, p, q
CALL cadastroItensCarrinho(1, 1, 1); # Carrinho 1, Produto 1, Quantidade 1;
CALL cadastroItensCarrinho(1, 5, 2); # Carrinho 1, Produto 5, Quantidade 2;
CALL cadastroItensCarrinho(2, 3, 1); # Carrinho 2, Produto 3, Quantidade 1;
CALL cadastroItensCarrinho(2, 6, 3); # Carrinho 2, Produto 6, Quantidade 3;
CALL cadastroItensCarrinho(3, 8, 1); # Carrinho 3, Produto 8, Quantidade 1;
CALL cadastroItensCarrinho(4, 8, 1); # Carrinho 4, Produto 8, Quantidade 1;

SELECT * FROM itensCarrinho; 
SELECT * FROM descricaoItensCarrinho;

# ===================================================================

DELIMITER $$        
CREATE PROCEDURE cadastroMetodoDePagamento(IN nome VARCHAR(50))
BEGIN
DECLARE mensagem VARCHAR(50);
DECLARE contagem INT; 
SET contagem = (SELECT COUNT(nome_pagamento) FROM metodoDePagamento WHERE nome = metodoDePagamento.nome_pagamento);
IF contagem = 0 THEN
	INSERT INTO metodoDePagamento(nome_pagamento) VALUES (UPPER(nome));
ELSE 
	SET mensagem = 'O método de pagamento já existe.';
    SELECT mensagem;
END IF;
END $$
DELIMITER ;

CALL cadastroMetodoDePagamento('cartão');
CALL cadastroMetodoDePagamento('boleto');
CALL cadastroMetodoDePagamento('pix');
SELECT * FROM metodoDePagamento;

# ===================================================================

DELIMITER %%
CREATE PROCEDURE atualizaCarrinhoParaVenda(IN cod_carrinho INT)
BEGIN 
	UPDATE carrinho SET venda_realizada = TRUE WHERE cod_carrinho = id_carrinho;
END %%
DELIMITER ;

# ===================================================================

DELIMITER %%
CREATE PROCEDURE cadastroVenda(IN cod_carrinho INT, cod_pagamento INT)
BEGIN 
	DECLARE total_a_pagar FLOAT;
    SET total_a_pagar = (SELECT SUM(valor) FROM itensCarrinho ic WHERE ic.id_carrinho = cod_carrinho); 
    CALL atualizaCarrinhoParaVenda(cod_carrinho);
	INSERT INTO venda(id_carrinho, id_pagamento, total, data_e_hora) VALUES (cod_carrinho, cod_pagamento, total_a_pagar, (SELECT NOW()));
END %%
DELIMITER ;

CALL cadastroVenda(2, 1);
CALL cadastroVenda(3, 1);

SELECT * FROM venda;
SELECT * FROM carrinho;

/*
Pelo menos três para alterar;
		# Alterar nome e email de cliente
        # Alterar preco do produto
		# Alterar quantidade de um produto no carrinho
Pelo menos três para remover.
		# Remover produto de um carrinho que ainda não virou venda
        # Remover produto (do estoque e do carrinho que ainda não virou venda)
        # Remover carrinho
*/

DELIMITER &&
CREATE PROCEDURE alteraEmailCliente(IN email_atual VARCHAR(50), novo_email VARCHAR(50))
BEGIN 
	DECLARE quantidade INT;
	DECLARE mensagem VARCHAR(100);
	SELECT COUNT(*) INTO quantidade FROM cliente WHERE email = email_atual;
    IF quantidade > 0 THEN  
		UPDATE cliente SET email = novo_email WHERE email = email_atual;
	    SET mensagem = 'O e-mail foi alterado com sucesso';
	ELSE
        SET mensagem = 'O e-mail não existe e portanto não pode ser alterado';
    END IF;
    SELECT mensagem;	
END &&
DELIMITER ;

DELIMITER &&
CREATE PROCEDURE alteraPrecoProduto(IN cod_produto INT, novo_preco FLOAT)
BEGIN 
	DECLARE quantidade INT;
	DECLARE mensagem VARCHAR(100);
	SELECT COUNT(*) INTO quantidade FROM produto WHERE id_produto = cod_produto;
    IF quantidade > 0 THEN  
		UPDATE produto SET preco = novo_preco WHERE id_produto = cod_produto;
	    SET mensagem = 'O preço foi alterado com sucesso';
	ELSE
        SET mensagem = 'O produto não existe e portanto não pode ter seu preço alterado';
    END IF;
    SELECT mensagem;	
END &&
DELIMITER ;

DELIMITER &&
CREATE PROCEDURE alteraQuantidadeNoCarrinho(IN cod_carrinho INT, cod_produto INT, nova_quantidade INT)
BEGIN 
	DECLARE quantidade INT;
	DECLARE mensagem VARCHAR(100);
    DECLARE eVenda INT;
	SELECT COUNT(*) INTO quantidade FROM itensCarrinho WHERE id_carrinho = cod_carrinho AND id_produto = cod_produto;
    SELECT venda_realizada INTO eVenda FROM carrinho WHERE cod_carrinho = id_carrinho;
    IF quantidade > 0 AND eVenda = 0 THEN  
		UPDATE itensCarrinho SET quantidade = nova_quantidade WHERE id_carrinho = cod_carrinho AND id_produto = cod_produto;
	    SET mensagem = 'A quantidade do produto selecionado foi alterada no carrinho';
	ELSE
        SET mensagem = 'A quantidade do produto selecionado não pôde ser alterada';
    END IF;
    SELECT mensagem;	
END &&
DELIMITER ;

DELIMITER &&
CREATE PROCEDURE removeCarrinho(IN cod_carrinho INT)
BEGIN 
	DECLARE quantidade INT;
	DECLARE mensagem VARCHAR(100);
	SELECT COUNT(*) INTO quantidade FROM carrinho WHERE id_carrinho = cod_carrinho;
    IF quantidade > 0 THEN  
		DELETE FROM carrinho WHERE id_carrinho = cod_carrinho;
	    SET mensagem = 'O carrinho foi removido';
	ELSE
        SET mensagem = 'O carrinho não foi encontrado';
    END IF;
    SELECT mensagem;	
END &&
DELIMITER ;

DELIMITER &&
CREATE PROCEDURE removeItemCarrinho(IN cod_carrinho INT, cod_produto INT)
BEGIN 
	DECLARE encontraCarrinho INT;
    DECLARE encontraProduto INT;
    DECLARE eVenda INT;
    DECLARE mensagem VARCHAR(100);
    SELECT venda_realizada INTO eVenda FROM carrinho WHERE cod_carrinho = id_carrinho;
	SELECT COUNT(*) INTO encontraCarrinho FROM itensCarrinho WHERE id_carrinho = cod_carrinho;
    SELECT COUNT(*) INTO encontraProduto FROM itensCarrinho WHERE id_produto = cod_produto;
    IF encontraCarrinho > 0 AND encontraProduto > 0 AND eVenda = 0 THEN  
		DELETE FROM itensCarrinho WHERE id_produto = cod_produto;
	    SET mensagem = 'O produto foi removido do carrinho';
	ELSE
        SET mensagem = 'O produto ou o carrinho não puderam ser encontrados';
    END IF;
    SELECT mensagem;	
END &&
DELIMITER ;

DELIMITER &&
CREATE PROCEDURE removeProdutoDoEstoque(IN cod_produto INT)
BEGIN 
# Se o produto estiver num carrinho, não poderá ser removido.
	DECLARE encontraCarrinho INT;
    DECLARE encontraProduto INT;
    DECLARE mensagem VARCHAR(100);
	SELECT COUNT(*) INTO encontraCarrinho FROM itensCarrinho WHERE id_carrinho = cod_carrinho;
    SELECT COUNT(*) INTO encontraProduto FROM produto WHERE id_produto = cod_produto;
    IF encontraCarrinho = 0 AND encontraProduto > 0 THEN  
		DELETE FROM produto WHERE id_produto = cod_produto;
	    SET mensagem = 'O produto foi removido do estoque';
	ELSE
        SET mensagem = 'O produto não pôde ser removido porque não foi encontrado ou porque está em um carrinho';
    END IF;
    SELECT mensagem;	
END &&
DELIMITER ;


