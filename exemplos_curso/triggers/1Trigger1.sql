--drop trigger TG_aud_sal
use curso
go
create trigger TG_aud_sal --unico registro
	on SALARIO 
		after UPDATE
	as
	Begin		
	
		declare @sal_antigo decimal(10,2)
		declare @sal_novo decimal(10,2)
		declare @matricula int
			
		select @matricula  = (select matricula from inserted)
		select @sal_antigo = (select SALARIO from deleted)
		select @sal_novo   = (select SALARIO from inserted)
							
	Insert into auditoria_salario 
	values 
	(@matricula, isnull(@sal_antigo,0), @sal_novo, SYSTEM_USER, getdate())
			
	end	

--TESTANDO TRIGGER
update salario set salario ='2500' where matricula='1'

update salario set salario ='3000' where matricula='2'

update salario set salario ='3500' where matricula='3'

update salario set salario ='4000' where matricula='4'


select * from auditoria_salario;

--verificando problema: esse trigger em espec�fico s� faz uma atualiza��o por vez. A do pr�ximo exerc�cio corrige isso
update salario set salario=salario*1.10;