/* 63.  Crie uma View contendo os códigos e os nomes dos clientes que moram nos estados de SP ou RJ ou MS. */
CREATE VIEW ESTADOS_CLIENTES
AS
SELECT CODIGO_CLIENTE, NOME_CLIENTE
FROM CLIENTE
WHERE UF IN ('SP', 'RJ', 'MS')

/* 64.  Crie uma View que selecione todos os números dos pedidos, códigos dos clientes e os prazos de entrega dos vendedores que tenham o nome ‘Carlos’. */
CREATE VIEW CLIENTES_CARLOS
AS
SELECT P.NUM_PEDIDO, C.CODIGO_CLIENTE, P.PRAZO_ENTREGA
FROM CLIENTE C INNER JOIN PEDIDO P
	ON C.CODIGO_CLIENTE=P.CODIGO_CLIENTE
	INNER JOIN VENDEDOR V
	ON V.CODIGO_VENDEDOR=P.CODIGO_VENDEDOR
WHERE NOME_VENDEDOR = 'Carlos'

/* 65.  Faça uma View que contenha o número do pedido, código e descrição do produto, quantidade, val_unit e o total (quantidade * val_unit). */
CREATE VIEW VENDA_PRODUTO
AS 
SELECT P.NUM_PEDIDO, PR.CODIGO_PRODUTO, PR.DESCRICAO_PRODUTO, I.QUANTIDADE, PR.VAL_UNIT, I.QUANTIDADE * PR.VAL_UNIT AS total
FROM PEDIDO P INNER JOIN ITEM_DO_PEDIDO I
	ON P.NUM_PEDIDO=I.NUM_PEDIDO
	INNER JOIN PRODUTO PR
	ON PR.CODIGO_PRODUTO=I.CODIGO_PRODUTO

/* 66.  Tendo referencia ao exercício anterior, crie uma visualização que mostre a soma total de cada pedido. */
CREATE VIEW TOTAL_PEDIDO
AS
SELECT NUM_PEDIDO, SUM(TOTAL)
FROM VENDA_PRODUTO
GROUP BY NUM_PEDIDO

/* 67.  Em relação ao exercício anterior desenvolva uma visualização que contenha o Número do Pedido, Código, o Nome e o salário fixo do Vendedor e o Total. */
CREATE VIEW VENDEDOR_PEDIDO
AS
SELECT T.NUM_PEDIDO, V.CODIGO_VENDEDOR, V.NOME_VENDEDOR, V.SALARIO_FIXO, T.SUM
FROM VENDEDOR V INNER JOIN PEDIDO P
	ON V.CODIGO_VENDEDOR=P.CODIGO_VENDEDOR
	INNER JOIN TOTAL_PEDIDO T
	ON P.NUM_PEDIDO=T.NUM_PEDIDO

/* 68.  De acordo com a visualização anterior crie outra visualização que mostre o total vendido por cada vendedor. */
CREATE VIEW TOTAL_VENDEDOR
AS
SELECT CODIGO_VENDEDOR, SUM(SUM)
FROM VENDEDOR_PEDIDO
GROUP BY CODIGO_VENDEDOR

/* 69.  Com base na visualização anterior crie uma consulta que mostre o nome do vendedor, o Salário Fixo, Salário Total que é a 
soma Salário fixo + 5% do total de produto vendidos {Salário Fixo+(Total*0.05)} . Obs: elimine as linhas duplicadas. */
SELECT DISTINCT NOME_VENDEDOR, SALARIO_FIXO, SALARIO_FIXO+(SUM*0.05) AS "salario_total"
FROM TOTAL_VENDEDOR T INNER JOIN VENDEDOR V
	ON T.CODIGO_VENDEDOR=V.CODIGO_VENDEDOR

/* 70.  Mostre os códigos e descrições dos produtos e a soma da quantidade pedida agrupado pelo código e descrição do produto. */
SELECT P.CODIGO_PRODUTO, P.DESCRICAO_PRODUTO, SUM(I.QUANTIDADE)
FROM PRODUTO P INNER JOIN ITEM_DO_PEDIDO I
	ON P.CODIGO_PRODUTO=I.CODIGO_PRODUTO
GROUP BY P.CODIGO_PRODUTO, P.DESCRICAO_PRODUTO