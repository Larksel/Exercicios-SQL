/* 1 - Crie uma view para selecionar todos os dados do Nível, Cargo, Cliente e Região. */
CREATE VIEW EX_01
AS
SELECT N.*, CAR.area, CAR.cod_area, CAR.quadro, CAR.bonus, CAR.contratacao, CLI.*
FROM NIVEL N INNER JOIN CARGO CAR
	ON N.cod_nivel = CAR.cod_nivel
	INNER JOIN CLIENTE CLI
	ON CAR.cod_cargo = CLI.cod_cargo_responsavel
	INNER JOIN CEP
	ON CLI.cep = CEP.cep

/* 2 - Elabora uma view que mostre a quantidade de clientes em cada Região */
CREATE VIEW EX_02
AS
SELECT CEP.REGIAO, COUNT(C.cod_cliente) AS "Quantidade Cliente"
FROM CEP INNER JOIN CLIENTE C
	ON CEP.cep = C.cep
GROUP BY CEP.regiao

CREATE VIEW EX_03 AS
	SELECT DESCRICAO_NIVEL, SUM(F.salario_base+F.beneficios+F.vt+F.vr+F.impostos) AS "Soma"
	FROM NIVEL N INNER JOIN CARGO C
		ON N.cod_nivel = C.cod_nivel
		INNER JOIN FUNCIONARIO F
		ON C.cod_cargo = F.cod_cargo
	GROUP BY DESCRICAO_NIVEL
	
/* 4 - Elabora uma view que mostre a quantidade de Funcionários para cada: */
/* A - Estado */
CREATE VIEW EX_04_A AS
	SELECT CEP.estado, COUNT(F.cod_rh) AS "Quantidade Funcionario"
	FROM FUNCIONARIO F INNER JOIN CEP
		ON F.cep = CEP.cep
	GROUP BY CEP.estado

/* B - Contratação */
CREATE VIEW EX_04_A AS
	SELECT C.contratacao, COUNT(F.cod_rh) AS "Quantidade Funcionario"
	FROM FUNCIONARIO F INNER JOIN CARGO C
		ON F.cod_cargo = C.cod_cargo
	GROUP BY C.contratacao

/* 5 - Elaborar uma view que mostre a quantidade de Clientes para cada: */
/* A - Região */
CREATE VIEW EX_05_A AS
	SELECT CEP.regiao, COUNT(C.cod_cliente) AS "Quantidade Cliente"
	FROM CLIENTE C INNER JOIN CEP
		ON C.cep = CEP.cep
	GROUP BY CEP.regiao
	
/* B - Área */
CREATE VIEW EX_05_B AS
	SELECT CA.area, COUNT(C.cod_cliente) AS "Quantidade Cliente"
	FROM CLIENTE C INNER JOIN CARGO CA
		ON C.cod_cargo_responsavel = CA.cod_cargo
	GROUP BY CA.area
	
/* C - Descrição Nível */
CREATE VIEW EX_05_C AS
	SELECT N.descricao_nivel, COUNT(C.cod_cliente) AS "Quantidade Cliente"
	FROM CLIENTE C INNER JOIN CARGO CA
		ON C.cod_cargo_responsavel = CA.cod_cargo
		INNER JOIN NIVEL N
		ON CA.cod_nivel = N.cod_nivel
	GROUP BY N.descricao_nivel
	
/* 6 - Elabora uma view que mostre o total do valor de contrato anual do cliente por descrição nível. */
CREATE VIEW EX_06 AS
	SELECT N.descricao_nivel, SUM(C.valor_contrato_anual) AS "Total Contrato Anual"
	FROM CLIENTE C INNER JOIN CARGO CA
		ON C.cod_cargo_responsavel = CA.cod_cargo
		INNER JOIN NIVEL N
		ON CA.cod_nivel = N.cod_nivel
	GROUP BY N.descricao_nivel
	
/* 7 - Faça uma view que mostre todos os dados dos níveis, cargos e funcionários e 
	   calcule Salário Total = SalárioBase+Impostos+Benefícios+VT+VR) */
CREATE VIEW EX_07 AS
	SELECT F.*, CA.area, CA.cod_area AS "cod_area_cargo", CA.quadro, CA.bonus, CA.contratacao, 
		   N.*, F.salario_base+F.impostos+F.beneficios+F.vt+F.vr AS "Salario Total"
	FROM FUNCIONARIO F INNER JOIN CARGO CA
		ON F.cod_cargo = CA.cod_cargo
		INNER JOIN NIVEL N
		ON CA.cod_nivel = N.cod_nivel
		
/* 8 - Faça uma view mostre: 
-Soma do Salário Base
-Soma do Salário Total = SalárioBase+Impostos+Benefícios+VT+VR
-Soma do Total de Dias Trabalhados = soma (Dias ÚteisTrabalhados Ano Orçamentário)*/
/* A - Para cada cargo */
CREATE VIEW EX_08_A AS
	SELECT COD_CARGO, SUM(SALARIO_BASE) AS "soma_salario_base", SUM("Salario Total") AS "soma_salario_total", SUM(DIAS_UTEIS_TRABALHADOS_ANO_ORCAMENTARIO) AS "total_dias_trabalhados"
	FROM EX_07
	GROUP BY COD_CARGO
	
/* B - Para cada região */
CREATE VIEW EX_08_B AS
	SELECT CEP.regiao, SUM(SALARIO_BASE) AS "soma_salario_base", SUM("Salario Total") AS "soma_salario_total", SUM(DIAS_UTEIS_TRABALHADOS_ANO_ORCAMENTARIO) AS "total_dias_trabalhados"
	FROM EX_07 E INNER JOIN CEP
		ON E.cep = CEP.cep
	GROUP BY CEP.regiao
	
/* C - Para cada descrição do nível */
CREATE VIEW EX_08_C AS
	SELECT DESCRICAO_NIVEL, SUM(SALARIO_BASE) AS "soma_salario_base", SUM("Salario Total") AS "soma_salario_total", SUM(DIAS_UTEIS_TRABALHADOS_ANO_ORCAMENTARIO) AS "total_dias_trabalhados"
	FROM EX_07
	GROUP BY DESCRICAO_NIVEL