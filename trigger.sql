CREATE TRIGGER trg_datos
ON cdc.dbo_Datos_CT
AFTER INSERT
AS
BEGIN
	SET NOCOUNT ON;
	DECLARE @operation int;
	DECLARE @datosID int;
	DECLARE @mensaje varchar(10);


	DECLARE cursorInserted CURSOR
	FOR SELECT __$operation, datosID, mensaje FROM inserted
	
	
	OPEN cursorInserted
	FETCH NEXT FROM cursorInserted INTO @operation, @datosID, @mensaje
	
		WHILE(@@FETCH_STATUS = 0)
			BEGIN	
				
				IF @operation = 1
					BEGIN
					DELETE Destino WHERE datosID = @datosID
				END				
				
				IF @operation = 2
				BEGIN
					INSERT INTO Destino(
						operation,
						datosID,
						mensaje
					)
					VALUES(
						@operation,
						@datosID,
						@mensaje
					)
					END
					
				IF @operation = 4
					BEGIN
					
					UPDATE Destino
					SET mensaje = @mensaje
					WHERE datosID = @datosID
				END
				
				FETCH NEXT FROM cursorInserted INTO @operation, @datosID, @mensaje
			END
	
	CLOSE cursorInserted
	DEALLOCATE cursorInserted

END