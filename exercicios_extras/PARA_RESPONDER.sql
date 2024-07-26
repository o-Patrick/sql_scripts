/*
EXERCÍCIO 1 
Crie o banco de dados treino com as tabelas conforme diagrama.
*/
CREATE DATABASE TREINO;
GO
USE TREINO;

-- Criando tabela de cidades
CREATE TABLE CIDADE
(
	ID_CIDADE INT IDENTITY(1, 1) NOT NULL,
	NOME_CIDADE VARCHAR(60) NOT NULL,
	UF CHAR(2) NOT NULL UNIQUE,
	CONSTRAINT PK_CIDADE1 PRIMARY KEY (ID_CIDADE)
);

-- Criando tabela de vendedores
CREATE TABLE VENDEDOR
(
	ID_VENDEDOR INT IDENTITY(1, 1) NOT NULL,
	NOME_VENDEDOR VARCHAR(60) NOT NULL,
	SALARIO DECIMAL(10, 2) NOT NULL,
	CONSTRAINT PK_VENDEDOR1 PRIMARY KEY (ID_VENDEDOR)
);

-- Criando tabela de categorias de produtos
CREATE TABLE CATEGORIA
(
	ID_CATEGORIA INT IDENTITY(1, 1) NOT NULL,
	NOME_CATEGORIA VARCHAR(20) NOT NULL UNIQUE,
	CONSTRAINT PK_CATEGORIA1 PRIMARY KEY (ID_CATEGORIA)
);

-- Criando tabela de unidade de medida
CREATE TABLE UNIDADE
(
	ID_UNIDADE VARCHAR(3) NOT NULL,
	DESC_UNIDADE VARCHAR(25) NOT NULL UNIQUE,
	CONSTRAINT PK_UNIDADE1 PRIMARY KEY (ID_UNIDADE)
);

-- Criando tabela de clientes
CREATE TABLE CLIENTE
(
	ID_CLIENTE INT IDENTITY(1, 1) NOT NULL,
	NOME_CLIENTE VARCHAR(60) NOT NULL,
	ENDERECO VARCHAR(60) NOT NULL,
	NUMERO VARCHAR(10) NOT NULL,
	ID_CIDADE INT,
	CEP VARCHAR(9),
	CONSTRAINT PK_CLIENTE1 PRIMARY KEY (ID_CLIENTE),
	CONSTRAINT FK_CLIENTE1 FOREIGN KEY (ID_CIDADE)
		REFERENCES CIDADE(ID_CIDADE)
);

-- Criando tabela de vendas
CREATE TABLE VENDA
(
	NUM_VENDA INT IDENTITY(1, 1) NOT NULL,
	DATA_VENDA DATETIME NOT NULL,
	ID_CLIENTE INT NOT NULL,
	ID_VENDEDOR INT NOT NULL,
	STATUS CHAR(1),
	CONSTRAINT PK_VENDA1 PRIMARY KEY (NUM_VENDA),
	CONSTRAINT FK_VENDA1 FOREIGN KEY (ID_CLIENTE)
		REFERENCES CLIENTE(ID_CLIENTE),
	CONSTRAINT FK_VENDA2 FOREIGN KEY (ID_VENDEDOR)
		REFERENCES VENDEDOR(ID_VENDEDOR)
);

-- Criando tabela de produtos
CREATE TABLE PRODUTO
(
	ID_PRODUTO INT IDENTITY(1, 1) NOT NULL,
	NOME_PRODUTO VARCHAR(50) NOT NULL UNIQUE,
	ID_CATEGORIA INT NOT NULL,
	ID_UNIDADE VARCHAR(3) NOT NULL,
	PRECO DECIMAL(10, 2) NOT NULL,
	CONSTRAINT PK_PRODUTO PRIMARY KEY (ID_PRODUTO),
	CONSTRAINT FK_PRODUTO1 FOREIGN KEY (ID_CATEGORIA)
		REFERENCES CATEGORIA(ID_CATEGORIA),
	CONSTRAINT FK_PRODUTO2 FOREIGN KEY (ID_UNIDADE)
		REFERENCES UNIDADE(ID_UNIDADE)
);

