--Criando fun��o escalar TRIM
--drop function Trim
USE curso;
go
--drop FUNCTION FN_Trim;

CREATE�FUNCTION�FN_Trim(@ST�VARCHAR(1000))�
 returns�VARCHAR(1000)���
  BEGIN�������
	RETURN(Ltrim(Rtrim(@ST)))���
  END;




--Invocando fun��o escalar TRIM
SELECT�'>'�+�('      Silva Telles       ')+'<'
union
SELECT�'>'�+�dbo.FN_Trim('      Silva Telles       ')+'<'



--PARA ALTERAR FUN��O
ALTER �FUNCTION�FN_Trim(@ST�VARCHAR(500))�
 returns�VARCHAR(500)���
  BEGIN�������
	RETURN(Ltrim(Rtrim(@ST)))���
  END

--APAGAR FUN��O
DROP FUNCTION FN_Tri;

