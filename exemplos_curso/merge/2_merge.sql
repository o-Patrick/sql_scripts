--MERGE SQL statement - Part 1

--Crianda tabela destino
use curso
go
--drop table produtos destino
CREATE TABLE produtos
(
cod_prod INT PRIMARY KEY,
descricao VARCHAR(100),
preco MONEY
) 
GO

--Inserindo dados na tabela
INSERT INTO produtos
VALUES
(1, 'Cha', 10.00),
(2, 'Caf�', 20.00),
(3, 'Leite',30.00),
(4, 'P�o', 40.00)
GO

INSERT INTO produtos
VALUES (6, 'Acucar', 10.00)
-- Criando tabela
--drop table produto_atualizados origem
CREATE TABLE produto_atualizados
(
cod_prod INT PRIMARY KEY,
descricao VARCHAR(100),
preco MONEY
) 
GO

--Inserindo dados na tabela
INSERT INTO produto_atualizados
VALUES
(1, 'Cha', 10.00),
(2, 'Caf�', 25.00),
(3, 'Leite', 35.00),
(5, 'Peixe', 60.00)
GO

INSERT INTO produto_atualizados
VALUES (6, 'Sal', 10.00)

SELECT * FROM produtos
SELECT * FROM produto_atualizados
GO


--MERGE SQL Declra�ao - Part 2
--Sincronizar a tabela destino
--atualizando com dados da origem
MERGE produtos AS destino
USING produto_atualizados AS origem 
ON (destino.cod_prod = origem.cod_prod) 

-- H� registro no destino e na origem
WHEN MATCHED AND destino.descricao <> origem.descricao 
OR destino.preco <> origem.preco THEN 
UPDATE SET destino.descricao = origem.descricao, 
destino.preco = origem.preco 

--Quando n�o h� registro no destino e h� na origem
WHEN NOT MATCHED BY TARGET THEN 
INSERT (cod_prod, descricao, preco) 
VALUES (origem.cod_prod, origem.descricao, origem.preco)

--Quando  h� registro no destino mas n�o h� na origem
WHEN NOT MATCHED BY SOURCE THEN 
DELETE
--$action especifica coluna  nvarchar(10) 
--OUTPUTRetorna informa��es ou express�es baseadas 
--em cada linha afetada por uma instru��o INSERT, UPDATE, DELETE ou MERGE
OUTPUT $action, 
DELETED.cod_prod AS Destino_cod_prod, 
DELETED.descricao AS Destino_descricao, 
DELETED.preco AS Destino_preco, 
INSERTED.cod_prod AS origem_cod_prod, 
INSERTED.descricao AS origem_descricao, 
INSERTED.preco AS origem_epreco; 

SELECT @@ROWCOUNT;
GO




SELECT * FROM produtos
SELECT * FROM produto_atualizados
GO