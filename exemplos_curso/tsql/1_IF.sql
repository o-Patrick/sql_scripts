--Comando IF

IF�1�=�1
	BEGIN���
		PRINT�'Correto��TRUE'�
	END�
	ELSE�
		PRINT�'Errado��FALSE';

--IF AND
IF�1�=�1 AND� 2�<>�2�
	BEGIN���
		PRINT�'Correto��TRUE'�
	END�
	ELSE�
		PRINT�'Errado��FALSE';

--�exemplo And
IF�1�=�1�AND�2�=�17�
	BEGIN��
		�PRINT�'Correto��TRUE'�
	END�
	ELSE�
		PRINT�'Errado��FALSE';

--Terceiro exemplo OR IF ELSE
IF�1�<>�1�OR�2�=�17�
	BEGIN��
		�PRINT�'Correto��TRUE'�
	END�
	ELSE
		PRINT�'Errado��FALSE';
		
--4 Exemplo 

use curso

--Teste com IF ELSE
DECLARE @id_aluno int;
SET @id_aluno='4';
IF�(SELECT�Count(*)�����
	FROM���matricula�����WHERE��id_aluno�=�@id_aluno )�=�0
		BEGIN���
			PRINT�'Aluno n�o Matriculado'�
		END
		ELSE���
		BEGIN�������
		PRint 'Disciplina Matriculadas';
		SELECT b.nome_disc,a.periodo  from matricula a 
		inner join disciplina b
		on a.id_disciplina=b.id_disciplina
		and a.id_aluno=@id_aluno  �
		END�;

--IF 
--�Declara��o�da�vari�vel�
	DECLARE�@Idade�INT;�
--�Atribui��o�do�valor�a�vari�vel
	SET�@Idade=17;�
--�Se...�for�menor�que�18�anos
	IF�@Idade�<�18�
		PRINT�'Menor�que�18�anos';�
--�Se�n�o�...�
	ELSE�IF�@Idade�>=18 and @Idade<65
		PRINT 'Maior que 18 anos'; 
	ELSE  
		PRINT 'Maior que 65 anos'; 
