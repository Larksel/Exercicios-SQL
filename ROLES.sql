/* 1. Crie um papel chamado “Vendedor” com senha criptografada. */
CREATE ROLE VENDEDOR WITH ENCRYPTED PASSWORD '123';

/* 2. Altere o papel do vendedor e de permissão de superusuário e permita que realize login. */
ALTER ROLE VENDEDOR SUPERUSER LOGIN;

/* 3. Remova a permissão de superusuário para o vendedor, 
que não herde o privilégios dos papéis dos quais é membro. */
ALTER ROLE VENDEDOR NOSUPERUSER NOINHERIT

/* 4. Remova o papel vendedor. */
DROP ROLE VENDEDOR;

/* 5. Crie um papel com o nome de “Limitado” com senha criptografada, que não seja superusuário, 
que não tenha permissão para criar banco de dados e nem papéis, 
que não "herde" os privilégios dos papéis dos quais é membro, que possa realizar login, 
que possua apenas quatro conexões simultâneas, e que sua permissão seja concedida até 04/04/2025. */
CREATE ROLE LIMITADO WITH ENCRYPTED PASSWORD '123'
NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT LOGIN 
CONNECTION LIMIT 4
VALID UNTIL '04/04/2025';

/* 6. Crie os papéis chamados: “Vendedor”, “Secretária” e “Atendente”. 
Para todos os papéis crie uma senha criptografada, 
que não herde os privilégios dos papéis dos quais é membro e que possa realizar login. */
CREATE ROLE VENDEDOR WITH ENCRYPTED PASSWORD '123'
NOINHERIT LOGIN;
CREATE ROLE SECRETARIA WITH ENCRYPTED PASSWORD '123'
NOINHERIT LOGIN;
CREATE ROLE ATENDENTE WITH ENCRYPTED PASSWORD '123'
NOINHERIT LOGIN;

/* 7. Escreva os comandos para selecionar todos os papéis. */
SELECT *
FROM PG_USER;

/* 8. Crie um grupo chamado “funcionario”. */
CREATE GROUP FUNCIONARIO;

/* 9. Adicione no grupo todos os papéis (Vendedor, Secretária, Atendente e Limitado). */
ALTER GROUP FUNCIONARIO 
ADD USER VENDEDOR, SECRETARIA, ATENDENTE, LIMITADO;

/* 10. Exclua do grupo “funcionário” o papel limitado. */
ALTER GROUP FUNCIONARIO
DROP USER LIMITADO;

/* 11. Liste todos os grupos. */
SELECT * FROM PG_GROUP;

/* 12. No banco de dados vendas, remova todas as permissões das tabelas 
cliente, pedido, vendedor, item do pedido e produto. */
REVOKE ALL ON CLIENTE, PEDIDO, VENDEDOR, ITEM_DO_PEDIDO, PRODUTO
FROM PUBLIC;

/* 13. Conceda os privilégios de seleção, inserção e alteração da tabela cliente e vendedor 
para o papel secretária. */
GRANT SELECT, INSERT, UPDATE ON 
CLIENTE, VENDEDOR 
TO SECRETARIA;

/* 14. Faça o login com o papel secretária e realize a seleção da tabela cliente, vendedor e produto. 
Faça uma inserção de um registro na tabela cliente e depois remova este registro. 
Para cada operação escreva se a permissão foi concedida ou negada. */
SELECT * FROM CLIENTE; -- PERMISSÃO CONCEDIDA
SELECT * FROM VENDEDOR; -- PERMISSÃO CONCEDIDA
SELECT * FROM PRODUTO; -- PERMISSÃO NEGADA

INSERT INTO CLIENTE 
	VALUES (999, 'Fábio', 'Rua Três', 'Jales', '22841650', 'SP', '32176547/213-3', '9071'); -- PERMISSÃO CONCEDIDA
	
DELETE FROM CLIENTE
WHERE CODIGO_CLIENTE = 999; -- PERMISSÃO NEGADA

/* 15. Volte a entrar como usuário postgres e remova a permissão de 
selecionar, inserir e alterar a tabela vendedor para o papel secretária. */
REVOKE SELECT, INSERT, UPDATE
ON VENDEDOR
FROM SECRETARIA;

/* 16. Faça o login novamente com o papel secretária e realize a seleção da tabela cliente e vendedor.
Para cada operação escreva se a permissão foi concedida ou negada. */
SELECT * FROM CLIENTE; -- PERMISSÃO CONCEDIDA
SELECT * FROM VENDEDOR; -- PERMISSÃO NEGADA