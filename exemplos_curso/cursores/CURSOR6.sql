--CRIA E POPULA TABELA DE TESTE
use curso
--DROP TABLE ##DADOS
 
CREATE TABLE ##DADOS 
(
  NUMERO int NULL,
  NOME VARCHAR(20),
 );
 
INSERT INTO ##DADOS VALUES (1,'Jack')
INSERT INTO ##DADOS VALUES (2,'Peter')
INSERT INTO ##DADOS VALUES (3,'Sam')
INSERT INTO ##DADOS VALUES (4,'Malcon')
INSERT INTO ##DADOS VALUES (5,'David')
INSERT INTO ##DADOS VALUES (6,'Marlos')
INSERT INTO ##DADOS VALUES (7,'Greg')
INSERT INTO ##DADOS VALUES (8,'Jorge')
INSERT INTO ##DADOS VALUES (9,'Richard')
INSERT INTO ##DADOS VALUES (10,'Anne')

-- select * from ##DADOS
--Declarando cursor
DECLARE cDados SCROLL CURSOR FOR
SELECT NUMERO,NOME FROM ##DADOS
 
--Abre cursor
OPEN cDados;
 
--Verifica a quantidade de linhas
SELECT @@CURSOR_ROWS;
 
--Primeiro registro do cursor
FETCH ABSOLUTE 1 FROM cDados;
 
--Pr�ximo registro
FETCH NEXT FROM cDados;
 
--�ltimo Registro
FETCH LAST FROM cDados;
 
--Retorna a linha anterior ao registro atual do cursor
FETCH PRIOR FROM cDados;
 
--Volta para a segunha linha do cursor
FETCH ABSOLUTE 2 FROM cDados;
 
--Avan�a tr�s registros em rela��o ao registro atual
FETCH RELATIVE 3 FROM cDados;
 
--Retrocede dois registros em rela��o ao registro atual
FETCH RELATIVE -2 FROM cDados;
 
CLOSE cDados;
DEALLOCATE cDados;