-- Criando tabela de detalhes de vendas e itens
CREATE TABLE VENDA_ITENS
(
	NUM_VENDA INT NOT NULL,
	NUM_SEQ INT NOT NULL,
	ID_PRODUTO INT NOT NULL,
	QTDE DECIMAL(10, 2),
	VAL_UNIDADE DECIMAL(10, 2),
	VAL_TOTAL DECIMAL(10, 2),
	CONSTRAINT PK_VENDA_ITENS1 PRIMARY KEY (NUM_VENDA, NUM_SEQ),
	CONSTRAINT FK_VENDA_ITENS1 FOREIGN KEY (NUM_VENDA)
		REFERENCES VENDA (NUM_VENDA),
	CONSTRAINT FK_VENDA_ITENS2 FOREIGN KEY (ID_PRODUTO)
		REFERENCES PRODUTO(ID_PRODUTO)
);

/*
EXERCÍCIO 2 
Restaurar o arquivo  treino.bak no banco de dados criado.
*/
USE MASTER
RESTORE DATABASE TREINO FROM DISK =N'C:\Users\tickt\OneDrive\OneDrive\1_estudos\udemy\sqlsvr\sql_scripts\exercicios_extras\TREINO.BAK'
	WITH REPLACE;
USE TREINO;
GO

/*
EXERCÍCIO 3 
Liste todos os clientes com seus nomes e com suas respectivas cidade e estados
*/
SELECT CLI.NOME_CLIENTE, CID.NOME_CIDADE, CID.UF
	FROM CLIENTE AS CLI
	JOIN CIDADE AS CID
		ON CLI.ID_CIDADE = CID.ID_CIDADE;
  
/*
EXERCÍCIO 4 
Liste o código do produto, descrição do produto e descrição das categorias dos produtos que tenham o valor unitário na 
faixa de R$ 10,00 a R$ 1500
*/
SELECT ID_PROD, NOME_PRODUTO, NOME_CATEGORIA, P.PRECO
	FROM PRODUTOS AS P
	JOIN CATEGORIA AS C
		ON P.ID_CATEGORIA = C.ID_CATEGORIA
	WHERE P.PRECO BETWEEN 10 AND 1500
	ORDER BY PRECO;

/*
EXERCÍCIO 5 
Liste o código do produto, descrição do produto e descrição da categorias dos produtos, e também apresente uma coluna condicional  com o  nome de "faixa de preço" 
Com os seguintes critérios
•	preço < 500: valor da coluna será  igual "preço abaixo de 500"
•	preço >= 500 e <= 1000: valor da coluna será igual "preço entre 500 e 1000"
•	preço > 1000: valor da coluna será igual "preço acima de 1000".
*/
-- Função que determina a faixa de preço de um produto
CREATE FUNCTION FAIXA_PRECO(@PRECO INT)
	RETURNS VARCHAR(22)
	AS
		BEGIN
			DECLARE @MSG VARCHAR(22);

			IF @PRECO < 500
				SET @MSG = 'Preço abaixo de 500'
			ELSE IF @PRECO BETWEEN 500 AND 1000
				SET @MSG = 'Preço entre 500 e 1000'
			ELSE
				SET @MSG = 'Preço acima de 1000';

			RETURN @MSG;
		END;

-- Mostra os registros com coluna de faixa de preço
SELECT P.ID_PROD, P.NOME_PRODUTO, C.NOME_CATEGORIA,
	DBO.FAIXA_PRECO(P.PRECO) AS 'FAIXA DE PREÇO'
	FROM PRODUTOS AS P
	JOIN CATEGORIA AS C
		ON P.ID_CATEGORIA = C.ID_CATEGORIA
	ORDER BY P.PRECO;


/*
EXERCÍCIO  6
Adicione a coluna faixa_salario na tabela vendedor tipo char(1)
*/
ALTER TABLE VENDEDORES ADD FAIXA_SALARIO CHAR(1);

/*
EXERCÍCIO 7 
Atualize o valor do campo faixa_salario da tabela vendedor com um update condicional .
Com os seguintes critérios
•	salario <1000 ,atualizar faixa = c
•	salario >=1000  and <2000 , atualizar faixa = b
•	salario >=2000  , atualizar faixa = a

**VERIFIQUE SE OS VALORES FORAM ATUALIZADOS CORRETAMENTE
*/
UPDATE VENDEDORES SET FAIXA_SALARIO =
	CASE
		WHEN SALARIO < 1000 THEN 'C'
		WHEN SALARIO >= 1000 AND SALARIO < 2000 THEN 'B'
		WHEN SALARIO >= 2000 THEN 'A'
	END;

