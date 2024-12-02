/* 74. Desenvolva um Trigger que ao ser excluído um registro da tabela produto 
apareça uma mensagem que os dados do produto foram excluídos com sucesso*/
CREATE TRIGGER EX74
ON PRODUTO
FOR DELETE
AS
PRINT('Produto excluído com sucesso');

select * from produto;
insert into produto (codigo_produto, unidade, descricao_produto, val_unit, quant_est)
	values (55, 'G', 'Da boa', 500, 550);

delete produto where codigo_produto = 55;

/* 75. Desenvolver um Trigger que ao ser alterado o salário do Vendedor insira o salário antigo na tabela histórico do salário.*/
CREATE TRIGGER EX75
ON VENDEDOR
FOR UPDATE
AS
DECLARE @CODA INT, 
		@SALANT NUMERIC(10, 2), @SALNOV NUMERIC(10, 2);

SELECT @CODA=CODIGO_VENDEDOR, @SALANT=SALARIO_FIXO
FROM DELETED
SELECT @SALNOV=SALARIO_FIXO
FROM INSERTED

IF (@SALANT!=@SALNOV)
	BEGIN INSERT INTO histsalario (codigo_vendedor, salario_fixo)
		VALUES (@CODA, @SALANT)
	END;


/* 76. Crie um trigger que ao inserir um registro da tabela item do pedido, calcule e armazene o seu subtotal.*/
CREATE TRIGGER EX76
ON ITEM_DO_PEDIDO
FOR INSERT
AS
DECLARE @CODPROD INT, @CODPED INT, @QTD NUMERIC(10, 2), @VAL NUMERIC(10, 2);

SELECT @CODPROD=codigo_produto, @CODPED=num_pedido, @QTD=QUANTIDADE 
FROM INSERTED

SELECT @VAL=val_unit 
FROM PRODUTO 
WHERE codigo_produto = @CODPROD;

UPDATE item_do_pedido
SET subtotal = @VAL * @QTD
where codigo_produto = @CODPROD AND num_pedido = @CODPED;

select * from produto
select * from item_do_pedido
insert into item_do_pedido values (97, 13, 50, null)
delete from item_do_pedido where num_pedido = 97 and codigo_produto = 13

select * from vendedor
select * from histsalario

update vendedor
set salario_fixo = 2490
where codigo_vendedor = 111

/* 77. Desenvolver um Trigger que ao ser alterado o endereço ou o cep do cliente 
insira o endereço e o cep antigo na tabela histórico do endereço do cliente.*/
CREATE TRIGGER EX77
ON CLIENTE FOR UPDATE
AS
DECLARE @CODCLI INT, @CEPA CHAR(10), @ENDA VARCHAR(50),
		@CEPN CHAR(10), @ENDN VARCHAR(50);

SELECT @CODCLI=CODIGO_CLIENTE, @CEPA=CEP, @ENDA=ENDERECO
FROM DELETED;

SELECT @CEPN=CEP, @ENDN=ENDERECO
FROM INSERTED;

IF (@CEPA != @CEPN OR @ENDA != @ENDN)
	BEGIN INSERT INTO histendercliente (CODIGO_CLIENTE, END_CLIENTE, CEP)
		VALUES (@CODCLI, @ENDA, @CEPA);
	END;

UPDATE Cliente
SET endereco='rua 4'
WHERE codigo_cliente=20

select * from cliente
select * from histendercliente

/* 78. Crie um trigger que ao alterar um registro da tabela item do pedido, calcule e atualize o seu subtotal. */
CREATE TRIGGER EX78
ON ITEM_DO_PEDIDO
FOR UPDATE
AS
DECLARE @NUMPED INT, @CODPROD INT,
		@QUANT NUMERIC(10, 2), @VALPROD NUMERIC(10, 2)

SELECT @NUMPED=NUM_PEDIDO, @CODPROD=CODIGO_PRODUTO, @QUANT=QUANTIDADE
FROM inserted

SELECT @VALPROD=VAL_UNIT
FROM PRODUTO
WHERE codigo_produto=@CODPROD

UPDATE item_do_pedido
SET subtotal = @VALPROD * @QUANT
where codigo_produto = @CODPROD AND num_pedido = @NUMPED;

-- TESTANDO
SELECT * FROM item_do_pedido;
SELECT * FROM PRODUTO;

UPDATE ITEM_DO_PEDIDO
SET codigo_produto = 22
where codigo_produto = 77 AND num_pedido = 97;


/* 79. Crie um Trigger que ao ser inserido um novo item do pedido atualize o campo quantidade em estoque da tabela produto. */
CREATE TRIGGER EX79
ON ITEM_DO_PEDIDO
FOR INSERT
AS
DECLARE @CODPROD INT, @QUANTITEM NUMERIC(10, 2)

SELECT @CODPROD=CODIGO_PRODUTO, @QUANTITEM=quantidade
FROM INSERTED;

UPDATE PRODUTO
SET quant_est = quant_est - @QUANTITEM
WHERE codigo_produto = @CODPROD;

-- TESTANDO
SELECT * FROM item_do_pedido;
SELECT * FROM PRODUTO;

INSERT INTO item_do_pedido (num_pedido, codigo_produto, quantidade, subtotal)
	VALUES (91, 13, 50, NULL)

/*80.Crie um Trigger que ao ser alterado um item do pedido atualize o campo quantidade 
em estoque da tabela produto.*/
CREATE TRIGGER EX80
ON ITEM_DO_PEDIDO
FOR UPDATE
AS
DECLARE @CODPRODN INT, @QUANTN NUMERIC,
		@CODPRODA INT, @QUANTA NUMERIC

SELECT @CODPRODN=codigo_produto, @QUANTN=quantidade
FROM INSERTED

SELECT @CODPRODA=codigo_produto, @QUANTA=quantidade
FROM DELETED

UPDATE PRODUTO
SET quant_est = quant_est + @QUANTA
WHERE codigo_produto=@CODPRODA

UPDATE PRODUTO
SET quant_est = quant_est - @QUANTN
WHERE codigo_produto=@CODPRODN