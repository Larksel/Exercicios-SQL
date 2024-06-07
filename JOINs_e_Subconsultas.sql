/* 51.  Encontre os nomes dos clientes (ordenados) atendidos pelo vendedor ‘Antônio’. */
SELECT C.NOME_CLIENTE, V.NOME_VENDEDOR
FROM CLIENTE C INNER JOIN PEDIDO P
	ON C.CODIGO_CLIENTE=P.CODIGO_CLIENTE
	INNER JOIN VENDEDOR V
	ON P.CODIGO_VENDEDOR=V.CODIGO_VENDEDOR
WHERE V.NOME_VENDEDOR = 'Antônio'
ORDER BY NOME_CLIENTE

/* 52.  Mostre os clientes (ordenados) que têm prazo de entrega maior que 15 dias para o produto ‘Queijo’ e sejam do estado de Rio de Janeiro. */
SELECT C.*
FROM CLIENTE C INNER JOIN PEDIDO P
	ON C.CODIGO_CLIENTE=P.CODIGO_CLIENTE
	INNER JOIN ITEM_DO_PEDIDO I
	ON P.NUM_PEDIDO=I.NUM_PEDIDO
	INNER JOIN PRODUTO PR
	ON I.CODIGO_PRODUTO=PR.CODIGO_PRODUTO
WHERE P.PRAZO_ENTREGA >= 15 AND
C.UF = 'RJ' AND
PR.DESCRICAO_PRODUTO = 'Queijo'
ORDER BY C.NOME_CLIENTE

/* 53.  Selecionem os códigos e os nomes dos clientes, e seus respectivos prazos de entrega dos pedidos de todos os clientes que fizeram ou não pedidos. */
SELECT DISTINCT C.CODIGO_CLIENTE, C.NOME_CLIENTE, P.PRAZO_ENTREGA
FROM CLIENTE C LEFT JOIN PEDIDO P
	ON C.CODIGO_CLIENTE=P.CODIGO_CLIENTE

/* 54.  Crie uma consulta que liste o código, o nome e o número do pedido que foram realizados por todos os vendedores. */
SELECT V.CODIGO_VENDEDOR, V.NOME_VENDEDOR, P.NUM_PEDIDO
FROM VENDEDOR V INNER JOIN PEDIDO P
	ON V.CODIGO_VENDEDOR=P.CODIGO_VENDEDOR

/* 55.  Relacionem todos os produtos que participaram ou não de algum pedido. (Liste o código e o nome do produto, o número do pedido e a quantidade vendida). */
SELECT P.CODIGO_PRODUTO, P.DESCRICAO_PRODUTO, I.NUM_PEDIDO, I.QUANTIDADE
FROM PRODUTO P LEFT JOIN ITEM_DO_PEDIDO I
	ON P.CODIGO_PRODUTO=I.CODIGO_PRODUTO

/* 56.   Selecione os nomes dos clientes de qualquer pedido cujo prazo de entrega seja maior do que 25 dias. (resolva utilizando subconsultas) */
SELECT NOME_CLIENTE
FROM CLIENTE
WHERE CODIGO_CLIENTE NOT IN (
	SELECT CODIGO_CLIENTE
	FROM PEDIDO
	WHERE PRAZO_ENTREGA >= 25
)

/* 57.  Liste os clientes que não fizeram nenhum pedido. */
SELECT *
FROM CLIENTE
WHERE CODIGO_CLIENTE NOT IN (
	SELECT CODIGO_CLIENTE						 
	FROM PEDIDO
)

/* 58.  Selecione a descrição dos produtos que possuem o valor unitário abaixo da média. */
SELECT DESCRICAO_PRODUTO
FROM PRODUTO
WHERE VAL_UNIT < (
	SELECT AVG(VAL_UNIT)
	FROM PRODUTO
)

/* 59.  Encontre os códigos dos clientes que possuem o prazo de entrega acima da média. */
SELECT CODIGO_CLIENTE, PRAZO_ENTREGA
FROM PEDIDO
WHERE PRAZO_ENTREGA >= (
	SELECT AVG(PRAZO_ENTREGA)
	FROM PEDIDO
)

/* 60.  Encontre os nomes dos clientes que possuem o prazo de entrega acima da média. */
SELECT NOME_CLIENTE
FROM CLIENTE
WHERE CODIGO_CLIENTE IN (
	SELECT CODIGO_CLIENTE
	FROM PEDIDO
	WHERE PRAZO_ENTREGA >= (
		SELECT AVG(PRAZO_ENTREGA)
		FROM PEDIDO
	)
)


/* 61.  Selecione a descrição do produto que teve a maior quantidade pedida. */
SELECT DESCRICAO_PRODUTO
FROM PRODUTO
WHERE CODIGO_PRODUTO IN (
	SELECT CODIGO_PRODUTO
	FROM ITEM_DO_PEDIDO
	WHERE QUANTIDADE = (
		SELECT MAX(QUANTIDADE)
		FROM ITEM_DO_PEDIDO
	)
)

/* 62.  Exiba os nomes dos clientes que fizeram pedidos cuja quantidade do item pedido seja maior que sua média. */
SELECT NOME_CLIENTE
FROM CLIENTE
WHERE CODIGO_CLIENTE IN (
	SELECT CODIGO_CLIENTE
	FROM PEDIDO
	WHERE NUM_PEDIDO IN (
		SELECT NUM_PEDIDO
		FROM ITEM_DO_PEDIDO
		WHERE QUANTIDADE > (
			SELECT AVG(QUANTIDADE)
			FROM ITEM_DO_PEDIDO
		)
	)
)