SELECT SALARIO, FAIXA_SALARIO FROM VENDEDORES ORDER BY SALARIO;

/*
EXERCÍCIO 8
Listar em ordem alfabética os vendedores e seus respectivos salários, mais uma coluna, simulando aumento de 12% em seus salários.
*/
SELECT NOME_VENDEDOR, SALARIO, CAST((SALARIO * 1.12) AS DECIMAL(10, 2)) AS 'Aumento 12%' FROM VENDEDORES;

/*EXERCÍCIO 9
Listar os nomes dos vendedores, salário atual , coluna calculada com salario novo + reajuste de 18% sobre o salário atual, calcular  a coluna acréscimo e calcular uma coluna salario novo+ acresc.
Critérios
Se o vendedor for  da faixa “C”, aplicar  R$ 120 de acréscimo , outras faixas de salario acréscimo igual a 0(Zero )
*/
-- DECLARAÇÃO DE VARIÁVEIS DE REAJUSTE E ACRÉSCIMO
DECLARE @PCT_REAJUSTE DECIMAL(3, 2);
DECLARE @ACRES INT;
SET @PCT_REAJUSTE = 0.18;
SET @ACRES = 120;

SELECT
	NOME_VENDEDOR,
	SALARIO,
	FAIXA_SALARIO,
	(SALARIO * (1 + @PCT_REAJUSTE))
		AS SALARIO_NOVO,
	(CASE WHEN FAIXA_SALARIO = 'C' THEN 120 ELSE 0 END)
		AS ACRESCIMO,
	(CASE WHEN FAIXA_SALARIO = 'C' THEN (SALARIO * (1 + @PCT_REAJUSTE) + @ACRES) ELSE (SALARIO * (1 + @PCT_REAJUSTE)) END)
		AS 'SALARIO + ACRESCIMO'
	FROM VENDEDORES
	ORDER BY SALARIO;

/*
EXERCÍCIO 10
Listar o nome e salários do vendedor com menor salario.
*/
SELECT TOP 1 NOME_VENDEDOR, SALARIO FROM VENDEDORES ORDER BY SALARIO;

/*
EXERCÍCIO 11
Quantos vendedores ganham acima de R$ 2.000,00 de salário fixo?
*/
SELECT COUNT(ID_VENDEDOR) FROM VENDEDORES WHERE SALARIO >= 2000;

/*
EXERCÍCIO 12
Adicione o campo valor_total tipo decimal(10,2) na tabela venda.
*/
ALTER TABLE VENDAS ADD VALOR_TOTAL DECIMAL(10, 2);

/*
EXERCÍCIO 13
Atualize o campo valor_total da tabela venda, com a soma dos produtos das respectivas vendas.
*/
UPDATE VENDAS SET VENDAS.VALOR_TOTAL =
	(SELECT SUM(VI.VAL_TOTAL) FROM VENDA_ITENS AS VI
		WHERE VENDAS.NUM_VENDA = VI.NUM_VENDA);

/*
EXERCÍCIO 14
Realize a conferência do exercício anterior, certifique-se que o valor  total de cada venda é igual ao valor total da soma dos  produtos da venda, listar as vendas em que ocorrer diferença.
*/
-- DESTRINCHANDO VENDAS
SELECT V.NUM_VENDA, V.VALOR_TOTAL, VI.VAL_TOTAL
	FROM VENDAS AS V
	JOIN VENDA_ITENS AS VI
		ON V.NUM_VENDA = VI.NUM_VENDA;

-- VISÃO GERAL
SELECT * FROM VENDAS;

-- SELECIONANDO TOTAIS DISCREPANTES
SELECT V.NUM_VENDA, V.VALOR_TOTAL, SUM(VI.VAL_TOTAL) AS VAL_TOTAL_ITENS
	FROM VENDAS AS V
	JOIN VENDA_ITENS AS VI
		ON V.NUM_VENDA = VI.NUM_VENDA
	GROUP BY V.NUM_VENDA, V.VALOR_TOTAL
		HAVING V.VALOR_TOTAL <> SUM(VI.VAL_TOTAL);

