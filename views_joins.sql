/* 
Implementar ao menos cinco views com inner join;
	Necessário pelo menos dois inner joins contemplando duas tabelas;
    Necessário pelo menos mais dois inner joins contemplando três tabelas;
    Necessário pelo menos um inner join contemplando cinco tabelas ou mais. # VENDA
Criar uma view com Left Join;
Criar uma view com Right Join; PRODUTOS MARCAS
*/

SELECT * FROM cliente; # Criar view que mostra os carrinhos e vendas de cada cliente :)
					   # Criar view que mostra os produtos que cada cliente tem no carrinho :)
SELECT * FROM carrinho; # Criar view que mostre o nome do cliente :)
SELECT * FROM itensCarrinho; # Criar uma view que mostra os nomes dos produtos e o nome e email dos clientes
CALL cadastroVenda(1, 2); # Criar view que mostra o nome do método de pagamento, o nome do cliente
						  # Criar trigger que gera o valor total e a hora :)

# Criar view que mostra o nome da categoria e o nome da marca :)
CREATE VIEW produtoCategoriaMarca AS SELECT
p.id_produto, p.nome_produto, c.nome_categoria, m.nome_marca FROM
(produto p
INNER JOIN categoria c ON p.id_categoria = c.id_categoria
INNER JOIN marca m ON p.id_marca = m.id_marca);

SELECT * FROM produtoCategoriaMarca;

# ================================================

# Criar view que mostra os carrinhos de cada cliente :)
CREATE VIEW clientesCarrinhos AS SELECT
car.id_carrinho, c.id_cliente, c.nome_cliente, c.email, car.venda_realizada FROM
cliente c
LEFT JOIN carrinho car ON c.id_cliente = car.id_cliente
ORDER BY c.email;

SELECT * FROM clientesCarrinhos;

# ================================================

# Criar uma view com mais detalhes do carrinho :)
CREATE VIEW descricaoItensCarrinho AS SELECT
car.id_carrinho, p.nome_produto, ic.quantidade FROM
(carrinho car 
INNER JOIN itensCarrinho ic ON car.id_carrinho = ic.id_carrinho
INNER JOIN produto p ON p.id_produto = ic.id_produto) ORDER BY car.id_carrinho;

SELECT * FROM descricaoItensCarrinho;

# ================================================

# Criar view com descrição completa da venda
CREATE VIEW descricaoVenda AS SELECT
v.id_venda, v.data_e_hora, car.id_carrinho, c.nome_cliente, c.email, mp.nome_pagamento, v.total
FROM (carrinho car
INNER JOIN venda v ON v.id_carrinho = car.id_carrinho
INNER JOIN cliente c ON c.id_cliente = car.id_carrinho
INNER JOIN metodoDePagamento mp ON mp.id_pagamento = v.id_pagamento) ORDER BY v.id_venda;

SELECT * FROM descricaoVenda;

# ================================================

# Criar view com produtos e suas respectivas categorias
CREATE VIEW produtosCategorias AS SELECT
p.id_produto, p.nome_produto, c.nome_categoria FROM produto p
RIGHT JOIN categoria c ON p.id_categoria = c.id_categoria
ORDER BY p.id_produto IS NULL;

SELECT * FROM produtosCategorias;



