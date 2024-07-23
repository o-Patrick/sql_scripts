/*
EXERC�CIO 1 
Crie o banco de dados treino com as tabelas conforme diagrama.
*/
DROP DATABASE TREINO;
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
EXERC�CIO 2 
Restaurar o arquivo  treino.bak no banco de dados criado.
*/
USE MASTER
RESTORE DATABASE TREINO FROM DISK =N'C:\Users\tickt\Desktop\exercicios_extras\TREINO.BAK'
WITH REPLACE
USE TREINO
GO

/*
EXERC�CIO 3 
Liste todos os clientes com seus nomes e com suas respectivas cidade e estados
*/

  
/*
EXERC�CIO 4 
Liste o c�digo do produto, descri��o do produto e descri��o das categorias dos produtos que tenham o valor unit�rio na 
faixa de R$ 10,00 a R$ 1500
*/

/*
EXERC�CIO 5 
Liste o c�digo do produto, descri��o do produto e descri��o da categorias dos produtos, e tamb�m apresente uma coluna condicional  com o  nome de "faixa de pre�o" 
Com os seguintes crit�rios
�	pre�o< 500 : valor da coluna ser�  igual  "pre�o abaixo de 500"
�	pre�o  >= 500 e <=1000 valor da coluna ser� igual  "pre�o entre 500 e 1000"
�	pre�o  > 1000 : valor da coluna ser� igual  "pre�o acima de 1000".
*/

/*
EXERC�CIO  6
Adicione a coluna faixa_salario na tabela vendedor tipo char(1)
*/

/*
EXERC�CIO 7 
Atualize o valor do campo faixa_salario da tabela vendedor com um update condicional .
Com os seguintes crit�rios
�	salario <1000 ,atualizar faixa = c
�	salario >=1000  and <2000 , atualizar faixa = b
�	salario >=2000  , atualizar faixa = a

**VERIFIQUE SE OS VALORES FORAM ATUALIZADOS CORRETAMENTE
*/

/*
EXERC�CIO 8
Listar em ordem alfab�tica os vendedores e seus respectivos sal�rios, mais uma coluna, simulando aumento de 12% em seus sal�rios.
*/


/*EXERC�CIO 9
Listar os nome dos vendedores, sal�rio atual , coluna calculada com salario novo + reajuste de 18% sobre o sal�rio atual, calcular  a coluna acr�scimo e calcula uma coluna salario novo+ acresc.
Crit�rios
Se o vendedor for  da faixa �C�, aplicar  R$ 120 de acr�scimo , outras faixas de salario acr�scimo igual a 0(Zero )
*/

/*
EXERC�CIO 10
Listar o nome e sal�rios do vendedor com menor salario.
*/

/*
EXERC�CIO 11
Quantos vendedores ganham acima de R$ 2.000,00 de sal�rio fixo?
*/
/*
EXERC�CIO 12
Adicione o campo valor_total tipo decimal(10,2) na tabela venda.
*/

/*
EXERC�CIO 13
Atualize o campo valor_tota da tabela venda, com a soma dos produtos das respectivas vendas.
*/

/*
EXERC�CIO 14
Realize a conferencia do exerc�cio anterior, certifique-se que o valor  total de cada venda e igual ao valor total da soma dos  produtos da venda, listar as vendas em que ocorrer diferen�a.
*/

/*
EXERC�CIO 15
Listar o n�mero de produtos existentes, valor total , m�dia do valor unit�rio referente ao m�s 07/2018 agrupado por venda.
*/

/*
EXERC�CIO 16
Listar o n�mero de vendas, Valor do ticket m�dio, menor ticket e maior ticket referente ao m�s 07/2017.
*/



/*
EXERC�CIO 17
Atualize o status das notas abaixo de normal(N) para cancelada (C)
--15,34,80,104,130,159,180,240,350,420,422,450,480,510,530,560,600,640,670,714

*/

/*
EXERC�CIO 18
Quais clientes realizaram mais de 70 compras?
*/

/*
EXERC�CIO 19
Listar os produtos que est�o inclu�dos em vendas que a quantidade total de produtos seja superior a 100 unidades.
*/

/*
EXERC�CIO 20
Trazer total de vendas do ano 2017 por categoria e apresentar total geral
*/

/*
EXERC�CIO 21
Listar total de vendas do ano 2017 por categoria e m�s a m�s apresentar subtotal dos meses e total geral ano.
*/

/*
EXERC�CIO 22
Listar total de vendas por vendedores referente ao ano 2017, m�s a m�s apresentar subtotal do m�s e total geral.
*/

/*
EXERC�CIO 23
Listar os top 10 produtos mais vendidos por valor total de venda com suas respectivas categorias
*/

/*
EXERC�CIO 24
Listar os top 10 produtos mais vendidos por valor total de venda com suas respectivas categorias, calcular seu percentual de participa��o com rela��o ao total geral.
*/

/*
EXERC�CIO 25
Listar apenas o produto mais vendido de cada M�s com seu  valor total referente ao ano de 2017.
*/

/*
EXERC�CIO 26
Lista o cliente e a data da �ltima compra de cada cliente.
*/

/*
EXERC�CIO 27
Lista o a data da �ltima venda de cada produto.
*/
