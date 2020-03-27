-- Este Script activa el CDC en nuestra base de datos y lo asociamos a una tabla para capturar todos sus cambios.
-- IMPORTANTE: SQL SERVER AGENT DEBE ESTAR ACTIVADO

-- Activamos cdc en la Base de Datos
EXEC sys.sp_cdc_enable_db

-- Asociamos el CDC a nuestra tabla
EXEC sys.sp_cdc_enable_table  
@source_schema = N'dbo',  -- En 'dbo' debe ir el schema de nuestra tabla
@source_name   = N'Tabla',  -- En 'Tabla' va el nombre de la tabla
@index_name = N'campo_primary_key' -- En caso de que no exista un campo Primary Key en la tabla hay que asignar un campo que sea unico
@role_name     = NULL,   
@supports_net_changes = 1