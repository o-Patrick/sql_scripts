--Retornar apenas o conte�do est�tico
--drop procedure PROC_OLA
use curso
CREATE PROCEDURE PROC_OLA
AS
BEGIN
	SELECT 'O FAMOSO Ola Mundo!'
END


--Executando Procedure
EXECUTE PROC_OLA
