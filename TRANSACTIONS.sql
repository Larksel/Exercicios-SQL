/* 1. Faça uma transação que atualize o valor do campo “unidade” para “Cm” do produto de código 22 e 
atualize o campo “faixa de comissão” para “A” do código do vendedor igual a 209. 
Escreva se as alterações foram executadas corretamente.*/
BEGIN;
	UPDATE PRODUTO
	SET UNIDADE = 'Cm'
	WHERE CODIGO_PRODUTO = 22;
	
	UPDATE VENDEDOR
	SET FAIXA_COMISSAO = 'A'
	WHERE CODIGO_VENDEDOR = 209;
COMMIT;

/* 3. */
BEGIN;
	INSERT INTO PRODUTO (CODIGO_PRODUTO, DESCRICAO_PRODUTO, UNIDADE, QUANT_EST)
		VALUES (50, 'Notebook', 'uni', 500);
	SAVEPOINT parte1;
	INSERT INTO PRODUTO (CODIGO_PRODUTO, DESCRICAO_PRODUTO, UNIDADE, QUANT_EST)
		VALUES (51, 'Mouse', 'uni', 500);
	SAVEPOINT parte2;
	INSERT INTO PRODUTO (CODIGO_PRODUTO, DESCRICAO_PRODUTO, UNIDADE, QUANT_EST)
		VALUES (52, 'Teclado', 'uni', 500);
	SELECT * FROM PRODUTO;
	ROLLBACK TO parte1;
	SELECT * FROM PRODUTO;
ROLLBACK;
BEGIN;
	SELECT * FROM PRODUTO;
	INSERT INTO PRODUTO (CODIGO_PRODUTO, DESCRICAO_PRODUTO, UNIDADE, QUANT_EST)
		VALUES (50, 'Notebook', 'uni', 500);
	SAVEPOINT parte1;
	INSERT INTO PRODUTO (CODIGO_PRODUTO, DESCRICAO_PRODUTO, UNIDADE, QUANT_EST)
		VALUES (51, 'Mouse', 'uni', 500);
	SAVEPOINT parte2;
	INSERT INTO PRODUTO (CODIGO_PRODUTO, DESCRICAO_PRODUTO, UNIDADE, QUANT_EST)
		VALUES (52, 'Teclado', 'uni', 500);
	ROLLBACK TO parte2;
COMMIT;

SELECT * FROM PRODUTO;