/*
EXERCÍCIO 15
Listar o número de produtos existentes, valor total , média do valor unitário referente ao mês 07/2018 agrupado por venda.
*/
SELECT
	V.NUM_VENDA,
	COUNT(VI.NUM_SEQ) AS QTD_SKU,
	SUM(VI.QTDE) AS QTDE,
	CAST(AVG(VI.VAL_UNIT) AS DECIMAL(10, 2)) AS MEDIA_VAL_UNI,
	V.VALOR_TOTAL
	FROM VENDAS AS V
	JOIN VENDA_ITENS AS VI
		ON V.NUM_VENDA = VI.NUM_VENDA
	WHERE MONTH(V.DATA_VENDA) = 7 AND YEAR(V.DATA_VENDA) = 2018
	GROUP BY V.NUM_VENDA, V.VALOR_TOTAL;

/*
EXERCÍCIO 16
Listar o número de vendas, Valor do ticket médio, menor ticket e maior ticket referente ao mês 07/2017.
*/

SELECT
	COUNT(NUM_VENDA) AS NUMERO_VENDAS,
	CAST(AVG(VALOR_TOTAL) AS DECIMAL(10, 2)) AS TICKET_MEDIO,
	MIN(VALOR_TOTAL) AS MENOR_TICKET,
	CAST(MAX(VALOR_TOTAL) AS DECIMAL(10, 2)) AS MAIOR_TICKET
	FROM VENDAS
	WHERE MONTH(DATA_VENDA) = 7 AND YEAR(DATA_VENDA) = 2017;

/*
EXERCÍCIO 17
Atualize o status das notas abaixo de normal(N) para cancelada (C)
--15,34,80,104,130,159,180,240,350,420,422,450,480,510,530,560,600,640,670,714
*/
UPDATE VENDAS SET STATUS = 'C'
	WHERE NUM_VENDA IN (15, 34, 80, 104, 130, 159, 180, 240, 350, 420, 422, 450, 480, 510, 530, 560, 600, 640, 670, 714);

-- Conferindo
SELECT NUM_VENDA, STATUS FROM VENDAS WHERE STATUS = 'C';

/*
EXERCÍCIO 18
Quais clientes realizaram mais de 70 compras?
*/
SELECT C.NOME_CLIENTE, COUNT(V.NUM_VENDA) AS QTD_VENDAS
	FROM VENDAS AS V
	JOIN CLIENTE AS C
		ON V.ID_CLIENTE = C.ID_CLIENTE
	WHERE V.STATUS = 'N'
	GROUP BY C.NOME_CLIENTE HAVING COUNT(V.NUM_VENDA) > 70
	ORDER BY 2 DESC;

/*
EXERCÍCIO 19
Listar os produtos que estão incluídos em vendas que a quantidade total de produtos seja superior a 100 unidades.
*/
-- TERMINAR
SELECT
	P.NOME_PRODUTO,
	COUNT(VI.ID_PROD) AS QTD_PRODUTOS
	FROM PRODUTOS AS P
	JOIN VENDA_ITENS AS VI
		ON P.ID_PROD = VI.ID_PROD
	WHERE 
	GROUP BY P.NOME_PRODUTO;
-- TERMINAR

/*
EXERCÍCIO 20
Trazer total de vendas do ano 2017 por categoria e apresentar total geral
*/

/*
EXERCÍCIO 21
Listar total de vendas do ano 2017 por categoria e mês a mês apresentar subtotal dos meses e total geral ano.
*/

/*
EXERCÍCIO 22
Listar total de vendas por vendedores referente ao ano 2017, mês a mês apresentar subtotal do mês e total geral.
*/

/*
EXERCÍCIO 23
Listar os top 10 produtos mais vendidos por valor total de venda com suas respectivas categorias
*/

/*
EXERCÍCIO 24
Listar os top 10 produtos mais vendidos por valor total de venda com suas respectivas categorias, calcular seu percentual de participação com relação ao total geral.
*/

/*
EXERCÍCIO 25
Listar apenas o produto mais vendido de cada Mês com seu  valor total referente ao ano de 2017.
*/

/*
EXERCÍCIO 26
Lista o cliente e a data da última compra de cada cliente.
*/

/*
EXERCÍCIO 27
Lista a data da última venda de cada produto.
*/
